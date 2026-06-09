#!/bin/bash
set -e

# ----------------------------------------------------------------
# Config
# ----------------------------------------------------------------
TOP=apb_uart_tb
VCD_FILE=apb_uart_dump.vcd
BUILD_DIR=obj_dir

# ----------------------------------------------------------------
# Step 1: Compile and build simulation binary
# ----------------------------------------------------------------
echo ">>> Compiling with Verilator..."
verilator \
    --binary \
    --timing \
    --trace \
    -j 0 \
    -Wall \
    --top-module ${TOP} \
    --CFLAGS "-std=c++20" \
    uart.v \
    apb_uart_bridge.v \
    apb_uart_top.v \
    apb_uart_tb.v

# ----------------------------------------------------------------
# Step 2: Run simulation
# ----------------------------------------------------------------
echo ">>> Running simulation..."
${BUILD_DIR}/V${TOP}

# ----------------------------------------------------------------
# Step 3: Open waveform
# ----------------------------------------------------------------
if [ -f "${BUILD_DIR}/${VCD_FILE}" ]; then
    echo ">>> Opening waveform..."
    gtkwave "${BUILD_DIR}/${VCD_FILE}"
else
    echo "Error: VCD file not found at ${BUILD_DIR}/${VCD_FILE}"
    exit 1
fi
