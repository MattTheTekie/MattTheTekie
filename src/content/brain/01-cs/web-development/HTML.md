---
title: "HTML"
---

## Web Page Structure

The html specification was created from SGML (An ISO standard that define rules for the creation of platform independent markup languages) and HyTime (ISO standard with the objective of hyper documents and hypermedia to be described in function of it's contents). Nowadays the HTML is maintained by W3C (World Wide Web Consortium).

### HTML Version History

| Year |	Version	| History
|------|----------|--------
| 1991 |	HTML |	Tim Berners-Lee creates the HTML
| 1995 |	HTML 2 |	HTML Working Group Defines HTML 2.0
| 1997 |	HTML 3.2 |	W3C publishes HTML 3.2 Recommendation
| 1999 |	HTML 4.01 |	W3C publishes HTML 4.01 Recommendation
| 2000 |	XHTML |	W3C publishes XHTML 1.0 Recommendation
| 2014 |	HTML5 |	W3C publishes HTML5 Recommendation
| 2016 |	HTML 5.1 |	W3C candidate for HTML 5.1 Recommendation
| 2017 |	HTML 5.1 |	W3C publishes HTML 5.1 Recommendation 2nd edition
| 2017 |	HTML 5.2 |	W3C publishes HTML5.2 Recommendation

On the beginning the browsers implemented their own markups for showing pages on the web, so W3C created DTD (Document Type Definitions).

### DTD

The HTML 4 specification, for example, provided for three types of Doctypes:

- Strict: It determined a series of restrictions and requirements: mandatory separation between structure and presentation; limitation on available presentation elements - such as font tags and alignment attributes −; no support for deprecated tags, etc;
- Transitional: More malleable in terms of presentation attributes, in addition to allowing the use of obsolete tags;
- Frameset: Deprecated HTML4 tag used to combine multiple frames and display them as a single page.

We see the initial code snippet of an HTML 4.01 page:

```html
<!DOCTYPE HTML PUBLIC “-/W3C/DTD HTML 4.01 Transitional//EM” http://www.w3.org/TR/html4/loose.dtd>
```

In the declaration, the following information about the HTML page is defined:

- Document Type: HTML;
- Access to the DTD: Public – therefore, the DTD to which it refers is available for public use;
- Where the DTD is located: It was created and is hosted at the W3C;
- Specification URL: The address ``http://www.w3.org/TR/html4/loose.dtd`` links to the specification in question.

Starting with HTML5, when HTML ceased to be based on SGML, the Doctype declaration was simplified, as seen below:

```html
<!DOCTYPE html>
```

### Basic Structure

Html basic structure:

```html
<!doctype html>
<html>
  <head>
  </head>
  <body>
  </body>
</html>
```

- Head is the header of the page, here are some tags that are part of the `<head>`:

| Tag |	What is it for
|-----|-------------------
| `<title>` |	It is the title of the document, being displayed in the title bar of the browser.
| `<meta>` | It encompasses a series of information – commonly called metadata – such as the description of the page, keywords, etc.
| `<script>` |	It is responsible for the inclusion and/or definition of scripts related to the document.
| `<link>` | It is responsible for including (external) style sheets related to the document. It also makes it possible to include favicons (small icons that appear in the browser's address bar).
| `<style>` | Like the previous one, it is responsible for linking style sheets to the document − when they are declared directly in the document.

- Then it's body tag, which is responsible for the structure of the document.

## HTML Basic Tags

The `<br/>` tag is obsolete since HTML 5.

ID and Class are two of the most important attributes of HTML for web development

- Text Tags: Are responsible for organizing page content;
- Semantic Tags: Are responsible for organizing a page structure.

Some other tags and their function:

| Tag |	Description/Function
|-----|---------------------
| `<article>` |	Includes a content block that should be used when you want to insert an article, such as a blog post, for example.
| `<section>` |	Defines a section in the document. It is normally used to group sections. For example: a <section> could contain several <article>.
| `<h1>-<h6>` |	Used to insert headings throughout the page. The most important title should use the `<h1>` tag and it's a hierarchical tag.
| `<p>` |	Used to insert paragraphs of text.
| `<pre>` |	Used to insert preformatted text.
| `<div>` |	Can be used to group some type of content that does not have any specific semantics or that does not fit well within a semantic tag.
| `<span>` | Inline tag that wraps content.
| `<a>` | Used to insert links.
| `<br />` | Used to insert a line break.
| `<hr>` | Inserts a horizontal line into the document. It is usually used when you want to change the theme of a text.

`<strong>` and `<em>` vs `<b>` and `<i>` formatting tags:

- `<b>`: applies the bold effect to a text;
- `<strong>`: applies the bold effect to a text and marks it as important;
- `<i>`: applies the italic effect to a text;
- `<em>`: Italics and emphasizes text.

## Complex HTML Tags

### Lists

| Type | Tag | Container Tag | Item Tag | Description
|------|-----|---------------|----------|------------
| Sorted | `<ol>` |	`<li>` | --	| Used to create ordered lists.
| Not Sorted | `<ul>`	| `<li>` | -- | Used to create unordered lists.
| Definition | `<dl>` | `<dt>` | `<dd>` | Used to create a list of terms and definitions.

### HTML Tables

| Tag	| Function
|-----|---------
| `<table>` | Table main container
| `<tr>` | Represents the lines, being composed by the tags related to the columns.
| `<td>` | Represents the columns and needs to be inserted inside the row tag.
| `<th>` | Also represents columns and is used to display the title of a column, having, in this sense, a semantic function. Like the `<td>` tag, it must be contained within a line tag. This element has its own styles and renders differently than regular columns.
| `<thead>` | Stores the header of the table, consisting of rows and columns. This element, like what we saw earlier, has a semantic function in terms of content structuring.
| `<tfoot>` | Stores the footer of the table, also having a semantic function in terms of structuring.

***Obs: Where 'tf' is `<tbody`???***

Tables are usually arranged uniformly: **rows upon rows, columns after columns, cell by cell**.

`colspan` and `rowspan` attributes are used to organize columns and lines in a table.

### Media

In HTML we can use `<video>` or `<audio>` tags to insert video and audio medias into page. The `src` attribute is used to inform the location of the media.

## Forms in Web Pages

Basic structure of a form:

- `<form>`: Main form container;
- `<input>`: Text input in a form is well used to send information easily, by the attribute `type` we can tell the type of the data;
- `<textarea>`: Another text input of a different kind to be used to send information;
- `<select>` and `<option>`: Selection input where `<select>` is the container and `<option>` defines the options to be selected by the user;
- `<button>`: By the attribute `type` we can inform that the button will trigger the form `action` attribute;
- `<label>`: Used to define titles or captions to form fields;
- `<fieldset>`: It's used to define sections in the form;
- `<legend>`: It's well used to define the description of `<fieldset>` for example.

Look at those attributes description:

| Tag |	Attribute	| Function of the attribute
|-----|-----------|--------------------------
| `<form>` | action |	Defines the URL (address) to which form data will be sent.
| `<form>` | method |	Defines the HTTP method (POST or GET) for sending data.
| `<label>`	| for |	Binds the `<label>` tag to the field it refers to.
| `<input>`	| minlength	| Define the minimum number of characters allowed in a field.
| `<input>`	| maxlength	| Define the maximum number of characters allowed in a field.
| `<input>`	| type | Defines the type of field and its behavior.
| `<input>`	| value	| Sets the value of the field.
| `<button>` | type	| Defines the type of button and its behavior.
| `<option>` | value | Sets the value of the field.

Input `type` attribute:

- Password: Mask the text with asterisks;
- Hidden: Hide the field so it's not showed on the browser;
- Checkbox: Click/check value selection;
- Radio: Exclusively selection of value;
- Submit: Associated with button tag, triggers the `action` in the form, more specifically, the submit event of the form;
- Reset: Associated with button tag, cleans up form fields values;
- Button: An input element can exercise a button functionality with that type.

Another types were added along the time, like `email` that nowadays is very useful in form construction.

### HTML 5 New Attributes and Types

- **Attributes:**

| Attribute	| Function | Comment
|-----------|----------|--------
| placeholder	| Display a text in the input field. | Used to give a hint to the user about the data to be inserted.
| required | Determine whether a field is required. | Used to validate form data.
| autofocus |	Fix focus on the field. | Used when we want that, when loading the form, a certain field is focused.
| pattern | Validate a field's value against a regular expression. | The phone field is a good example of using this attribute. With it, we can, for example, determine the number of characters and the expected format for a field.

- **Types:**

| Type | Function	| Comment
|------|----------|--------
| tel	| Enter phone numbers. | For better usability, it should be used in conjunction with the pattern attribute.
| datetime | Insert dates with UTC time zone from a calendar. |
| date| Gives you insert dates without time zone from a calendar. |
| number | Insert numbers. | Creates a component different from the normal input, in which, using arrows, numbers can be incremented or decremented.

### Validation types

In HTML5 there are two possible types of validation:

- Which verifies that the data entered in a field is consistent with its type and/or pattern (pattern);
- Which checks if a mandatory field has been filled.

*Obs: The default HTML5 behavior is to validate the data when the form is submitted.*

# Footer

- **Class**: Web Development
- **Theme**: HTML