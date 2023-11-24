---
title: "Paradigms and Python Language"
---

## Classifying Programming Languages

Softwares can be classified in:

- App Software: Browsers, terminals, note taking apps, etc;
- Basic Software: Comprehend essential programs to the functionality of the system.

A programming language is a basic software that allows users to create another softwares making use of it. A programming language is a formalism with a set of symbols, reserved words, commands, syntactic and semantic rules and other resources, which allow specifying instructions of a program.

Programming languages were created in order to abstract the inner functionality of the computer to the programmer, and like that the programmer can focus on the problems and will be easier to learn the language in higher level, with better proximity from english.

### Assembly

Programmers back in the old days had to program like machines, the instructions were in binary and the only 'abstraction' that Assembly did to improve programmers life was assigning symbolic names to operations or positions in memory they used a lot.

### Classifying by Level

A programming language is a formalism with a set of symbols, reserved words, commands, syntactic and semantic rules and other resources, which allow specifying instructions of a program.

- Low Level Language: Machine language is the most low level language, meaning the instructions to the processor should be written in binary. But there is also Assembly: The three lines of assembly language code below move the numeral 2 to the AX register (line 1), move the numeral 1 to the BX register (line 2), and add the contents of the 2 registers (line 3);

```Assembly
MOV AX, 0002
MOV BX, 0001
ADD AX, BX
```

- High Level Language: ASP, C, C++, C#, Pascal, Delphi, Java, Javascript (bad but good), Lua (amazing), MATLAB, PHP (uh), Ruby, Rust (that one I should learn) and others. Below is the same code written in Assembly, but in Python.

```python
def main():
num1 = 2
num2 = 1
soma = num1 + num2
```

- Other points are that for some people, C and C++ are languages of medium level, because they have, besides the proximity with human language, instructions that directly access memory and controllers, and also for some other people there is the existence of languages of highest level, those are python, ruby, elixir, javascript (enters here too I think), that are languages that delivers a lot of libraries to work with, facilitating the beginner users to learn it.

### Classifying by Generation

- First Generation: Machine language;
- Second Generation: Assembly uses Assembler to translate the instructions to machine language. From that generation every language will need a conversion process of the code;
- Third Generation: Procedural Languages. One abstracted instruction can be more than one in machine language. They commonly have variables of simple types (character, integer, real, logic) and structured (vectors, matrices, registers), conditional commands, iteration command and modular programming (functions and procedures), being aligned to structured programming. Some examples are: Fortran, BASIC, COBOL, C, PASCAL, etc. This generation have in common:
  - Store data types statically: simple, structured, and enumerated;
  - Dynamically allocate memory through pointers, which are memory locations whose content is another memory location;
  - Make available: sequential, conditional, repetition and unconditional branch control structures.
  - Allow modular programming, using parameters;
  - Operators: relational, logical and arithmetic;
  - Emphasis on simplicity and efficiency.
- Fourth Generation: Different from procedural languages, in this generation the programmer specifies what he wants to do in the instructions and what and how he doesn't want to do in instructions. Examples of this generation are SQL (Structured Query Language), MATLAB and PostScript;
- Fifth Generation: Languages in this generation are aimed to machine learning and voice recognition. Some examples are Lisp and Prolog.

## Rating Criteria of Programming Languages

Util programming domains:

- Scientific apps: High precision calculus, like ENIAC which objective was ballistic calculations. The programming languages those days were machine language and Assembly. Another languages that has been created that matches it's purpose are FORTRAN and ALGOL60;
- Commercial apps: Supply enterprises needs. An example is COBOL;
- Artificial intelligence apps: Lisp and Prolog;
- System programming: C, C++;
- Web programming: JavaScript, PHP, ASP, .NET, Java, Ruby and Python;
- Mobile programming: Java, Kotlin and JavaScript (android), Swift, Objective-c and JavaScript (iOS).

### Evaluation of Programming Languages

- Readability: Simplicity, orthogonality, control instructions, types, data structures and syntax;
- Easy to write: Simplicity, orthogonality, expressiveness and abstraction support;
- Reliability: Type verification, exception treatment, aliasing, readability and easy to write;
- Price of: Training, write a program, compile program, execute program, implement the language, reliability and maintenance.

