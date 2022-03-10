# Single-Cycle 32-bit MIPS Processor
## Introduction 
This Project is an implementation to 32-bit single cycle MIPS RISC based on Harvard architecture using Verilog HDL.
Tested on **Modelsim** tool and implemented on **Cyclone® IV FPGA** using **Intel® Quartus® Prime** software.
## Schematic of the MIPS 
![MIPS schematic](https://user-images.githubusercontent.com/41396171/157767458-7cf65ac4-520f-4c11-bb16-6efb069a9eb8.JPG)
> retrieved from the book "Digital Design and Computer Architecture" by David Harris and Sarah Harris.

## MIPS Blocks
The MIPS is consisted of 4 main blocks:
### Top Module 
![Top module](https://user-images.githubusercontent.com/41396171/157771974-4b50dd83-ce2c-420c-b193-c1fd8529fdf1.JPG)
![MIPS schematic top module](https://user-images.githubusercontent.com/41396171/157771983-0629146b-9998-4f49-9343-3832e593816a.JPG)
> The RTL view of the Verilog Code after compiled on Intel® Quartus® Prime

### 1. Instruction Memory
Where the instructions written in machine code following the ISA of the MIPS 

### 2. Data Memory
where the data of the program is stored in.

### 3. Datapath Unit
where the actual logic from ALU, Register file, Adderes, sign extenstions and muxes exist.
![Datapath](https://user-images.githubusercontent.com/41396171/157768901-14925363-4263-45dd-b38c-7e7c0e9dcdcf.JPG)

### 4. Control Unit 
the unit which responsible of controling the operations done by the datapath unit and the control enable signals of the memories.
![control unit](https://user-images.githubusercontent.com/41396171/157771564-80ea76f8-baf2-425a-aa2e-48df7b455f3e.JPG)

## Simulation Results
To validate the performace of the MIPS implementation, 4 programs were used for testing:

### Storing the value 7 in data memory of address 84
the program was retrieved from the reference mentioned above in section 7.6.3 "Testbench" 
![Code 0](https://user-images.githubusercontent.com/41396171/157773995-7966dc17-9848-4cfd-b202-f80cb0bf25ea.JPG)

### Calculating the greatest common factor of two numbers
Calculating the greatest common factor of two numbers (120, 180) and the result is 60 as can be shown in the results below.
![Code 1](https://user-images.githubusercontent.com/41396171/157774883-3fa31a15-2b94-4fff-b86f-ecfb1fe69115.JPG)

### Calculating the factorial of a given number
Calculating the factorial of 7! which results 5040.
![Code 2](https://user-images.githubusercontent.com/41396171/157774874-55c29438-77d5-4654-a51d-20d23eccd723.JPG)

### A program that outputs the Fibonacci series sequentially
![Code 3](https://user-images.githubusercontent.com/41396171/157775325-0515be88-7023-4e98-9ebd-32aaa8e0ebc0.JPG)

# References
1. IEEE CUSB digital electronics workshop sessions.
2. The textbook "Digital Design and Computer Architecture" by David Harris and Sarah Harris.
3. Hardware Modelling using Verilog Course by IIT KHARAGPUR NPTEL
