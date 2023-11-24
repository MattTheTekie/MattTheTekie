---
title: "Internet: Client X Server"
---

## Client X Server Model

Was created in 1970 with the will of separating resources of data processing. The model before with was called centralized model and as the name suggests, it does everything in one place.
The applications built in this model were developed making use of his distributed architecture. Those applications was developed having as a base the concept of development in layers. Then came models with multiple layers.

### Two Layers Model

In this model, we have client and server layers, with the first layer handling the business logic and making the user interface, while the second layer is responsible for handling the data — normally using database management systems (DBMS).

### Three Layers Model

- Presentation Layer: Represented by the application installed on the client machine;
- Application Layer: Represented by a server responsible for business logic and rules, as well as for controlling access to the data server;
- Data Layer: Represented by a server responsible for data storage.

### Four Layers Model

- Web Server: Responsible for the interface, presentation, etc;
- Application Server: Represented by a server responsible for business logic and rules, as well as for controlling access to the data server;
- Data Server: Represented by a server responsible for data storage;
- Client: You accessing this environment from a browser or something.

### Communication in Web Environment

- Http (Hyper Text Transfer Protocol): An http request is made from the client when accessing a web page in order to see it's contents, the server answer the request that can become, let's say a 401 code (not authorized), 200 (return success and commonly the resource asked in request, show the page to the user), etc.

## Interfaces

Human-Computer Interaction (HCI) is the study of interactions between humans and computers. In this context, interface is what provides interaction. In the beginning this interaction was only made by terminal screens, now it can be done with use of GUI's (Graphical User Interface).
Since Nowadays we have a variety of screen sizes in another variety of devices, it has became a problem to make interfaces on the web that fits perfectly each screen.

### Responsive Design

Responsive design is the approach that suggests that design and development should respond to the user's behavior and environment based on the screen size, platform, and orientation of the device being used.

- The origin of responsive design: The concept of responsive design had its origins in Responsive Architectural Design. Such a project preaches that a room or space must automatically adjust to the number and flow of people within it.

In order to apply responsive design, we make use of technics, such as:

- Fluid Layouts: Make use of flexible units in order to define the size of the components in the page;
  - EM: This unit is equal to the size of the letter M in uppercase;
  - REM: Always will be related to the size defined in <body> or <html>.
- Media Query: Is the use of media types from one or more expressions to define formatting for different devices;
- Scripts: Dynamic update of content and it's presentation.

#### Mobile First

Basically in an approach of responsive design that starts the development of the interface for the mobile dimensions, and start making changes for other dimensions.

### Adaptive Design

Are defined 6 break points and made adaptations for those dimensions.

## Client Technologies

### Html

Types of tags:

- Structure Tags: <html>, <head>, <body>;
- Content Tags: <h1>, <ul>, <li>, <a>, <p>, <img>, <form>, etc;
- Semantic Tags: <header>, <nav>, <main>, <footer>, etc;

HTML 5 has brought a lot of improvements, like:

- Better connectivity;
- Possibility of storing data in client side;
- Optimizations in offline operations;
- Support for medias (audio and video).

### CSS

#### Syntax

- Selector: An html element (<body>, <h1>, etc), his ID (id attribute) or his class name (class attribute);
- Property: Color, font, position, etc;
- Value: The new value to be applied to the property.

Nowadays CSS can be applied to websites in a lot of different ways, like:

- Using Pre-processors: Sass, etc;
- Using Css-in-js: Stitches, Styled-Components, etc;
- Using Css Frameworks: Tailwind, Bootstrap, etc.

### JavaScript

JavaScript can manipulate the DOM, and his capacity has become more and more powerful with the appearance of frameworks like React.js and Angular.

## Server Technologies

### PHP (Hypertext Processor)

It's an open source programming language dedicated to server side. It was an structured language but has adopted object oriented programming paradigm 10 years after it's creation.

- PHP code is interpreted by server;
- Then the code is converted to HTML;
- Then the code is showed in browser.

#### Syntax

- Variables: Variables are created using the dollar sign ($);
- Data Types: Booleans, integers, floating point numbers, strings, arrays, iterables, objects, resources, NULL and call-backs. And it's not necessary to define the type in declaration, since PHP is a weak typed language;
- Conditional Operators: There is if, else, if and else ternaries and switch;
- Loops: There is for, foreach, while and do while;
- Methods and Functions: PHP has a lot of native methods and functions.

To include scripts PHP inside other scripts PHP use: include, require, include once, require_once.

PHP also has access to archives in the server.

### Static Pages

HTML + CSS + JavaScript only makes an static page.

### Dynamic Pages

The combination of technologies on client side with technologies on server side make dynamic pages. Dynamic pages stores data on databases and manipulate content using scripts in server side using PHP (like saving a post). Another thing dynamic pages can do is add the possibility to use CMS (Content Management Software) to keep site information always updated.

### Accessing Data

It's possible the recover data from databases using HTML forms, sending a request to the server endpoint or using JavaScript fetch API (it seems that exists an XMLHttpRequest too).

# Footer

- **Class**: Web Development
- **Theme**: Internet: Client X Server