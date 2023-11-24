---
title: "Parallel Processing"
---

## Superscalar Processors and Pipelines

Basically, I'll start with a basic concept that is important for us here.

### Pipeline and Pipeline Hazards

Pipelines are a way to increase the throughput of a processor. A pipeline is a sequence of stages, each of which performs a different part of the instruction. The processor fetches the next instruction while the current instruction is being processed. The processor can execute multiple instructions at the same time, as long as they are in different stages during the clock cycle.

Pipeline hazards are situations in which the processor cannot continue to execute instructions because of a dependency between instructions. There are three types of pipeline hazards:

- **Structural hazards**: These are caused by the physical design of the processor. For example, the processor may not have enough registers to hold all the operands needed for an instruction.
- **Data hazards**: These are caused by the instructions themselves. For example, an instruction may need to read a value that has not yet been written by a previous instruction.
- **Control hazards**: These are caused by the program itself. For example, an instruction may need to read a value that has not yet been written by a previous instruction.

### Superscalar Processors

Superscalar processors are processors that can execute multiple instructions per clock cycle. They are able to do this by using multiple functional units and multiple pipelines.

The registers in a superscalar processor are divided into two groups: **general-purpose registers and special-purpose registers**. The general-purpose registers are used to hold operands and results of instructions. The special-purpose registers are used to hold control information.

### Superpipelining

Superpipelining is a technique that allows a processor to execute multiple instructions per clock cycle. It is similar to superscalar processing, but it uses a single pipeline. The processor can execute multiple instructions per clock cycle by using multiple functional units.

In a superpipelined processor, two stages of pipelines are executed and the functions of the stages are divided into two parts that don't overlap and each one can be executed in a half of the clock cycle.

## Types of Parallel Processors

### Flynn Taxonomy

The Flynn taxonomy is a classification of parallel processors based on the number of instruction streams and the number of data streams. The taxonomy is named after John Flynn, who first proposed it in 1966.

The taxonomy classifies processors into four categories:

- **Single Instruction Stream, Single Data Stream (SISD)**: This is the most basic type of processor. It has a single instruction stream and a single data stream. It executes instructions sequentially, one at a time.
- **Single Instruction Stream, Multiple Data Stream (SIMD)**: This type of processor has a single instruction stream and multiple data streams. It executes the same instruction on multiple data streams in parallel.
- **Multiple Instruction Stream, Single Data Stream (MISD)**: This type of processor has multiple instruction streams and a single data stream. It executes different instructions on the same data stream in parallel.
- **Multiple Instruction Stream, Multiple Data Stream (MIMD)**: This type of processor has multiple instruction streams and multiple data streams. It executes different instructions on different data streams in parallel.

### Symmetrical Multiprocessors

Symmetrical multiprocessors (SMPs) are parallel processors that have multiple processors that are identical in function and performance. SMPs are also known as shared-memory multiprocessors.

### Cache Coherence in Multiprocessors

Cache coherence is the process of keeping the caches of all the processors in a multiprocessor consistent.

- **UMA (Uniform Memory Access)**: In a UMA system, all processors have access to the same memory. This means that all processors can access the same memory location at the same time. This is the simplest type of multiprocessor system.
- **NUMA (Non-Uniform Memory Access)**: In a NUMA system, the processors have access to different parts of the memory. This means that the processors can access different memory locations at the same time. This is a more complex type of multiprocessor system. NUMA with cache coherence is called CC-NUMA.

### Memory Access Architectures

Taxonomy of multiple processors and classification according to memory access. Processes organization:

- **SISD (Single Instruction Stream, Single Data Stream)**: Single processor.
- **SIMD (Single Instruction Stream, Multiple Data Stream)**: Vectorial processor and Matrix processor.
- **MISD (Multiple Instruction Stream, Single Data Stream)**: Multiple processors with a single instruction stream (nothing to show).
- **MIMD (Multiple Instruction Stream, Multiple Data Stream)**: Shared memory with symmetric multiprocessors (SMP) and with non-uniform memory access (NUMA). Distributed memory with clusters.

## Hardware Performance

### Multicore Processors

Multicore processors are processors that have multiple processing cores. Each core is a separate processor that can execute instructions in parallel with the other cores. While the last generation of processors had an L1 cache for data, another for instructions and an L2 cache, multicore processors have in each processor an L1 cache and an shared L2 cache, at least.

### Software Performance

Different analysis can be done to measure the performance of a program, starting from the measure of time for the program to run the serial parts and the parallelizable part, considering scaling overload.

- **Native multi-threading applications (Thread level parallelism)**: They're characterized by the small number of processes with a high level of parallelism.
- **Multiple processes applications (Process level parallelism)**: They're characterized by the large number of processes of a single thread (threads can be considered as flux of a process).
- **Java applications**: They accept threads in a natural way, that is, the Java Virtual Machine (JVM) is a multithreaded process that allows scaling and memory management for Java applications.
- **Multiple instances applications (Application level parallelism)**: Even if an individual application cannot scale to take advantage of a large number of threads, it is still possible to benefit from running multiple instances of the application in parallel.

### Multicore Organization

- Number of processors in chip;
- Number of levels of cache;
- Amount of shared memory;
- Use of simultaneous multithreading (SMT).

### Levels of cache and shared cache

- **Dedicated L1 cache**: Each core has its own L1 cache.
- **Dedicated L2 cache**: L1 caches are not shared, but in this case there enough space to have a L2 cache, like AMD Opteron or Athlon X2.
- **Shared L2 cache**: An organization similar to the previous item is represented, but now the use of L2 cache is shared. The use of shared L2 caches on the chip has numerous advantages when compared to the exclusive dependence on dedicated caches, such as, for example, more efficient communication between processors and the implementation of coherent caches.
- **Shared L3 cache**: The L3 cache is shared between all cores on the chip. This organization is used in the Intel Core i7.

### SMT (Simultaneous Multithreading)

Simultaneous multithreading is a technique for improving the overall efficiency of superscalar CPUs with hardware multithreading. SMT permits multiple independent threads of execution to better use the resources provided by modern processor architectures.

# Footer

- **Class**: Computer Architecture
- **Theme**: Parallel Processing