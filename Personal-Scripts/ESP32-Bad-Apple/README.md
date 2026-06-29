# ESP32 Bad Apple RLE Player

An efficient video player for the ESP32 that renders "Bad Apple!!" animation on an SSD1306 OLED display. This project uses custom RLE to compress video frames, allowing the full animation to fit within the ESP32's flash memory.

## Features

* **RLE Compression**: Custom Python script to convert MP4 frames into space-saving C++ headers.
* **PROGMEM Storage**: Utilizes the ESP32's flash memory to store video data, bypassing RAM limitations.
* **Smooth Playback**: Targeted 10 FPS playback with frame-timing compensation.
* **Automated Conversion**: Includes a script to process any `vid.mp4` into compatible RLE data.

## Hardware Requirements

* **ESP32**
* **SSD1306 128x64 I2C OLED**

### What did I exactly use?

* **ESP32 DEVKIT V1 (ESP-WROOM-32)**
* **IIC I2C OLED display 0.96" - White, 128 x 64**

## Setup Instructions

1. **Prepare Video Data**:
* Place `vid.mp4` in the root directory.
* Run `python convert.py`. This will generate `video_data.h`.
* Move `video_data.h` into your sketch folder.


2. **Wiring**:
* **VCC** -> 3.3V
* **GND** -> GND
* **SCL** -> GPIO 22
* **SDA** -> GPIO 21


3. **Arduino IDE Setup**:
* Install the **Adafruit SSD1306** and **Adafruit GFX** libraries via the Library Manager.
* Open `badapple.ino`.
* Select **ESP32 Dev Module** (or your specific board).


4. **Flash**: Upload the sketch to your ESP32.

---

### License

**MIT License**
