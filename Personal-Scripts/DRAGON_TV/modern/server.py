import os
import time
import threading
import requests
from flask import Flask, Response, request, jsonify

# =========================
# CONFIG
# =========================

PORT = int(os.getenv("PORT", 8080))
CACHE_TIMEOUT = 60 * 45  # 45 minutes

app = Flask(__name__)

# =========================
# CACHE
# =========================

CACHE = {}
LOCK = threading.Lock()

# =========================
# DOWNLOAD
# =========================

def download_m3u(url):
    r = requests.get(
        url,
        timeout=30,
        headers={"User-Agent": "Mozilla/5.0"}
    )
    r.raise_for_status()
    return r.text


def get_m3u(url):
    now = time.time()

    with LOCK:
        cached = CACHE.get(url)
        if cached and (now - cached["time"] < CACHE_TIMEOUT):
            return cached["data"]

    data = download_m3u(url)

    with LOCK:
        CACHE[url] = {
            "time": now,
            "data": data
        }

    return data

# =========================
# FILTER
# =========================

def filter_m3u(text, filters):
    filters = [f.lower() for f in filters]

    out = ["#EXTM3U\n"]

    current_extinf = None
    keep = False

    for line in text.splitlines():
        line = line.strip()

        if not line:
            continue

        if line.startswith("#EXTINF"):
            current_extinf = line

            if not filters:
                keep = True
            else:
                keep = any(f in line.lower() for f in filters)

            continue

        if keep and current_extinf and not line.startswith("#"):
            out.append(current_extinf + "\n")
            out.append(line + "\n")

            current_extinf = None
            keep = False

    return "".join(out)

# =========================
# ROUTES
# =========================

@app.route("/")
def index():
    return "", 204


@app.route("/playlist.m3u8")
def playlist():
    url = request.args.get("url")

    if not url:
        return "missing url", 400

    filters = request.args.getlist("f")

    try:
        m3u = get_m3u(url)
        result = filter_m3u(m3u, filters)

        return Response(
            result,
            mimetype="application/vnd.apple.mpegurl",
            headers={"Cache-Control": "no-cache"}
        )

    except Exception as e:
        return str(e), 500

# =========================
# STARTUP
# =========================

if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=PORT,
        threaded=True
    )
