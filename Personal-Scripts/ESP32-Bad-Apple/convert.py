import cv2
import os

def convert(input_video, out_dir):
    cap = cv2.VideoCapture(input_video)

    width, height = 128, 64
    target_fps = 8
    source_fps = cap.get(cv2.CAP_PROP_FPS)
    skip = max(1, round(source_fps / target_fps))

    os.makedirs(out_dir, exist_ok=True)

    frame_id = 0
    i = 0

    print("processing...")

    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break

        if i % skip == 0:
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
            resized = cv2.resize(gray, (width, height))
            _, binary = cv2.threshold(resized, 127, 255, cv2.THRESH_BINARY)

            flat = binary.flatten()

            rle = []
            curr = flat[0]
            run = 0

            for p in flat:
                if p == curr and run < 255:
                    run += 1
                else:
                    rle.append(run)
                    rle.append(1 if curr == 255 else 0)
                    curr = p
                    run = 1

            rle.append(run)
            rle.append(1 if curr == 255 else 0)

            with open(f"{out_dir}/{frame_id}.bin", "wb") as f:
                f.write(bytearray(rle))

            frame_id += 1

        i += 1

    cap.release()
    print("done frames:", frame_id)

if __name__ == "__main__":
    convert("vid.mp4", "frames")
