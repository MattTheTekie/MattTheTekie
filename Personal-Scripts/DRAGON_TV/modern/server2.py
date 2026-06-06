from fastapi import FastAPI, Query, HTTPException
from fastapi.responses import PlainTextResponse, JSONResponse
import requests
import m3u8
from urllib.parse import urlparse, urljoin
import uvicorn

app = FastAPI()


def fetch_m3u(url: str):
    headers = {"User-Agent": "Mozilla/5.0"}
    try:
        r = requests.get(url, timeout=10, headers=headers, allow_redirects=True)
        r.raise_for_status()
        return r.text, r.url  # return final resolved URL
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Failed to fetch URL: {str(e)}")


def compute_base_url(final_url: str):
    parsed = urlparse(final_url)
    base_path = parsed.path.rsplit("/", 1)[0] + "/"
    return f"{parsed.scheme}://{parsed.netloc}{base_path}"


def parse_streams(m3u_text: str, final_url: str):
    playlist = m3u8.M3U8(m3u_text)

    # FIX: use final resolved URL, not the jmp2.uk redirect
    base_url = compute_base_url(final_url)

    streams = []

    for seg in playlist.playlists:
        stream_info = seg.stream_info

        resolution = None
        if stream_info and stream_info.resolution:
            resolution = f"{stream_info.resolution[0]}x{stream_info.resolution[1]}"

        # FIX: correct Pluto TV URL
        uri = urljoin(base_url, seg.uri)

        streams.append({
            "resolution": resolution or "unknown",
            "bandwidth": stream_info.bandwidth if stream_info else None,
            "uri": uri
        })

    return streams


@app.get("/resolutions", response_class=JSONResponse)
def get_resolutions(url: str = Query(...)):
    m3u_text, final_url = fetch_m3u(url)
    streams = parse_streams(m3u_text, final_url)

    return {
        "count": len(streams),
        "resolutions": [
            {"resolution": s["resolution"], "bandwidth": s["bandwidth"]}
            for s in streams
        ]
    }


@app.get("/playlist", response_class=PlainTextResponse)
def build_playlist(url: str = Query(...), resolution: str = Query(None)):
    m3u_text, final_url = fetch_m3u(url)
    streams = parse_streams(m3u_text, final_url)

    if not streams:
        raise HTTPException(status_code=404, detail="No streams found")

    def get_height(s):
        if s["resolution"] == "unknown":
            return 999999
        return int(s["resolution"].split("x")[1])

    if resolution:
        target = int(resolution)
        selected = sorted(streams, key=lambda s: abs(get_height(s) - target))[0]
    else:
        selected = sorted(streams, key=get_height)[0]

    output = [
        "#EXTM3U",
        f'#EXT-X-STREAM-INF:BANDWIDTH={selected["bandwidth"] or 0},RESOLUTION={selected["resolution"]}',
        selected["uri"]
    ]

    return "\n".join(output)


if __name__ == "__main__":
    uvicorn.run("server:app", host="0.0.0.0", port=8000, reload=True)
