module contador(
	input clk,
	
	output cont
);

	reg [16:0] vetor;
	assign cont = vetor[16];

	always@(posedge clk) begin
		vetor = vetor + 1;
	end

endmodule