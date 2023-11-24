---
title: "Programming Notions: Examples With Digital Images Manipulation"
---

## Data Manipulation

Example: Manipulate a digital image with simple javascript code.

```javascript
const img = SimpleImage("smallpanda.png");
const pixel = img.getPixel(0, 0);
pixel.setRed(255);
print(img);
```

## For

It will loop through whatever it is said to loop through. It is mostly used with iterables since it can iterate through them with a logical condition. Example using for to manipulate all the pixels of an image:

```javascript
const img = SimpleImage("smallpanda.png");
for (pixel: img) {
  pixel.setRed(255);
}

print(img);
```

Transform the image into a grayscale image:

```javascript
const img = SimpleImage("smallpanda.png");

for (pixel: img) {
  const avg = (pixel.getRed() + pixel.getGreen() + pixel.getBlue()) / 3;
  pixel.setRed(avg);
  pixel.setGreen(avg);
  pixel.setBlue(avg);
}

print(img);
```

## If

It will execute the code inside the if statement if the condition is true. Example using if to manipulate all the pixels of an image:

```javascript
const img = SimpleImage("smallpanda.png");

for (pixel: img) {
  if (pixel.getRed() > 200) {
    pixel.setRed(255);
  }
}

print(img);
```

# Footer

- **Class**: Computational Thinking
- **Theme**: Programming Notions: Examples With Digital Images Manipulation