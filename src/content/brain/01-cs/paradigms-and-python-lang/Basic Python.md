---
title: "Basic Python"
---

## Python Language and it's Characteristics

Created by Guido van Rossum in 1990, it's a top level language that is becoming more and more popular, mainly because of the use of it on machine learning.

- Multi-paradigm;
- Interactive;
- Hybrid Implementation Method: It uses a mixed approach to explore the advantages of the interpreter and the compiler;
- Portable;
- Extensible: Creating modules and packages is possible;
- Support for Databases;
- Support for User Interface;
- Can be Used as a Script Language;
- Support for Web Apps;
- Support for Commercial Apps.

In Python, different from other languages, the blocks of code aren't delimited with '{}', instead the ':' is what defines blocks of code, ex:
```python
a = 0
if a % 2 == 0:
  a += 1
else:
  a += 3
print (a)
```

Comments can be one line (using "//") or multi-lines (using "/*" to open comment and "\*/" to close).

## Variables

In Python it's not necessary to define types for variables, a simple `a = 0` will work.

Some words are considered reserved and cannot be used as python variable identifiers. They are: and, as, assert, break, class, continue, def, delif, else, except, exc, final, for, from, global, if, import, in, is, lambda, not, or , Print, Raise, Return, Try, While, With and Yield.

*Obs: Python has no constant variables.*

### Binding

We call binding the association between programming entities. See some examples:

- Variable tied to a value;
- Operator tied to a symbol;
- Identifier tied to a type.

Each language can have the following times for binding:

- Language Project Time: The symbols are tied to the operator, such as * (multiplication), or the definition of the reserved words;
- Implementation Time: It usually occurs in compilers, such as the definition of range of values for a particular type;
- Compilation Time: Association of the variable with your type;
- Connection Time: The connection of several previously compiled modules, such as the call to an imported module function. In Python the connection is indicated by `import` keyword;
- Load Time: When the program is loaded. For example, relative memory addresses are replaced by absolute addresses;
- Execution Time: Values association to variables that depend on user inputs.

The connection time can be classified as "early binding" or "late binding". The more earlier, more efficient is the execution of the program, but less is the flexibility of the available structures.

#### Type Binding

- Static: Cannot be changed. Ex: In C, it's defined `int variable`;
- Dynamic: Can be changed during execution.

### Visibility and Scope

Every variable it's defined within a scope. We can call a variable `global` or `local` depending on the scope.

- Global:  Variables defined in Python prompt or in modules outside of any functions can be considered global;
- Local: Variables defined within a scope, being the scope a function, class, whatever.

*Obs: Using `global` keyword inside a scope can use the global variable instead of defining other, ex:*
```python
a = 10
def changing ():
  global a
  a = 5
```
*In the example, the variable `a` will be altered to have the value 5 instead of the first defined 10.*

Types of scope:

- Static: The scope is based on the program's textual description and moorings are made in compilation time. This is the case of C, C ++ and Java, for example;
- Dynamic: The scope is based on the call sequence of the modules (or functions). Therefore, moorings are made at execution time.

## Data Types and Expressions in Python

- Numerics
  - Integers: Boolean is a subtype of int. Python allows you to use Underline (_) as a thousand. There's no limit for variable size, the limit is the available memory in the machine. In a math description, it uses elements from the integers group (Z);
  - Floating Point Numbers: It uses elements from real numbers group (R). The dot is used to separate the integer part from the decimal part in float numbers;
  - Complex Numbers: Is utilized to manipulate complex numbers in `x + yj` format, where `x` is the real part and `y` is the imaginary part;
- Sequential:
  - Lists: Can be created using commas and/or [], using loops while adding values to a variable or using `list` constructor;
  - Tuples: Can be created using commas and/or () or using `tuple` constructor. The use of '()' are optional;
  - Range Objects: It's a range, as the name says. Can be inclusive or exclusive in loops. The code `range(3)` will create a sequence (0, 1, 2). It's possible to create more complex ranges with range(2 (initial value), 8 (limit value), 2 (increment value));
  - Str(string): The type `str` is used for treatment of text data. There's some methods in Python for strings, like `split` (to split string), upper (turn all chars into uppercase), lower (turn all chars into lowercase);
- Dictionaries: Allow a sequence items to receive rates defined by the user. A dictionary contains pairs of (key, value);
- Classes;
- Instances;
- Exceptions.

*Obs: There's a lot of operators for those types of data, but about precedence, in Python the programmer can define higher priority in operations by adding `()`*

### Boolean Operators

- `not`;
- `or`;
- `and`.

### Type Conversions

In an operation between two numbers, one integer and one float, the integer is converted by Python before the operation is done. Boolean values (true and false) are converted in math operations to their equivalent (1 and 0).

It's also possible to explicitly convert value types using the constructor of the type, like:
```python
float(2) // will become 2.0
```

## Assignment, I/O in Python

- Simple Assignment: ex: `a = 10`;
- Multiple Assignment: ex `a, b = 10, 11`;
- Composite Assignment: ex1: `a = 10`, `a = a + 1`; ex2: `a = 10`, `a += 1` (operators: +=, -=, *=, /=, %=);

Variables value can be exchanged using multiple assignment instead of creating a value to hold the last value, ex:
```python
a = 1
b = 2
temp = a
a = b
b = temp
# better
a, b = b, a
```

### Input

The `input()` is the entry method of Python, everything the user types for it will be stored as string in Python. The `eval()` method can evaluate expressions within strings, so it can be used to read the input operation as a number.

### Output

The method `format()` can be used to format the output showed to user. Ex:
```python
# {} indicates where the vars will enter
print('{}:{}:{}'.format(hour, minute, second))
# or
print(f'{hour}:{minute}:{second}')
```
Also can be used to define the width of the slot, like:
```python
print('{:4},{:5}'.format(10,100))
# '  10,  100'
# And to define floating point values precision
print('{:8.5}'.format(10/3)) # 8 spaces but only 5 will be used
# '   3.3333'
```
The `print` method also can output lists and sequences just by passing them to it. Example:
```python
L = [1,2,3,4,5,6,7,8]
print L[::-1] # this will print reverse, like 8, 7, 6...
```

# Footer

- **Class**: Paradigms and Python Language
- **Theme**: Basic Python