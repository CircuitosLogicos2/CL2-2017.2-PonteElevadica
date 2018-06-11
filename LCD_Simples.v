module LCD_Simples(
  input	CLOCK_50,		//	50 MHz clock
  input	[3:0] KEY,    	//	Pushbutton[3:0]
  input 	[17:0] SW,		//	Toggle Switch[17:0]
  output reg [6:0]	HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,  // Seven Segment Digits
  output [8:0] LEDG,  	//	LED Green
  output [17:0] LEDR,  	//	LED Red
  inout 	[35:0] GPIO_0,GPIO_1,	//	GPIO Connections
  output LCD_ON,			// LCD Power ON/OFF
  output LCD_BLON,		// LCD Back Light ON/OFF
  output LCD_RW,			// LCD Read/Write Select, 0 = Write, 1 = Read
  output LCD_EN,			// LCD Enable
  output LCD_RS,			// LCD Command/Data Select, 0 = Command, 1 = Data
  inout [7:0] LCD_DATA	// LCD Data bus 8 bits
);

//	All inout port turn to tri-state
assign	GPIO_0	=	36'hzzzzzzzzz;
assign	GPIO_1	=	36'hzzzzzzzzz;

//wire [6:0] myclock;
//wire RST;
//assign RST = KEY[0]; //Button numer 0 resets

// reset delay gives some time for peripherals to initialize
wire DLY_RST;
Reset_Delay r0(	.iCLK(CLOCK_50),.oRESET(DLY_RST) );

// Send switches to red leds 
//assign LEDR = SW;

// turn LCD ON
assign	LCD_ON		=	1'b1;
assign	LCD_BLON		=	1'b1;

wire [3:0] hex1, hex0;
assign hex1 = SW[7:4];
assign hex0 = SW[3:0];

wire [6:0] seg;
wire [6:0] seg2;
wire [6:0] seg3;


LCD_Display u1(
// Host Side
   .iCLK_50MHZ(CLOCK_50),
   .iRST_N(DLY_RST),
   .hex0(hex0),
   .hex1(hex1),
	.segdisplay(seg),
	.segdisplay2(seg2),
	.segdisplay3(seg3),
	.LG(LEDG),
	.LR(LEDR),
// LCD Side
   .DATA_BUS(LCD_DATA),
   .LCD_RW(LCD_RW),
   .LCD_E(LCD_EN),
   .LCD_RS(LCD_RS)
);



// blank unused 7-segment digits
	


always@(*)
 begin
	//Clean Display 7Seg
	HEX0 = 7'b1111111;
	HEX1 = 7'b1111111;
	HEX2 = 7'b1111111;
	HEX3 = 7'b1111111;
	HEX4 = 7'b1111111;
	HEX5 = 7'b1111111;
	HEX6 = 7'b1111111;
	HEX7 = 7'b1111111;
 
	case(seg)
		7'b1000000: HEX4 = 7'b1000000; //0
		7'b1111001: HEX4 = 7'b1111001; //1
		7'b0100100: HEX4 = 7'b0100100; //2
		7'b0110000: HEX4 = 7'b0110000; //3
		7'b0011001: HEX4 = 7'b0011001; //4
		7'b0010010: HEX4 = 7'b0010010; //5
		7'b0000010: HEX4 = 7'b0000010; //6
		7'b1111000: HEX4 = 7'b1111000; //7
		7'b0000000: HEX4 = 7'b0000000; //8
		7'b0010000: HEX4 = 7'b0010000; //9
		default: HEX4 = 7'b0000000; //Default
	endcase
	case(seg2)
		7'b1000000: HEX7 = 7'b1000000; //0
		7'b1111001: HEX7 = 7'b1111001; //1
		7'b0100100: HEX7 = 7'b0100100; //2
		7'b0110000: HEX7 = 7'b0110000; //3
		7'b0011001: HEX7 = 7'b0011001; //4
		7'b0010010: HEX7 = 7'b0010010; //5
		7'b0000010: HEX7 = 7'b0000010; //6
		7'b1111000: HEX7 = 7'b1111000; //7
		7'b0000000: HEX7 = 7'b0000000; //8
		7'b0010000: HEX7 = 7'b0010000; //9
		default: HEX7 = 7'b0000000; //Default
	endcase
	case(seg3)
		7'b1000000: HEX6 = 7'b1000000; //0
		7'b1111001: HEX6 = 7'b1111001; //1
		7'b0100100: HEX6 = 7'b0100100; //2
		7'b0110000: HEX6 = 7'b0110000; //3
		7'b0011001: HEX6 = 7'b0011001; //4
		7'b0010010: HEX6 = 7'b0010010; //5
		7'b0000010: HEX6 = 7'b0000010; //6
		7'b1111000: HEX6 = 7'b1111000; //7
		7'b0000000: HEX6 = 7'b0000000; //8
		7'b0010000: HEX6 = 7'b0010000; //9
		default: HEX6 = 7'b0000000; //Default
	endcase
 
 
	
end

endmodule