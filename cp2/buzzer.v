module buzzer(clk, sw, high_sw, num, buzz);

input clk, sw, high_sw;
input [3:0] num;
output reg buzz;

reg [25:0] limiter = 25_000_000;
reg [25:0] counter = 0;

always @(*) begin
	
	case (num)
		1: limiter = 25_000_000 / (high_sw == 1 ? 262 : 523);	// C4 - C5
		2: limiter = 25_000_000 / (high_sw == 1 ? 294 : 587);	// D4 - D5
		3: limiter = 25_000_000 / (high_sw == 1 ? 330 : 659);	// E4 - E5
		4: limiter = 25_000_000 / (high_sw == 1 ? 349 : 698);	// F4 - F5
		5: limiter = 25_000_000 / (high_sw == 1 ? 392 : 784);	// G4 - G5
		6: limiter = 25_000_000 / (high_sw == 1 ? 440 : 880);   // A4 - A5
		7: limiter = 25_000_000 / (high_sw == 1 ? 494 : 988);   // B4 - B5
		8: limiter = 25_000_000 / (high_sw == 1 ? 523 : 1047);  // C5 - C6
		9: limiter = 25_000_000 / (high_sw == 1 ? 587 : 1175);  // D5 - D6
		0: limiter = 25_000_000 / (high_sw == 1 ? 659 : 1319);  // E5 - E6
		default: limiter = 0;
	endcase
	
end

always @(posedge clk) begin
	
	if (sw == 0) begin
		counter = counter + 1;
		if (counter >= limiter) begin
			if (limiter > 0)
				buzz = ~buzz;
			else
				buzz = 0;
			counter = 0;
		end
	end
	
end

endmodule