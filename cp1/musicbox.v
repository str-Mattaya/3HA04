module musicbox(clk, sw1, sw2, sw3, spk1);

input clk, sw1, sw2, sw3;
output reg spk1;

reg [25:0] clk_counter = 0;
reg [25:0] limiter = 25_000_000;

parameter hundred = 3, ten = 8, digit = 6; // the last 3-digits of my student id is 383 -> 386
reg [3:0] num = 10;

always @(*) begin
	
	// check for pressing switch
	
	if (sw1 == 0) begin
		// Pressing S7 set num to 3 -- highest priority
		num = hundred;
	end else if (sw2 == 0) begin
		// Pressing S6 set num to 8
		num = ten;
	end else if (sw3 == 0) begin
		// Pressing S5 set num to 6
		num = digit;
	end else begin
		// Not pressing anything set num to 10 (which means no sound)
		num = 10;
	end
	
	// choose frequency via num
	case(num)
		1: limiter = 25_000_000 / 262; // C4
		2: limiter = 25_000_000 / 294; // D4
		3: limiter = 25_000_000 / 330; // E4
		4: limiter = 25_000_000 / 349; // F4
		5: limiter = 25_000_000 / 392; // G4
		6: limiter = 25_000_000 / 440; // A4
		7: limiter = 25_000_000 / 494; // B4
		8: limiter = 25_000_000 / 524; // C5
		9: limiter = 25_000_000 / 587; // D5
		0: limiter = 25_000_000 / 659; // E5
		default: limiter = 0;		   // No Sound
	endcase
	
end

// clock divider --> input frequency to buzzer

always @(posedge clk) begin

	clk_counter = clk_counter + 1;
	if (clk_counter >= limiter) begin
		if (limiter > 0) begin
			spk1 = ~spk1;
		end else begin
			spk1 = 0;
		end
		clk_counter = 0;
	end

end

endmodule