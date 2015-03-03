//	DE0_Digital_IO_Wing.v
//	Author: Parker Dillmann
//	Website: http://www.longhornengineer.com
// Github: https://github.com/LonghornEngineer

module DE0_Digital_IO_Wing
(
	 clk, DIRA, DIRB, DIRC, DIRD, INA, INB, INC, IND, OUTA, OUTB, OUTC, OUTD,
	 IOA, IOB, IOC, IOD, BUSA, BUSB, BUSC, BUSD, OEA, OEB, OEC, OED
);

input	wire			clk;

//Direction Control from top level module
input	wire			DIRA;
input	wire			DIRB;
input	wire			DIRC;
input	wire			DIRD;

//Input bus from top level module
input			[7:0]	INA;
input			[7:0]	INB;
input			[7:0]	INC;
input			[7:0]	IND;

//Output bus to top level module
output		[7:0]	OUTA;
output		[7:0]	OUTB;
output		[7:0]	OUTC;
output		[7:0]	OUTD;

//Direction Control to SN74LVC8T245PWR
output		[0:0]	IOA;
output		[0:0]	IOB;
output		[0:0]	IOC;
output		[0:0]	IOD;

//Bidirectional bus to SN74LVC8T245PWR
inout			[7:0]	BUSA;
inout			[7:0]	BUSB;
inout			[7:0]	BUSC;
inout			[7:0]	BUSD;

//Output Enable to SN74LVC8T245PWR
output		[0:0]	OEA;
output		[0:0]	OEB;
output		[0:0]	OEC;
output		[0:0]	OED;

reg			[7:0]	tempA0;
reg			[7:0]	tempA1;
reg			[7:0]	tempB0;
reg			[7:0]	tempB1;
reg			[7:0]	tempC0;
reg			[7:0]	tempC1;
reg			[7:0]	tempD0;
reg			[7:0]	tempD1;

assign	BUSA = DIRA ? tempA0 : 8'bZ;
assign	OUTA = tempA1;

assign	BUSB = DIRB ? tempB0 : 8'bZ;
assign	OUTB = tempB1;

assign	BUSC = DIRC ? tempC0 : 8'bZ;
assign	OUTC = tempC1;

assign	BUSD = DIRD ? tempD0 : 8'bZ;
assign	OUTD = tempD1;

assign	IOA  = DIRA;
assign	IOB  = DIRB;
assign	IOC  = DIRC;
assign	IOD  = DIRD;

initial
	begin
		OEA <= 0;
		OEB <= 0;
		OEC <= 0;
		OED <= 0;
	end


always @(posedge clk)
	begin
		tempA1 <= BUSA;
		tempA0 <= INA;
		
		tempB1 <= BUSB;
		tempB0 <= INB;
		
		tempC1 <= BUSC;
		tempC0 <= INC;
		
		tempD1 <= BUSD;
		tempD0 <= IND;
	end
	
endmodule
