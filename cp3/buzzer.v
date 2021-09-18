module buzzer(clk, pitch, note, buzz);

input clk;
input [2:0] note;
input pitch;
output reg buzz;

reg [25:0] limiter = 25_000_000;
reg [25:0] counter = 0;

always @(*) begin
	
	case (note)
		1:  limiter = 25_000_000 / (pitch == 1 ? 523 : 261); // C
		2:  limiter = 25_000_000 / (pitch == 1 ? 587 : 293); // D
		3:  limiter = 25_000_000 / (pitch == 1 ? 622 : 311); // Eb
		4:  limiter = 25_000_000 / (pitch == 1 ? 698 : 349); // F
		5:  limiter = 25_000_000 / (pitch == 1 ? 784 : 392); // G
		6:  limiter = 25_000_000 / (pitch == 1 ? 830 : 415); // Ab
		7:  limiter = 25_000_000 / (pitch == 1 ? 932 : 466); // Bb
		default: limiter = 0;
	endcase
	
end

always @(posedge clk) begin
	
	counter = counter + 1;
	if (counter >= limiter) begin
		if (limiter > 0)
			buzz = ~buzz;
		else
			buzz = 0;
		counter = 0;
	end
	
end

endmodule