---
title: "CSS"
---

## CSS Fundamentals

### General Vision

CSS or Cascading Style Sheets are, as the name says, sheets of style for the HTML elements organized in cascade way, meaning there's hierarchy of which style should be applied. CSS is used to style HTML elements in a way that even the same element can have different style alongside the project.

### Syntax

```css
p /* selector */ {
  color /* property */: white /* value */;
}
```

- Selector: Can be the HTML **tag**, **pseudo class** of the HTML element (like :active, :checked, etc), the **class** of the element, the **id** of the element, an **attribute** of the element (like '[checked]' or '[type='text']'), **relation** between two elements ('a b' = any element b that is descendant of a, 'a > b' = any element b that is son of a and 'a + b' = any element b that is the next brother of a) or a combination of those;
- Property: There's tons of properties available in CSS, like background, color, font-family, etc. Each of those can be used, but depending on the context, not all of them will behave exactly the same;
- Value: The value to be applied to the property. Off course there is a lot of values already defined in CSS, like the 'white' we used, but there's also custom values that can be applied.

### Integration With HTML

- CSS Inline: Using the attribute 'style' inside the HTML element;
- CSS Internal: Using the <style> tag inside <head>;
- CSS External: Using an archive with '.css' extension and adding it to the HTML with a <link> tag or with '@import' inside css tag <style>;
- CSS Scoped: Using the <style> tag in a scoped way, declaring it inside the element that should be styled.

### Heritage

CSS allow styles that are applied to father to be also applied to children. That is what we call cascade effect, meaning every child will have the style, it is applied in an cascading way.

### Specificity

Besides heritage, the specificity of CSS allows to, even with a child that could inherit the styles from the father tag, have different styles from the father. The process is made by specifying, like the tag <p> inside a div will have 'color: red' instead of the 'color: blue' that the div applies, so the text for that specific situation (<p> tag) will be red.

### Tips on precedence rules

The precedence rule regarding forms of CSS inclusion follows this order:

1. Internal and scoped styles take precedence over styles in external files;
2. Inline styles take precedence over inner, scoped, and outer styles.

*As for selectors, the precedence rule follows this order:*

- Element selectors (using only the tag name) have the lowest precedence, as they are very generic.
- Class selectors have higher precedence than element selectors.
- Identification selectors have higher precedence than class selectors.

***Obs: the '!important' that can be used after value when applying styles will ignore this precedence to have higher priority.***

## CSS3

### Colors

They can be:

- HEX: #cccccc for example;
- RGB: Defining *red, green and blue* inside *rgb()*, but can also be *rgba()*, where 'a' is the *alpha*, controlling opacity;
- HSL: Is an system of cylindrical coordinates, with *hsl()* and *hsla()* notations.

### Fonts

Types of fonts:

- TTF/OTF;
- WOFF;
- WOFF2;
- SVG;
- EOT.

## Advanced CSS Concepts

### Box Model

There's four main elements of box models, they're: content, border, margin and padding.

### Pseudo Elements

Like *after*, *before*, *selection*, *first-letter*, etc.

### Layout

Flex layouts are simpler, just type 'display: flex' and go on styling things. Flex will just remove the block styles and let thing be more fluid in the page. There's also grid layout where you define the number of rows and cols and it works as a grid.

## Frameworks CSS

- Bootstrap: It is a responsive framework based on the mobile-first premise – whose initial focus is mobile devices and then desktops. It has ready-to-use components developed in HTML, CSS and Javascript;
- Foundation: It is a responsive framework, based on the mobile-first approach. Its main characteristic is to make native use of the CSS pre-processor, called SASS;
- Semantic UI: stands out for using, natively, a CSS preprocessor, LESS, and the Jquery Javascript library. It is also an open source framework. An important feature of this framework is that its classes use natural language syntax, such as nouns, for example, to link concepts in a more intuitive way;
- TailwindCSS: The best of the best, it uses classes inside elements to add styles, like 'flex' applies 'display: flex'.

# Footer

- **Class**: Web Development
- **Theme**: CSS