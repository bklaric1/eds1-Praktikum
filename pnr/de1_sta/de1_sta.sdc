create_clock -period 20.000 -name clk clk
set_input_delay -clock clk 2 [all_inputs]
set_output_delay -clock clk 2 [all_outputs]
