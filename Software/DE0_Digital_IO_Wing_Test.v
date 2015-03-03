//	DE0_Digital_IO_Wing.v
//	Author: Parker Dillmann
//	Website: http://www.longhornengineer.com
// Github: https://github.com/LonghornEngineer

module DE0_Digital_IO_Wing_Test
(
	 clk_50,
	 IOA, IOB, IOC, IOD, BUSA, BUSB, BUSC, BUSD, OEA, OEB, OEC, OED
);


input	wire			clk_50;

//Direction Control from top level module
reg			[0:0]	DIRA;
reg			[0:0]	DIRB;
reg			[0:0]	DIRC;
reg			[0:0]	DIRD;

//Input bus from Wing_driver
wire			[7:0]	INA;
wire			[7:0]	INB;
wire			[7:0]	INC;
wire			[7:0]	IND;

//Output bus to Wing_driver
reg			[7:0]	OUTA;
reg			[7:0]	OUTB;
reg			[7:0]	OUTC;
reg			[7:0]	OUTD;

//Direction Control passed from Wing_driver
output		[0:0]	IOA;
output		[0:0]	IOB;
output		[0:0]	IOC;
output		[0:0]	IOD;

//Bidirectional bus passed from Wing_driver
inout			[7:0]	BUSA;
inout			[7:0]	BUSB;
inout			[7:0]	BUSC;
inout			[7:0]	BUSD;

//Output Enable passed from Wing_driver
output		[0:0]	OEA;
output		[0:0]	OEB;
output		[0:0]	OEC;
output		[0:0]	OED;

reg			[7:0]	inputA;
reg			[7:0]	inputB;
reg			[7:0]	inputC;
reg			[7:0]	inputD;

initial
	begin
		DIRA <= 1;
		DIRB <= 1;
		DIRC <= 1;
		DIRD <= 1;
	
		OUTA <= 8'b0000_0000;
		OUTB <= 8'b0000_0000;
		OUTC <= 8'b0000_0000;
		OUTD <= 8'b0000_0000;
	end
	
always @(posedge	clk_50)
	begin
		OUTA <= OUTA + 8'b0000_0001;
		OUTB <= OUTB + 8'b0000_0001;
		OUTC <= OUTC + 8'b0000_0001;
		OUTD <= OUTD + 8'b0000_0001;	
		
		inputA <= INA;
		inputB <= INB;
		inputC <= INC;
		inputD <= IND;
		
		if(OUTA == 8'b1111_1111)
		begin
			DIRA <= 0;
			DIRB <= 0;
			DIRC <= 0;
			DIRD <= 0;
		end
		else
		begin
			DIRA <= 1;
			DIRB <= 1;
			DIRC <= 1;
			DIRD <= 1;			
		end
	end
	

	DE0_Digital_IO_Wing Wing_driver
	(		
		.clk(clk_50),
		.DIRA(DIRA), 
		.DIRB(DIRB),
		.DIRC(DIRC),
		.DIRD(DIRD),
		.INA(OUTA),
		.INB(OUTB),
		.INC(OUTC), 
		.IND(OUTD), 
		.OUTA(INA), 
		.OUTB(INB), 
		.OUTC(INC), 
		.OUTD(IND),
		.IOA(IOA), 
		.IOB(IOB), 
		.IOC(IOC), 
		.IOD(IOD), 
		.BUSA(BUSA), 
		.BUSB(BUSB), 
		.BUSC(BUSC), 
		.BUSD(BUSD), 
		.OEA(OEA), 
		.OEB(OEB), 
		.OEC(OEC), 
		.OED(OED)
	);
	
endmodule