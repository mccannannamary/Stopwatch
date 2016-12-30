`timescale 1ns / 1ps
module TB_pulseGenerator;
	// Inputs to module being verified
	reg clk5, reset;
	// Outputs from module being verified
	wire pulse10Hz;
	// Instantiate module
	pulseGenerator uut (
		.clk5(clk5),
		.reset(reset),
		.pulse10Hz(pulse10Hz)
		);
	// Generate clock signal
	initial
		begin
			clk5  = 1'b1;
			forever
				#100 clk5  = ~clk5 ;
		end
	// Generate other input signals
	initial
		begin
			reset = 1'b0;
			#250
			reset = 1'b1;
			#900
			reset = 1'b0;
			#10850
			$stop;
		end
endmodule
