---
title: "Hardware Components"
---

## Basic Structure of a Computer

Examples of general systems:

- Juridical System;
- Nervous System;
- Information System;
- Family System.

The definition of computing can be understood as performing calculations in an orderly way or just manipulating values. Based on that, a computer system is: group of parts in concurrence to realize the objective of computing (data).

- Data: It's a group of facts or a single piece of fact that is in raw state, based in then can be stated conclusions;
- Information: It's derived from data, but already contextualized, so no need to state conclusions, since it's already an stated piece of knowledge.

Data processing is a series of activities that have the objective of output information while computing data. The steps:

- Entry point: Program code and insertion of data (data);
- Processing: Calc and tests;
- Output: Print results (information).

### Programming Languages

Two types of programming languages:

- Lower Level: Use of mnemonics instead of bits. It's directly related to CPU architecture. Ex: Assembly;
- High Level of Abstraction: More close of human language and more distant from mounting language. Ex: Rust, C++, Pascal, etc.

### Computing System Organization

- Entry Devices: peripherals (keyboard, mouse);
- Output Devices: also peripherals (monitor);
- CPU;
- RAM;
- Secondary Memory (HD, SSD, etc).

On John von Neumann architecture, a digital machine can store it's programs in the same memory as the data, allowing like that the manipulation of programs.

### Bus

It's a group of wires that has the function of transporting signals of information and signals of control and communication between interconnected components. Types of bus:

- (DB) Data Bus: Are bidirectional, and transport bits of data;
- (AB) Address Bus: Are unidirectional, and transport an address of access in memory or of one I/O device, from the CPU to the control bus;
- (CB) Control Bus: Have wires that send specific signals of control and communication during operations.

The sum of all wires of the DB, AB and CB are equal to the amount of processor pins: Pins = DB + AB + CB.

### Processor Functions

The processor interpret the operation and execute the step (how to properly complete the operation defined in algorithm).

A machine instruction consists of the set of bits that identifies a certain primitive operation to be performed directly by the hardware, for example, 1001 00111 00001.

Examples of primitive operations include:

- Arithmetic operations – Add, subtract, multiply and divide;
- Logical operations– AND, OR, XOR;
- Data input and output operations;
- Control deviation operations;
- Data movement operations.

#### Instruction Cycle

**Instruction sets** are all possible instructions that can be interpreted and executed by a processor. For example, the Intel 8080 had 78 machine instructions, the Pentium 4 had 247;

**Instruction cycle** is a sequentially organized set of machine instructions for executing a program.

The basic format of a machine instruction is based in two parts:

- Operation Code: Identify the operation to be realized;
- Operands: Like the args, can be many.

Ex: ADD (O.C) A (operand), B (operand), C (operand)

# Subsystems of Processing, Memory and I/O

## Processor

A CPU has two main functions:

- Processing: Actual processing of any operation;
- Control: Finding instructions, interpreting them, generating signals of control to execute required operations (in or out of the processor).

## Memory

Types of memories:

- Registers;
- Caches;
- RAM (main memory);
- HD's, SSD's (secondary memory);
- Virtual memory.

### Registers

- Data Register: They store the data that will be processed by the calculation units, separated into units for integers and floating point numbers;
- Memory Buffer Register (MBR): For external data transfers;
- Memory Address Register (MAR): For external memory address transfers;
- Program Counter (PC): For searching next instruction;
- Instruction Register (IR): Store instruction;
- Segments: For storing address of segments (points to programs, data, piles, etc);
- Flags: Can be used to indicate the results of certain instructions.

### Cache Memory

Stays between RAM and CPU and has low capacity but higher speed.

#### Principle of Locality

This principle is a programming principle that defines the mode that the instructions are executed, following the lines of the codes in sequence in the code execution, only deflect sometimes, but the sequence come back right away.

This principle is separated in two parts:

- Spatial Locality: Whenever the processor performs an access to a memory address, it is likely that the next access will be to the next contiguous address;
- Temporal Locality: Whenever the processor performs an access to a memory address, it is likely that, in a short time, it will access the same address again.

Every memory is divided in **M bits**, the value of M is different between memories, on RAM this value is 8 bits (1 byte). This minimal part is called cell. A memory that has **N** parts can have **N** addresses. This operation is:

2^E = N, where **E** is the width of each address (like 1010110, which has 7 as his address width) and N is the amount of possible addresses.

Example: if the address width is 6 bits, then the total addresses are: 2^6 = 64 addresses.

### RAM

Random memories can be writable (RAM) and read only (ROM).

- SRAM:
  - Each bit is made up of 5 to 7 transistors;
  - It does not require recharging, so it is faster, but takes up more space and is more expensive;
  - Used as cache memory.

- DRAM:
  - Each bit consists of 1 capacitor and 1 transistor;
  - The capacitor serves to represent the value of the bit and the transistor to be used in readings/writings;
  - As the capacitor is discharged, it is necessary to recharge periodically (refresh signal – wastes time);
  - Used as main memory.

DRAM can be of two types, asynchronous (DRAM, FPM, BEDO, EDO), and synchronous (SDRAM, DDR, DDR2, DDR3, DDR4, DDR5).

There is also a classification according to the type of memory encapsulation (module formats):
  - SIMM (Single In Line Memory Module): The electrical contact on one side is the same as on the other side;
  - DIMM (Dual In Line Memory Module): The contacts on both sides are independent.

### I/O Subsystems

Every I/O component is divided in two parts, the device and the interface. Ex: (monitor - device, and video card - interface). Interface or controller has the function of match the different characteristics between the processor/memory and the device it controls while also controlling the functionality of the device.

The I/O device connected needs a specific code to run properly, that code is provided by programs called drivers. Ex A: A disk driver must know about sectors, tracks, cylinders, heads, arm movement, etc. Ex B: A mouse driver must accept information saying how far it has moved and which button has been pressed.

# Operational System

It's the intermediate between the hardware and the programs being executed. It manages the programs execution following pre-defined or user defined preferences. Also, since it's the intermediate, the S.O will deal with the compatibility issues of peripherals and abstraction of hardware for programs.

The S.O is the only program executed in Kernel, pursuing complete access to hardware and any instruction execution possible.

Types of Operational Systems:

- Single-programmable/single-tasking systems:

The processor, memory and peripherals remain dedicated exclusively to the execution of a single program. An example is MS-DOS.

- Multiprogrammable/multitasking systems:

Computational resources are shared among different users and applications. Examples are Windows, Linux, macOS.

- Systems with multiple processors:

They have two or more CPUs (CPUs) interconnected and working together. Systems such as Linux and Windows support this. Advantages of this type of system are (scalability, availability and load balancing).

- Batch systems:

Process routine tasks without the user's interactive presence. Example: Processing insurance company policies; sales report for a chain of stores.

- Time Sharing Systems:

Allow multiple remote users to perform their tasks simultaneously on the computer. Example: Querying a database.

- Real-time Systems:

They have time as a fundamental parameter. Example: Assembly line for a car.

Here, see differences between **tightly coupled systems** and **weak coupled systems**:

- *Tightly Coupled Systems*: There are multiple processors sharing a single physical memory and I/O devices being managed by a single OS;
- *Weak Coupled Systems*: There are two or more computer systems connected through communication lines.

# Footer

- **Class**: Computer Architecture
- **Theme**: Hardware Components