---
title: "Data Representation"
---

## Computer Systems

### Information Unit

In a computer, as we all know, the values are represented with 0's and 1's. The group of 8 of binary values is what we call a byte. Every sequence (byte) is understandable for the computer and can be decoded, originating the characters. The lowest information unit in a computer system is the bit. We know a byte is a group of eight 0's and 1's, so a bit can only be 0 and 1.

In order to convert bytes or bits to bits or bytes, we use rule of three simple. So, in general terms, from bit to byte we divide for 8 and in opposition we multiply for 8.

- An ordered group of bytes = word;
- An ordered group of words = registry;
- An ordered group of registries = archive;
- An ordered group of  archives = database.

### Multiples and Submultiples

4.000 Kb (4.000 x 103 = 4.000.000 bits) - bit abbreviation;
567 MB (567 x 106 = 567.000.000 bytes) - byte abbreviation;

`Obs: approximated, not real, numbers.`

- K (kilo) = refer to values in 2¹⁰ or 10³;
- M (mega) = refer to values in 2²⁰ or 10⁶;
- G (giga) = refer to values in 2³⁰ or 10⁹;
- T (tera) = refer to values in 2⁴⁰ or 10¹².

To convert from one value to another, we need to multiply (choose the power of two or then for it). And we consider the distance between each, not the value itself.

Ex: to convert from G to T, we multiply with negative power since the result will be tinier than the previous value. Here's 52,9 G to T:
  - *52,9 x 10⁻³ = 0,0529 TB; see? the power is negative.*

On opposition, if the are converting to a lower unit abbreviation, then the power will be positive.

### Information Representation in Computer

- Ascii: The Ascii standard can make association of a binary number that contains 7 bits with each of the 128 distinct characters;
- Mp3, .png, etc: every file extension, format, is an encoded group of bits.

## Numeric Systems and Arithmetic Operations

### Numeric Systems

Before everything:

Numeric Base:
- Decimal (0, 1, 2, 3, 4, 5, 6, 7, 8, 9): Most used numeric base;
- Binary (0, 1): Base used by computers on data processing;
- Octal (0, 1, 2, 3, 4, 5, 6, 7) and Hexadecimal (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, F): Multiples of binary base.

Now, the numeric systems:
- Positional: Every digit have a different relative value according to it's position in the number. Ex: 444 (first value is 400, second is 40 and last is 4); Ex 2: 36¹⁰ (10 is the base), can be written as 3 * 10¹ (10 = base, 1 = position) + 6 * 10⁰ (10 = base, 0 = position);
- Non-positional: Every digit has the same value independent of his position. Ex: X is roman numeric system is always 10 (XXX = 30, XL = 40, LX = 60);

### Operations

- Sum:
  - Base 10: Normal sum, when the sum exceeds the value goes to sum with the next result, etc;
  - Base 2: Same applies here, 1 + 1 = 10, so it's 0 and the 1 that remains go sum with next result;
  - Base 16: Same applies here too, but remembering matches. Comparing to decimal system, 10 = A, 11 = B, until 15 = F, then it returns to numbers, but with a little difference of values, since 16 = 10 in hexadecimal, and again when it comes to 26, it returns to 26 = 1A, 27 = 1B, etc;
  - Base 8: Same goes here, imagine 4 + 5 = 9, but there's no 9 on base 8, so we do 9 - 8 = 1, and that 1 goes to sum with the next result.
- Subtraction:

`Obs: if minuendo is bigger than subtraendo, just subtract value and write down, else if subtraendo is bigger, take one from the number in right.`

  - Base 10: Is as everyone knows;
  - Base 16: The take one value has 16 as value. Ex: if I have 4 - 7, it's impossible, so 4 gets one value from right, so it's not 14, but 20, since we are getting 16 as value, and the result is D;
  - Base 2:
    - 0 - 1 = 1 (taking a value from the digit on the right of it);
    - 1 - 1 = 0;
    - 1 - 0 = 1;
    - 0 - 1 = 0, but:
      - The zero of this column is worth 2.
      - All zeros on the left to the first "number 1" are worth 1.
      - This "first number 1" is worth 0 (zero).
      - If it happens again 0 - 1, the process will be repeated.

## Conversion

### Convert X Base Number to Base 10 Number

Ex. 214 in base 5: 2 * 5² + 1 * 5¹ + 4 * 5⁰; 50 + 5 + 4 = 59 in base 10.

### Convert From Base X to Base Y

Ex. 214 in base 5; We always do the step before, so first convert to base 10, base 10 will always be the intermediate, and then convert to, let's say, base 7; We do divisions until the quotient is equal to zero, and then use the rests from right to left as the result (numbers between parenthesis are the rest):
  59 / 7 = 8 **(3)**; 8 / 7 = 1 **(1)**; 1 / 7 = 0 **(1)**; Result, 113 in base 7.

### Binary

In binary, a bit that has the value of 0 should not be counted on conversion, so the number 101 in binary would be: **1 * 2² + 1 * 2⁰; 4 + 1 = 5**; see? the bit with value zero doesn't count.

**TODO: DIDN'T UNDERSTOOD THE CONVERSION WITHOUT INTERMEDIATE OF BASE 10, SHOULD REVIEW!**

## Data Representation

- Primitive data:
  - Character: Non-numeric symbols, primary way to introduce text in some idiom;
  - Logic: False or true;
  - Numeric: Representation of numbers.

### ASCII (American Standard Code for Information Interchange)

Every character has 7 bits and ASCII have an amount of 128 characters (2⁷) that can be expressed in hexadecimal. The 0 and 1F characters cannot be impressed because they are characters of controlling.
ASCII has letters (uppercase and lowercase), punctuation marks (=+,.;:~...) and math symbols (+=-*...).

### Unicode

Since ASCII, besides being a good option for english idiom, did not provide well for other idioms like chinese, japanese, etc. So a group of enterprises has created Unicode, in which each character has 16 bits. With Unicode we can have an amount of 65.536 characters (2¹⁶). It also have codes for emojis, geometric forms, monetary symbols and more.

# Footer

- **Class**: Computer Architecture
- **Theme**: Data Representation