# testbench code is:->

//Running program 2 on RISC processor
module test_mips32;
 reg clk1, clk2;
 integer k;

// Instantiate the MIPS processor module
pipe_MIPS32 mips (clk1, clk2);

// Clock generation block: generate two-phase clock
initial 
begin
 clk1 = 0; 
 clk2 = 0;
 repeat(50)   // Generating two-phase clock for 50 cycles
 begin
   #5 clk1 = 1; 
   #5 clk1 = 0;
   #5 clk2 = 1; 
   #5 clk2 = 0;
 end
end

// Initialize memory and registers
initial 
begin
  // Initialize registers
  for (k = 0; k < 31; k = k + 1)
    mips.regbank[k] = k;

  // Initialize memory with instructions and data
  mips.mem[0]  = 32'h280a00c8;  // ADDI R10, R0, 200
  mips.mem[1]  = 32'h28020001;  // ADDI R2, R0, 1
  mips.mem[2]  = 32'h0e94a000;  // OR R20, R20, R20 -- dummy instruction
  mips.mem[3]  = 32'h21430000;  // LW R3, 0(R10)
  mips.mem[4]  = 32'h0e94a000;  // OR R20, R20, R20 -- dummy instruction
  mips.mem[5]  = 32'h14431000;  // Loop: MUL R2, R2, R3
  mips.mem[6]  = 32'h2c630001;  // SUBI R3, R3, 1
  mips.mem[7]  = 32'h0e94a000;  // OR R20, R20, R20 -- dummy instruction
  mips.mem[8]  = 32'h3460fffc;  // BNEQZ R3, Loop (i.e., -4 offset)
  mips.mem[9]  = 32'h2542fffe;  // SW R2, -2(R10)
  mips.mem[10] = 32'hfc000000;  // HLT

  // Set initial values for data memory
  mips.mem[200] = 7;  // Factorial of 7

  // Initialize control signals
  mips.PC = 0;
  mips.HALTED = 0;
  mips.TAKEN_BRANCH = 0;

  // Wait for the program to finish execution
  #2000;
  // Display the result after program completion
  $display ("Mem[200] = %2d, Mem[198] = %6d", mips.mem[200], mips.mem[198]);
end

// Setup waveform dumping for Vivado
initial 
begin
  $dumpfile("mips.vcd");        // VCD file to store waveform data
  $dumpvars(0, test_mips32);     // Dump all variables in test_mips32 module

  // Monitor the value of R2 during execution for debugging
  $monitor ("Time: %4t | R2: %4d", $time, mips.regbank[2]);

  // End the simulation after a reasonable time
  #3000 $finish;
end

endmodule
