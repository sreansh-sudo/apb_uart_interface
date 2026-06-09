# APB UART Interface

## Overview

This project implements a simple **APB (Advanced Peripheral Bus) to UART bridge** in Verilog. The design demonstrates how an APB slave peripheral can communicate with a UART module through memory-mapped registers.

The project includes:

* APB slave interface
* UART communication model
* Register-mapped data transfer
* Status register reporting
* Verilator-compatible testbench
* Waveform generation for debugging and verification

This project is intended for learning and demonstrating digital design, SoC peripheral integration, and verification concepts.

---

## Architecture

```text
+-------------------+
|    APB Master     |
+---------+---------+
          |
          v
+-------------------+
|  APB UART Bridge  |
+---------+---------+
          |
          v
+-------------------+
|       UART        |
+-------------------+
```

The APB UART Bridge receives APB transactions and converts them into UART operations.

---

## Register Map

| Address | Register | Description          |
| ------- | -------- | -------------------- |
| 0x00    | TX_DATA  | Write transmit data  |
| 0x04    | RX_DATA  | Read received data   |
| 0x08    | STATUS   | UART status register |

### STATUS Register

| Bit | Name     | Description             |
| --- | -------- | ----------------------- |
| 0   | RX_READY | Received data available |
| 1   | TX_BUSY  | UART transmitter busy   |

---

## Project Structure

```text
apb_uart_interface/
│
├── apb_uart_bridge.v   # APB slave interface
├── uart.v              # UART model
├── apb_uart_top.v      # Top-level integration
├── apb_uart_tb.v       # Testbench
├── run.sh              # Simulation script
├── README.md
└── .gitignore
```

---

## Module Description

### apb_uart_bridge.v

Implements the APB slave interface.

Responsibilities:

* Handles APB read and write transactions
* Provides memory-mapped register access
* Controls UART transmission
* Returns UART status information

### uart.v

A simplified UART model used for functional verification.

Current functionality:

* Accepts transmitted data
* Generates transmit busy status
* Loops transmitted data back to the receiver
* Generates receive-ready indication

Note: This is a behavioral UART model intended for verification and educational purposes. It is not a complete UART implementation with baud-rate generation or serial line communication.

### apb_uart_top.v

Top-level wrapper connecting the APB bridge and UART modules.

### apb_uart_tb.v

Self-checking testbench that:

* Generates APB transactions
* Performs read and write operations
* Includes timeout protection
* Generates waveform dumps (.vcd)

---

## APB Write Operation

Writing data to address `0x00` triggers UART transmission.

Example:

```verilog
apb_write(32'h00, 32'hA5);
```

---

## APB Read Operations

Read received data:

```verilog
apb_read(32'h04);
```

Read status register:

```verilog
apb_read(32'h08);
```

---

## Simulation

### Using Verilator

Compile and run:

```bash
chmod +x run.sh
./run.sh
```

Waveform output:

```text
apb_uart_dump.vcd
```

View waveform:

```bash
gtkwave apb_uart_dump.vcd
```

---

## Test Sequence

The testbench performs the following operations:

1. Apply reset
2. Write data `0xA5`
3. Read RX register
4. Read status register
5. Write data `0x3C`
6. Read RX register
7. Read status register
8. End simulation

---

## Features

* APB slave protocol support
* Register-mapped UART interface
* UART loopback functionality
* Status monitoring
* Timeout-protected verification
* Waveform generation
* Verilator compatible

---

## Future Improvements

Possible enhancements:

* Real UART transmitter state machine
* Real UART receiver state machine
* Baud rate generator
* TX FIFO
* RX FIFO
* Interrupt support
* APB wait-state handling
* SystemVerilog assertions
* Functional coverage

---

## Tools Used

* Verilog HDL
* Verilator
* GTKWave
* Git
* GitHub

---

## Learning Outcomes

This project demonstrates:

* APB protocol fundamentals
* Peripheral register mapping
* RTL design methodology
* Testbench development
* Hardware verification
* Simulation and waveform debugging

---

## Author

**Sreansh Verma**

B.Tech Student | Digital Design | VLSI | Embedded Systems | AI & ML
