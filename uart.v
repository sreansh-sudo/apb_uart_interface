`timescale 1ns/1ps

module uart (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [7:0]  tx_data,
    input  wire        tx_write,
    output reg  [7:0]  rx_data,
    output reg         rx_ready,
    output reg         tx_busy
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rx_data  <= 8'h00;
            rx_ready <= 1'b0;
            tx_busy  <= 1'b0;
        end else begin
            rx_ready <= 1'b0;
            tx_busy  <= 1'b0;
            if (tx_write) begin
                tx_busy  <= 1'b1;
                rx_data  <= tx_data;
                rx_ready <= 1'b1;
            end
        end
    end

endmodule
