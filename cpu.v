//this implementation consists only R-type single cycle MIPS instruction.
module mips_cpu(
    input [31:0] head_address,
    input clk
    );
    
    wire [31:0] instruction;
    reg  [31:0] register      [31:0];
    reg [31:0] float_register [31:0];
    reg  [31:0] PC;

    wire [5:0] op, funct; //to define some common fields of instruction
    wire [4:0] rs, rt,rd;


    assign op    = instruction [31:26];
    assign rs    = instruction [25:22];
    assign rt    = instruction [21:18];
    assign rd    = instruction [17:14];
    assign funct = instruction [5:0];

    initial PC = head_address;

    pc_decoder ins_decoder(instruction, PC);

    always @(*)
    begin
        register[0] = 0; //the unique way to define a constant 0.
    end


    always @(posedge clk)
    begin 
        PC <= PC + 4; //next instruction to be executed

        case (op)
            6'b0:  case (funct)
                    6'b100_000: register[rd] <= register[rs] + register[rt];
                endcase
        endcase
    end
endmodule

module pc_decoder(
    output [31:0] instruction, //the instruction is contained in the primary memory, identical with the data
    input [31:0]  PC //is holding the address contained instruction
    );
    pri_memory ram(
        .out(instruction),
        .address(PC),
        .in(x), //dont care
        .enable(1'b1), .rw(1'b0)
        );
endmodule

module pri_memory( //this memory model is facilitated and we do not consider the cache hierarchy here
    output reg [31:0] out,
    input [31:0] in, //written value
    input enable, rw,
    input [31:0]  address
    );
    reg [31:0] memword [0:1000]; //because of 2^31.
    
    always @(enable, rw)
    begin
        if (enable)
        begin
            if (rw == 1)
                memword[address] = in;
            else
                out = memword[address];
        end
        else
            out = 4'bz;
    end
endmodule


/*
module shift_register(
    output reg [3 : 0] out,
    input [3:0] in,
    input [1:0] control,
    input clk, msb_in, lsb_in, clear
    );

    
    always @(posedge clear, negedge clk)
        if (clear) out = 4'b0;
        else case (control)
                2'b11: begin out = in; end
                2'b10: out = {in[2:0], lsb_in};
                2'b01: out <= {msb_in, in[3:1]};
                2'b11: out = out;
            endcase
endmodule
*/