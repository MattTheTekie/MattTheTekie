---
title: "CISC X RISC Architecture"
---

## CISC

### CISC Approach on Processor Architecture

**CISC** stands for **Complex Instruction Set Computer**: a computer architecture that uses a large number of instructions, each of which performs a relatively complex operation. This means that the number of instructions is extensive and that the Control Unit of the processor is quite complex to decode an instruction to be executed. However, the complexity is offset by fewer memory accesses and tailored solutions for specific problems.

### Origin

The CISC approach grew out of an evolution of processors. This acronym only began to be used after the creation of the RISC concept in the early 1980s (to be seen in the next module), when previous processors began to be called CISC retroactively.

### Evolution

| Processor | Year | Instruction Size | Number of Instructions | Register Size | Addressing |
|-----------|------|------------------|------------------------|---------------|------------|
| IBM 370   | 1970 | 2 to 6 bytes     | 208                    | 32 bits       | R-R; R-M; M-M |
| VAX11     | 1978 | 2 to 57 bytes    | 303                    | 32 bits       | R-R; R-M; M-M |
| Intel 8008 | 1972 | 1 to 3 bytes    | 49                     | 8 bits        | R-R; R-M; M-M |
| Intel 286 | 1982 | 2 to 5 bytes     | 175                    | 16 bits       | R-R; R-M; M-M |
| Intel 386 | 1985 | 2 to 16 bytes    | 312                    | 32 bits       | R-R; R-M; M-M |

### Addressing

- **R-R**: Registers are used for input and output.
- **R-M**: When one of the elements (operands or result) must be fetched/written in memory and at least one in register.
- **M-M**: When both operands must be fetched/written in memory.

When fetching and writing in memory, the processor must perform a memory access, which is a relatively slow operation. Therefore, the fewer memory accesses, the better.

### Problems

- **Complexity**: The number of instructions is extensive and the Control Unit is quite complex to decode an instruction to be executed.
- **Space**: The number of instructions is extensive, which makes the Control Unit more complex and takes up more space from the registers.
- **Time**: Fetching operands from memory is a relatively slow operation.

> **Note**: This implementation is done in the processors (pipeline) in a similar way. One of the characteristics of CISC computers is the complexity of their pipelines. Some even had 31 pipeline stages.

### Pipelines

See examples of pipeline stages on Intel microarchitectures:

| Microarchitecture | Pipeline Stages |
|-------------------|-----------------|
| P5 (Pentium)      | 5               |
| P6 (Pentium 3)    | 14              |
| P6 (Pentium Pro)  | 14              |
| NetBurst (Willamette) | 20       |
| NetBurst (Northwood)  | 20       |
| NetBurst (Prescott)   | 31       |
| NetBurst (Cedar Mill) | 31       |
| Core               | 14              |
| Broadwell          | 14 to 19        |
| Sandy Bridge       | 14              |
| Silvermont         | 14 to 17        |
| Haswell            | 14 to 19        |
| Skylake            | 14 to 19        |
| Kabylake           | 14 to 19        |

> **Note**: The problems were not solved with pipelining. The approach still presents bottlenecks, mainly in the memory access operations.

## RISC

### RISC Approach on Processor architecture

**RISC** stands for **Reduced Instruction Set Computer**: This approach has few generic instructions, with which more complex operations are assembled. In addition, the instructions perform operations only on the registers, except in the case of specific instructions, which only serve to fetch or store data in memory.

### Problems Solved

- **Complexity**: With fewer instructions, it's easier to decode an instruction to be executed.
- **Space**: The number of instructions is reduced, which makes the Control Unit simpler and takes up less space from the registers.
- **Time**: With RISC architecture, the number of memory accesses is reduced by only performing operations in registers.

### Origin

This approach was created in the early 1980s, when trying to solve the problems of the CISC approach.

### Pipeline

Steps of the pipeline:

- **SI**: Search for the instruction in the instruction cache.
- **ID**: Instruction decoding.
- **EXE**: Execution of the instruction.
- **MA**: Memory access.
- **WB**: Write back.

The execution of the instruction by clock pulse is shown below:

| Clock Pulse | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
|-------------|---|---|---|---|---|---|---|---|---|----|
| Load        | **SI** | **ID** | **EXE** | **MA** | **MA** | **WB** | - | - | - | - |
| Add         | - | **SI** | **ID** | + | + | **EXE** | **MA** | **WB** | - | - |
| Store       | - | - | **SI** | **ID** | + | + | **EXE** | **MA** | **MA** | **WB** |

> **Note**: The pipeline is not always executed in this order. The order of execution depends on the instruction and the microarchitecture.

### Example

Here are some architectures that use the RISC approach:

| Processor | Year | Addressing | Registers | Instruction Size |
|-----------|------|------------|-----------|------------------|
| MIPS      | 1981 | R-R        | 04 to 32  | 4 bytes          |
| ARM/A32   | 1983 | R-R        | 15        | 4 bytes          |
| SPARC     | 1985 | R-R        | 32        | 4 bytes          |
| PowerPC   | 1990 | R-R        | 32        | 4 bytes          |
|  |  | R-R |  | 4 bytes |

We can see two common features of the RISC approach:

- **Fixed instruction size**: To simplify decoding.
- **Operations with addressing**: Registrar-Register.

# Footer

- **Class**: Computer Architecture
- **Theme**: CISC X RISC Architecture