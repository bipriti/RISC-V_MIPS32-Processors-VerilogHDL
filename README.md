## RISC-V Processor Implementation with Pipelining | MIPS32 | Verilog HDL

[Click here to view the project report](https://github.com/bipriti/RISC-V_MIPS32-Processors-VerilogHDL/blob/main/RISC-V%20Processor%20MIPS32_Project.pdf)

## Introduction

In this project, I designed and implemented a **32-bit RISC processor** based on the **MIPS32 architecture** using **Verilog HDL**. The goal was to create an efficient and high-performance processor using the RISC design principles, which enable streamlined execution of instructions. This project demonstrates my ability to handle digital design, develop complex hardware models, and implement pipelined architectures for optimized performance.

### RISC Processor & MIPS32 Architecture
A **Reduced Instruction Set Computer (RISC)** processor focuses on simplifying instruction sets to improve performance and reduce complexity. **MIPS32**, a widely used 32-bit RISC architecture, is known for its efficiency and simplicity. It supports a fixed instruction length of 32 bits, which makes decoding faster and allows for effective pipelining.

### 5 Stages of Processor Pipelining

To enhance the throughput and performance, the MIPS32 processor in this project is designed with a **5-stage pipeline architecture**:
1. **Instruction Fetch (IF)**: Retrieves the instruction from memory, and increments the Program Counter (PC).
2. **Instruction Decode (ID)**: Decodes the instruction and prepares operands by reading from registers.
3. **Execution (EX)**: The ALU performs the required operation (e.g., arithmetic, logic).
4. **Memory Access (MEM)**: Handles data loading or storing from/to memory.
5. **Write Back (WB)**: Writes the result of the operation back to the registers.

By incorporating pipelining, the processor can work on multiple instructions simultaneously, significantly improving overall efficiency and execution speed.

## Project Design file

- [Click here to view the design code of the RISC processor](https://github.com/bipriti/RISC-V_MIPS32-Processors-VerilogHDL/blob/main/RISC_pipe_MIPS32_DesignCode.v)
