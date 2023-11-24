---
title: "Computer Software Fundamentals"
---

## Basic Software Concepts

On mechanic machines, the human operating is responsible for executing the work, instead nowadays the software programmed by humans have a set of functions to execute the work as the user, also human mostly, wants.

Computers are sons of Turing and second world war. The urge to have better communications, data processing and storage for those information made the way for the creation of the computer.

### Hardware Instructions Representation and Storage

CPU's have their machine code or native code different from each other. Instructions can be in high level (high level programming languages, like javascript, c, c++, etc) or in that native code (low level language).

High level languages should be interpreted or compiled to generate low level code (machine/native code) so the computer can understand and process the instructions. One instruction in high level language can generate 1, 2, ... 5, or more instructions in low level language.

### Open Source Code

Basically the compiled or bundled app will be distributed but also, the source code in which it's originated will be accessible. Generally the source code have a license that says something like: "here's the source code, feel free to create your own version of the app you the changes you want to make".

### Program

A program basically is a block of instructions stored in the memory RAM, or waiting in a swap memory for example, that are executed for the CPU in order to achieve it's purpose.

There's tons of types of instructions, two are important to see now:

- Loop or Goto Instructions: Like after instruction 4, the instruction five says to return to 1, so the processor executes again instruction 1, 2, 3, 4, 5 and cycle again; or goto that just says execute again the instruction 3, for example, and continues the process after;
- Conditional Instructions: If an condition is true or false determines whether the computer goes to instruction 5 or 6, for example.

## Functional Softwares

Operational System is what manages the computer resources (memory, permissions, peripherals, etc) and the execution of programs. It's an abstraction layer to hardware specificities for the programs that will be executed.

The SO is also initialized by a program. This is the **firmware** of initialization, also called **BIOS**, it is written by the facture of the computer and is stored in a special memory called **ROM**. The firmware is responsible for knowing when the machine was off and has turned on and for looking into connected storages looking for a system to be initialized (other important things too). Boot ordering is when multiple systems where found by the firmware, so it will have an ordering of initialization, starting with the first in the list.

## Programming Language Types

- Compiled Languages: Those are compiled by a compiler to generate machine code to be executed by computer. Those have highest performance speed. The reverse process is not possible;
- Interpreted/Dynamic Languages: Those are interpreted by an special program (interpreter) that executes the code.

here are also JIT's, those can read the source code to interpret and compile in the fastest way possible, and that works very well. Modern Internet browsers such as Firefox, Chrome, Microsoft Internet Explorer and Microsoft Edge now embed JIT's for JavaScript code. JIT examines dynamic code snippets (Javascript) that are being executed very frequently and compiles native code from these snippets in real time.

*Obs: Even with JIT's, interpreted languages have lower speeds in execution than compiled languages.*

# Footer

- **Class**: Computational Thinking
- **Theme**: Computer Software Fundamentals