*Python is a language with high readability, ease of writing, and reliability. Its cost is not high, because in addition to being open source, it is easy to learn.*

## Paradigms and Their Characteristics

A paradigm groups languages with similar characteristics that emerged at the same time.

### Imperative Paradigm

- Structured Paradigm:
  * Do not use unconditional branches (Goto, characteristic of languages like BASIC and early versions of COBOL);
  * Develop programs by successive refinements (top down methodology), motivating the development of routines (procedures and functions) and the vision of the program starting from the general to the particular;
  * Develop programs using three types of structures: sequential, conditional, and repetition;
  * Aiming at efficiency, the structured paradigm is based on the principles of Von Neumann architecture, where:
    * Programs and data reside in memory (during execution);
    * Instructions and data travel from memory to CPU and vice versa;
    * Results of operations travel from the CPU to memory.
- Object Oriented Paradigm: Through properties such as abstraction, encapsulation, inheritance and polymorphism, greater organization, reuse and extensibility of code and, consequently, easier programs to be written and maintained. This paradigm uses concepts of structured paradigm in the specification of commands and methods, by that it is considered an evolution of structured paradigm;
- Concurrent Paradigm: Characterized when processes run simultaneously and compete for hardware resources (processors, disks and other peripherals), characteristics that are increasingly common in information systems. With one processor it will just compete for processor usage and resources, but with multiples processors, the processes will run in parallel (parallelism concept) and at the same time.

### Declarative Paradigm

Unlike the imperative paradigm, in the declarative paradigm the programmer says what the program should do (what the task is), instead of describing how the program should do it. The programmer abstractly declares the solution to the problem.

- Functional Paradigm: It covers languages that only operate functions that take a set of values and return a value. The program boils down to function calls, which in turn can use other functions. Naturally this paradigm generates smaller programs. Example of languages are: Lisp, Haskell and ML;
- Logical Paradigm: The execution of programs written in logic programming languages follows an automatic deduction mechanism (inference machine), with Prolog being the most well-known language of the logical paradigm.

## Implementation Methods of Languages

Before the execution, high level language programs should be converted to machine language. There are two ways of doing it:

### Translation / Compilation

What most calls compilation, actually, is just one part in the process, meaning the really right name is translation. The steps in the process are: compilation, mounting, charge and connection.

#### Compilation Steps

- Lexical Analysis: Identifies the tokens (language elements), disregards parts of the source code, such as blank spaces and comments, and generates the Symbol Table, with all these tokens, which are identifiers of variables, procedures, functions, commands, expressions, etc;
- Syntax Analysis: Checks if the tokens are valid syntactic structures (examples: expressions and commands), applying the grammar rules defined in the language project;
- Semantic Analysis: Checks if the syntactic structures make sense. For example, it checks that a variable or constant identifier is used properly, that operands and operators are compatible;
- Intermediate Code Generator, Code Optimizer and Code Generator: In distinct steps, generates the target code or the object code. Intermediate code might me in Assembly. The optimizer objective is reduce redundancy in intermediate code and make the object more optimized;
- Error Handler: At all stages there are errors: lexical, syntactic and semantic. A good compiler has good error handling;
- Symbol Table Manager: Keeps the symbol table updated at each compiler pass.

### Interpretation

Steps:

1. Get the next statement from the source code;
2. Interpret the instruction (conversion to machine language commands);
3. Execute instruction.

*Note that the procedure, described above, is very similar to that performed by computers that implement the Von Neumann machine, in the execution of an instruction, as follows:*

1. Get the next statement;
2. CI → address of the next instruction. CI = instruction counter;
3. RI → instruction to be executed. RI = instruction register;
4. Decode the instruction;
5. Execute the statement.

### Hybrid Systems

The hybrid process of implementing a programming language combines the fast execution of translators (compilers) with the portability of interpreters. The secret is the generation of an intermediate code that is more easily interpretable, but not tied to a platform (OS/Hardware).

#### Python implementation system

Python uses a hybrid system, a combination of interpreter and translator (compiler). The compiler converts the Python source code into intermediate code, which runs in a virtual machine, the PVM (Python Virtual Machine).

# Footer

- **Class**: Paradigms and Python Language
- **Theme**: Paradigms and Python Language