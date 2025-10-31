`timescale 1ns/1ns

module uart_tb;
    reg clk;
    reg rst;
    reg start_tx;
    reg [7:0] data_in;
    wire tx_line;
    wire [7:0] data_out;
    wire rx_ready;

    // генерація такту (1 біт = 20 ns)
    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        // ініціалізація
        rst = 1;
        start_tx = 0;
        data_in = 8'h41; // символ 'A'
        #50 rst = 0;

        // перший байт
        #50 start_tx = 1;
        #20 start_tx = 0;

        // другий байт
        #200 start_tx = 1;
        data_in = 8'h42; // символ 'B'
        #20 start_tx = 0;

        #500 $stop;
    end

    // Інстанція uart_top
    uart_top uut (
        .clk(clk),
        .rst(rst),
        .start_tx(start_tx),
        .data_in(data_in),
        .tx_line(tx_line),
        .data_out(data_out),
        .rx_ready(rx_ready)
    );
endmodule
