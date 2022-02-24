\m4_TLV_version 1d: tl-x.org
\SV
   // <Your permissive open-source license here>

   // A starting template/example for developing a Verilog/SystemVerilog/TL-Verilog module within Makerchip, using a
   // Verilog testbench.
   //
   // The testbench is defined within a Verilog module that uses Makerchip's required standard interfaces to control simulation.
   // It instantiates the design under test (DUT) module.
   //
   // Note:
   //   Currently, TL-Verilog can be used to define the logic within a single module in each file, and Makerchip is limited
   //   to a single source file. So it is not possible to use TL-Verilog for both testbench and design under test (DUT).
   //   Here, we use TL-Verilog for the DUT. To use TL-Verilog for both testbench and DUT, consider developing a TL-Verilog
   //   library file (or check with Redwood EDA, LLC regarding recent developments).
   //
   // This file contains:
   //   o A dirt-simple example Verilog testbench.
   //   o fib(): A tiny example DUT module definition containing TL-Verilog logic.
   //
   // This file can be used in a Verilog project by preprocessing it with SandPiper(TM). See http://redwoodeda.com/products
   //   for free options.



   //------------------------------------------
   // A simple example SV testbench.
   // Note that Verilator (compiler/simulator) only supports synthesizable SystemVerilog.

   // Testbench.
   m4_makerchip_module   // Compile within Makerchip to see expanded module definition.
      logic run;          // Assert to start the series.
      logic [31:0] val;   // The value from the Fibonacci Series.

      assign run = cyc_cnt >= 5;
      fib fib(clk, reset, run, val);

      // Pass if Fibinocci value is correct after hardcoded # cycles; fail o/w.
      assign passed = cyc_cnt == 32'h10 && val == 32'h179;
      assign failed = cyc_cnt >  32'h10;
   endmodule


   //------------------------------------------
   // The DUT Fibonacci series generator module definition, using TL-Verilog logic.
   module fib(input logic clk, input logic reset, input logic run, output logic [31:0] val);

   // Fibonacci logic, using TL-Verilog. Verilog/SystemVerilog could also be used here.
\TLV
   // Tie Verilog inputs to TL-Verilog pipesignals.
   $reset = *reset;
   $run = *run;

   // Fibonacci.
   $val[31:0] = ($reset || ! $run) ? 1 : >>1$val + >>2$val;

   // Tie TL-Verilog pipesignals to Verilog outputs.
   *val = $val;
\SV

   endmodule