module musicbox(clk, buzz, led);

input clk;
output buzz;
output reg led;

reg [25:0] counter = 0;
parameter base_limiter = 50_000_000 / 4;	// 0.25 s
parameter delay = 50_000_000 * 3 / 100;		// 0.03 s
reg [29:0] limiter;

reg [6:0] index = 0;
reg [2:0] note = 0;
reg pitch = 0;
reg [3:0] length = 0;
reg [3:0] len = 0;

always @(*) begin
    if (len >= length) begin
        // this will create a blank note between 2 notes
        note = 0;
        pitch = 0;
    end else begin
        // note timing for [ Cave Story BGM: Moonsong ]
        case(index)
            0:  begin note = 5;  pitch = 0;  length = 2;  end
            1:  begin note = 7;  pitch = 0;  length = 1;  end
            2:  begin note = 1;  pitch = 1;  length = 1;  end
            3:  begin note = 0;  pitch = 0;  length = 1;  end
            4:  begin note = 2;  pitch = 1;  length = 2;  end
            5:  begin note = 7;  pitch = 0;  length = 9;  end
            6:  begin note = 5;  pitch = 0;  length = 2;  end
            7:  begin note = 7;  pitch = 0;  length = 1;  end
            8:  begin note = 1;  pitch = 1;  length = 1;  end
            9:  begin note = 0;  pitch = 0;  length = 1;  end
            10: begin note = 2;  pitch = 1;  length = 2;  end
            11: begin note = 7;  pitch = 0;  length = 9;  end
            12: begin note = 7;  pitch = 0;  length = 3;  end
            13: begin note = 1;  pitch = 1;  length = 3;  end
            14: begin note = 2;  pitch = 1;  length = 3;  end
            15: begin note = 3;  pitch = 1;  length = 3;  end
            16: begin note = 2;  pitch = 1;  length = 1;  end
            17: begin note = 0;  pitch = 0;  length = 1;  end
            18: begin note = 1;  pitch = 1;  length = 1;  end
            19: begin note = 0;  pitch = 0;  length = 1;  end
            20: begin note = 4;  pitch = 1;  length = 3;  end
            21: begin note = 3;  pitch = 1;  length = 3;  end
            22: begin note = 2;  pitch = 1;  length = 3;  end
            23: begin note = 1;  pitch = 1;  length = 3;  end
            24: begin note = 7;  pitch = 0;  length = 4;  end
			
			25: begin note = 7;  pitch = 0;  length = 3;  end
            26: begin note = 1;  pitch = 1;  length = 2;  end
            27: begin note = 0;  pitch = 0;  length = 1;  end
            28: begin note = 7;  pitch = 0;  length = 3;  end
            29: begin note = 1;  pitch = 1;  length = 2;  end
            30: begin note = 0;  pitch = 0;  length = 1;  end
            31: begin note = 7;  pitch = 0;  length = 2;  end
            32: begin note = 4;  pitch = 0;  length = 2;  end
            33: begin note = 5;  pitch = 0;  length = 3;  end
            34: begin note = 7;  pitch = 0;  length = 2;  end
            35: begin note = 0;  pitch = 0;  length = 1;  end
            36: begin note = 5;  pitch = 0;  length = 3;  end
            37: begin note = 7;  pitch = 0;  length = 2;  end
            38: begin note = 0;  pitch = 0;  length = 1;  end
            39: begin note = 5;  pitch = 0;  length = 2;  end
            40: begin note = 7;  pitch = 0;  length = 5;  end
            41: begin note = 1;  pitch = 1;  length = 2;  end
            42: begin note = 0;  pitch = 0;  length = 1;  end
            43: begin note = 7;  pitch = 0;  length = 3;  end
            44: begin note = 1;  pitch = 1;  length = 2;  end
            45: begin note = 0;  pitch = 0;  length = 1;  end
            46: begin note = 7;  pitch = 0;  length = 2;  end
            47: begin note = 4;  pitch = 0;  length = 2;  end
            48: begin note = 5;  pitch = 0;  length = 3;  end
            49: begin note = 7;  pitch = 0;  length = 2;  end
            50: begin note = 0;  pitch = 0;  length = 1;  end
            51: begin note = 5;  pitch = 0;  length = 3;  end
            52: begin note = 7;  pitch = 0;  length = 2;  end
            53: begin note = 0;  pitch = 0;  length = 1;  end
            54: begin note = 7;  pitch = 0;  length = 1;  end
            55: begin note = 1;  pitch = 1;  length = 1;  end
            56: begin note = 3;  pitch = 1;  length = 3;  end
			
            57: begin note = 5;  pitch = 0;  length = 1;  end
            58: begin note = 4;  pitch = 0;  length = 1;  end
            59: begin note = 5;  pitch = 0;  length = 1;  end
            60: begin note = 7;  pitch = 0;  length = 1;  end
            61: begin note = 4;  pitch = 0;  length = 1;  end
            62: begin note = 0;  pitch = 0;  length = 1;  end
            63: begin note = 5;  pitch = 0;  length = 1;  end
            64: begin note = 4;  pitch = 0;  length = 1;  end
            65: begin note = 5;  pitch = 0;  length = 1;  end
            66: begin note = 7;  pitch = 0;  length = 1;  end
            67: begin note = 1;  pitch = 0;  length = 1;  end
            68: begin note = 0;  pitch = 0;  length = 1;  end
            69: begin note = 4;  pitch = 0;  length = 1;  end
            70: begin note = 3;  pitch = 0;  length = 1;  end
            71: begin note = 2;  pitch = 0;  length = 1;  end
            72: begin note = 3;  pitch = 0;  length = 1;  end
            73: begin note = 4;  pitch = 0;  length = 1;  end
            74: begin note = 3;  pitch = 0;  length = 1;  end
            75: begin note = 4;  pitch = 0;  length = 1;  end
            76: begin note = 5;  pitch = 0;  length = 1;  end
            77: begin note = 1;  pitch = 0;  length = 1;  end
            78: begin note = 0;  pitch = 0;  length = 1;  end
            79: begin note = 4;  pitch = 0;  length = 1;  end
            80: begin note = 3;  pitch = 0;  length = 1;  end
            81: begin note = 4;  pitch = 0;  length = 1;  end
            82: begin note = 5;  pitch = 0;  length = 1;  end
            83: begin note = 1;  pitch = 0;  length = 2;  end
            84: begin note = 2;  pitch = 0;  length = 2;  end
            85: begin note = 3;  pitch = 0;  length = 2;  end
            86: begin note = 5;  pitch = 0;  length = 1;  end
            87: begin note = 4;  pitch = 0;  length = 1;  end
            88: begin note = 5;  pitch = 0;  length = 1;  end
            89: begin note = 7;  pitch = 0;  length = 1;  end
            90: begin note = 4;  pitch = 0;  length = 1;  end
            91: begin note = 0;  pitch = 0;  length = 1;  end
            92: begin note = 5;  pitch = 0;  length = 1;  end
            93: begin note = 4;  pitch = 0;  length = 1;  end
            94: begin note = 5;  pitch = 0;  length = 1;  end
            95: begin note = 7;  pitch = 0;  length = 2;  end
            96: begin note = 1;  pitch = 0;  length = 1;  end
            97: begin note = 0;  pitch = 0;  length = 1;  end
            98: begin note = 5;  pitch = 0;  length = 1;  end
            99: begin note = 4;  pitch = 0;  length = 1;  end
           100: begin note = 3;  pitch = 0;  length = 1;  end
           101: begin note = 4;  pitch = 0;  length = 1;  end
           102: begin note = 3;  pitch = 0;  length = 1;  end
           103: begin note = 4;  pitch = 0;  length = 1;  end
           104: begin note = 5;  pitch = 0;  length = 1;  end
           105: begin note = 4;  pitch = 0;  length = 2;  end
           106: begin note = 5;  pitch = 0;  length = 1;  end
           107: begin note = 7;  pitch = 0;  length = 1;  end
           108: begin note = 7;  pitch = 0;  length = 1;  end
           109: begin note = 3;  pitch = 1;  length = 1;  end
           110: begin note = 3;  pitch = 1;  length = 1;  end
           111: begin note = 2;  pitch = 1;  length = 1;  end
           112: begin note = 2;  pitch = 1;  length = 1;  end
           113: begin note = 1;  pitch = 1;  length = 1;  end
           114: begin note = 7;  pitch = 0;  length = 1;  end
            default: begin note = 0;  pitch = 0;  length = 6; end
        endcase
    end
end

always @(posedge clk) begin
    if (index > 115) begin
        // loop
        index = 0;
    end else begin
        
		counter = counter + 1;
		if (len >= length) begin
			// create delay between note
			if (counter >= delay) begin
				counter = 0;
				len = 0;
                index = index + 1;
			end
		end else begin
			// each note playing
			if (counter >= base_limiter) begin
				counter = 0;
				len = len + 1;
			end
		end
        
    end
end

buzzer bz1(clk, pitch, note, buzz);

endmodule