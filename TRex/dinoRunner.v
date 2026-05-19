module dinoRunner (
	input key,
	input clk,
	input reset,
	
	output reg [6:0] topo,
	output reg [9:0] posicaoC,
	output reg [9:0] posicaoP,
	output reg [6:0] pontuacao,
	output reg colisao,
	output reg dia
);

	reg sobe;
	reg desce;
	reg tempoC;
	reg tempo;
	
	initial begin
		colisao = 0;
		posicaoC = 639;
		posicaoP = 1023;
		pontuacao = 0;
		topo = 0;
		sobe = 0;
		desce = 0;
		tempoC = 0;
		dia = 1;
		tempo = 0;
	end

	always@(posedge clk or posedge reset) begin
		if (reset) begin
			topo <= 0;
			sobe <= 0;
			desce <= 0;
			tempoC <= 0;
			posicaoC <= 639;
			posicaoP <= 1023;
			pontuacao <= 0;
			tempo <= 0;
			dia <= 1;
		end else if (!colisao) begin
			if (topo == 0 && key) begin
				sobe <= 1;
			end
			if (topo == 100) begin
				sobe <= 0;
				desce <= 1;
			end
			if (topo == 1) begin
				topo <= 0;
				desce <= 0;
			end
			if (sobe == 1) begin
				topo <= topo + 1;
			end
			if (desce == 1) begin
				topo <= topo - 1;
			end
			if (posicaoC == 0) begin
				posicaoC <= 639;
				pontuacao <= pontuacao + 1;
			end
			if (posicaoP == 0) begin
				posicaoP <= 1023;
			end
			posicaoP <= posicaoP - 1;
			if (tempoC != 1) begin
				tempoC <= 1;
			end
			if (tempoC == 1) begin
				posicaoC <= posicaoC - 1;
				tempoC <= 0;
			end
			if (pontuacao % 10 == 0 && tempo) begin
				dia <= dia^1;
				tempo <= 0;
			end
			if (pontuacao % 10 != 0) begin
				tempo <= 1;
			end
		end
	end
	
	always@(*) begin
		if (reset) begin
			colisao <= 0;
		end
		if (topo >= 0 && topo < 16 && posicaoC >= 50 && posicaoC < 60 || topo <= 100 && topo > 85 && posicaoP >= 50 && posicaoP < 60) begin
			colisao <= 1;
		end
	end

endmodule