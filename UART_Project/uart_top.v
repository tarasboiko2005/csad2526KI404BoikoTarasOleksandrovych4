module uart_top(
    input clk,
    input rst,
    input start_tx,
    input [7:0] data_in,
    output tx_line,
    output [7:0] data_out,
    output rx_ready
);

    wire tx_busy;

    // TX
    uart_tx tx_inst (
        .clk(clk),
        .rst(rst),
        .start_tx(start_tx),
        .data_in(data_in),
        .tx_line(tx_line),
        .busy(tx_busy)
    );

    // RX (підключаємо tx_line до rx_line)
    uart_rx rx_inst (
        .clk(clk),
        .rst(rst),
        .rx_line(tx_line),
        .data_out(data_out),
        .data_ready(rx_ready)
    );

endmodule
