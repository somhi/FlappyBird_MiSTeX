`timescale 1ns/10ps
module  pll_0002(
	input wire refclk,
	input wire rst,
	output wire outclk_0,
	output wire locked
);

	wire feedback;

	wire outclk_0_bufg;
	
	PLLE2_ADV #(
		.CLKFBOUT_MULT(6'd20),
		.CLKIN1_PERIOD(20.0),
		.CLKOUT0_DIVIDE(7'd50), // 20 MHz = 50 MHz * 20 / 50
		.CLKOUT0_PHASE(1'd0),
		.DIVCLK_DIVIDE(1'd1),
		.REF_JITTER1(0.01),
		.STARTUP_WAIT("FALSE")
	) PLLE2_ADV (
		.CLKFBIN(feedback),
		.CLKIN1(refclk),
		.PWRDWN(1'b0),
		.RST(rst),
		.CLKFBOUT(feedback),
		.CLKOUT0(outclk_0_bufg),
		.LOCKED(locked)
	);

	BUFG outclk_bufg_0 (.I(outclk_0_bufg), .O(outclk_0));
	
endmodule
