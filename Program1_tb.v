# Running testbench of program1

// Program 1 on Processor RISC


module test_mips32;
    reg clk1, clk2;
    integer k;
    
    // Instantiate the MIPS32 processor module
    pipe_MIPS32 mips (clk1, clk2);
    
    initial begin
        clk1 = 0; 
        clk2 = 0;
        
        // Generating two-phase clock
        repeat (20) begin
            #5 clk1 = 1; 
            #5 clk1 = 0;
            #5 clk2 = 1; 
            #5 clk2 = 0;
        end
    end

    initial begin
        // Initialize register values
        for (k = 0; k < 32; k = k + 1) 
            mips.regbank[k] = k;  // Corrected from "mips.Reg" to "mips.regbank"
        
        // Initialize memory with instructions
        mips.mem[0] = 32'h2801000a;  // ADDI   R1, R0, 10
        mips.mem[1] = 32'h28020014;  // ADDI   R2, R0, 20
        mips.mem[2] = 32'h28030019;  // ADDI   R3, R0, 25
        mips.mem[3] = 32'h0ce77800;  // OR     R7, R7, R7   (Dummy instruction)
        mips.mem[4] = 32'h0ce77800;  // OR     R7, R7, R7   (Dummy instruction)
        mips.mem[5] = 32'h00222000;  // ADD    R4, R1, R2
        mips.mem[6] = 32'h0ce77800;  // OR     R7, R7, R7   (Dummy instruction)
        mips.mem[7] = 32'h00832800;  // ADD    R5, R4, R3
        mips.mem[8] = 32'hfc000000;  // HLT    (Halt the program)
        
        // Initialize control flags
        mips.HALTED = 0;
        mips.PC = 0;
        mips.TAKEN_BRANCH = 0;
        
        // Run the simulation for a specified duration
        #280;
        
        // Display register values after execution
        for (k = 0; k < 6; k = k + 1)
            $display("R%1d = %2d", k, mips.regbank[k]);  // Corrected from "mips.Reg" to "mips.regbank"
    end

    initial begin
        // Dump waveforms for analysis
        $dumpfile("mips.vcd");
        $dumpvars(0, test_mips32);
        
        // Additional signals for waveform dumping
        $dumpvars(1, clk1);
        $dumpvars(1, clk2);
        $dumpvars(1, mips.PC);
        $dumpvars(1, mips.IF_ID_IR);
        $dumpvars(1, mips.IF_ID_NPC);
        $dumpvars(1, mips.ID_EX_A);
        $dumpvars(1, mips.ID_EX_B);
        $dumpvars(1, mips.ID_EX_IR);
        $dumpvars(1, mips.ID_EX_Imm);
        $dumpvars(1, mips.ID_EX_type);
        $dumpvars(1, mips.EX_MEM_ALUOut);
        $dumpvars(1, mips.EX_MEM_IR);
        $dumpvars(1, mips.EX_MEM_type);
        $dumpvars(1, mips.MEM_WB_ALUOut);
        $dumpvars(1, mips.MEM_WB_IR);
        $dumpvars(1, mips.MEM_WB_type);
    end
endmodule
