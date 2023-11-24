---
title: "Structured Python"
---

## Structures of Decision and Loop in Python

### If Else

Python have type `bool`, different from C that doesn't. Python also has the `elif` structure, that C also doesn't have.

If structure example in Python:

```python
if a == true:
  print('it\'s true')
elif a == false:
  print('it\'s false')
else:
  print('value is not from type bool')
```

### For

For syntax:

```python
for item in range(2, 9, 3):
  print(item)
```

Instead of range, python also allows arrays (range is like an array btw, but only using numbers, python accepts almost any data type in arrays) and strings.

### While

```python
word = input('Insert a word: \n ')
while word != 'stop':
  word = input('Insert \'stop\' word to stop: \n ')
```

### Break, Continue, Pass

- Break: The instruction `break` stop repetitions of loops;
- Continue: The instruction `continue` stop the current repetition, making the next execution start;
- Pass: Then instruction `pass` is used inside an `if` and it can pass to the next execution, example:

```python
for i in range(1, 11):
  if i % 2 == 0:
    pass
  else:
    print(i) # only print odd numbers
```

## Concepts of Subprograms and their Utilization in Python

Subprograms are executed when an instruction clearly demands it's execution. Subprograms take the lead in execution and only when they finish their execution, they pass the execution again to the unit that called it.

Functions in C are subprograms, as they are in Python. In Python, functions are defined by `def` keyword.

Functions can receive parameters in order to execute something with the values. It can also access non local variables, and make use of no variables too. Accessing variables that aren't local make the subprogram less trustable.

The subprograms can be procedures (do not return value) or functions (return value).

In the majority of functional programming languages the nested subprograms are allowed and it's not different for Python, meaning in Python you can have nested functions, which is functions declared inside other functions.

### Static Variables and Pile Dynamic Variables

- Pile Dynamic Variables: They're linked to storage in the beginning of the execution of the **subprogram** and unlinked when the execution finishes;
- Static: They're linked to storage before the beginning of the execution of the **program** and unlinked when the program execution finishes.

Static variables has less impact on program execution since it will not have to be allocating and freeing memory slots on every execution of **subprogram**.

### Parameters

Can be passed by value, where it will works as a local variable of the subprogram, being initialized with the value of the real parameter, and by reference, where the subprogram receives only the address of the parameter, the reference for it.

### Recursion

Basically the function calls itself. It obviously can become a problem if an control of execution isn't used, because it would execute forever.

Example:

```python
# docstring of the function is what function does and Python will print this description for the function with print(help(countdown))
def countdown(x):
  if (x < 0):
    print('done')
  else:
    print(x)
    countdown(x - 1)
```

## Python Libs

Two steps to import and use modules in Python:

```python
import math # importing module
x = math.sqrt(5) # accessing and using methods from module with dot
```

### Python Native Modules

- **Math:** Used for math operations;
- **Random:** Used to generate pseudo random int numbers or sequences;
- **Smtplib:** Used for emails, it use the **SMTP** or **ESMTP** services and can send emails to any machine in the internet, example of use:
  ```python
  # importing necessary modules
  from email.mime.multipart import MIMEMultipart
  from email.mime.text import MIMEText
  import smtplib

  # creating the message object
  msg = MIMEMultipart()
  text = "Sending mail"

  # parameters
  password = "your password"
  msg['from'] = "your email"
  msg['to'] = "destination email address"
  msg['subject'] = "subject"

  # message body
  msg.attach(MIMEText(text, 'plain'))

  # server creation
  server = smtplib.SMTP('smtp.gmail.com: 587')
  server.starttls()

  # login
  server.login(msg['from'], password)

  # sending
  server.sendmail(msg['from'], msg['to'], msg.as_string())
  server.quit()

  print('message sent')
  ```
- **Time:** Has a lot of functions for timers, time values, etc;
- **Tkinter:** Python standard interface for Tk GUI toolkit. Example:
  ```python
  from tkinter import *
  mainWindow = Tk()
  text = Label(master = mainWindow, text = "My window")
  text.place(x = 50, y = 100)
  mainWindow.mainloop()
  ```

### External Packages

Pip is the program used in Python ecosystem for installing external modules. I use `asdf` so I don't have to worry about versioning or verify installation. To add fast in `PATH`, just run `asdf reshim`.

In order to use external packages, the recommended approach is to use **virtual envs**, that way you know exactly what external packages are being used in project and avoid confusions with global packages, etc.

Examples of external modules:

- Numpy: Calculations, math operations and simulations;
- Pandas: Data Manipulation;
- Scikit-learn: Machine learning models;
- Matplotlib: Data Visualization;
- Requests: HTTP protocol communication command library;
- Flask: Building web applications.

## Events in Python

### Errors and Exceptions in Python

Syntax errors are those that are discovered by the parser or analyzer.

Other type for error is those that occur in execution time of the program. Examples:

- Division for 0;
- Accessing an improper index in a list;
- Variable name not attributed;
- Incorrect operand types error.

Some types of exceptions in Python:

- KeyboardInterrupt: Raised when the user presses CTRL+C, the interrupt combination;
- OverflowError: Raised when a floating point expression evaluates to a value that is too large;
- ZeroDivisionError Raised when trying to divide by 0;
- IOError: Raised when an input/output operation fails for a related reason;
- IndexError: Raised when a sequential index is outside the range of valid indexes;
- NameError: Raised when trying to evaluate an unassigned identifier (name);
- TypeError: Raised when a function operation is applied to an object of the wrong type;
- ValueError: Raised when the operation or function has an argument with the correct type but incorrect value.

In Python, exceptions are objects. The class **Exception** is derivative from **BaseException**, a base class for exceptions classes.

### Treatment of Exceptions and Events

- Try Block: In this block should be inserted the normal instructions for the program;
- Except Block: This block will only be executed when/if an exception occurs.

Example:

```python
try:
  n = eval(input('insert value: '))
  print(n)
except:
  print('insert a numeric value, not text')
```

It's also possible to capture exceptions by it's type. Example:

```python
try:
  n = eval(input('insert value: '))
  print(n)
except NameError: # specific exception type treatment
  print('value wasn\'t inserted, right? right?')
except:
  print('insert a numeric value, not text')
else:
  # it's executed if no one exception is thrown - optional
finally:
  # it's executed independent of what occurs - optional
```

*Note: At least one `except` instruction is mandatory, independent if it's specific or generic.*

*Note: Events treatment are similar to exceptions, and the events are, for example, a click in the button of the interface.*

# Footer

- **Class**: Paradigms and Python Language
- **Theme**: Structured Python