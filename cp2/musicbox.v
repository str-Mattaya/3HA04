module musicbox(clk, sw1, sw2, sw3, dsw, spk1, spk2, spk3);

input clk, sw1, sw2, sw3, dsw;
output spk1, spk2, spk3;

parameter hundred = 3, ten = 8, digit = 6; // the last 3-digits of my student id is 383 -> 386

buzzer b1(clk, sw1, dsw, hundred, spk1);
buzzer b2(clk, sw2, dsw, ten, spk2);
buzzer b3(clk, sw3, dsw, digit, spk3);

endmodule