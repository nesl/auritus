# Converting Bagged Trees to C for hardware implementation

- First, run ```Script_1.m``` in MATLAB. It makes the bagged trees ready to be converted to C using MATLAB coder.
- Launch MATLAB coder by typing ```coder``` in MATLAB command window.
- Type ```bag_predict``` in ```Generate code for function```.
- Type ```function_call_bag``` in the dialogue box for ```Define Input Types```. Hit enter and click ```Next```.
- Click ```Check for Issues```. If no errors persist, click ```Next```.
- Select the appropriate ```Hardware Board``` you want to compile the bagged trees to (e.g., ```None-Select device below, NXP, Cortex-M4```). For the ```Toolchain```, select ```Automatically locate an installed toolchain```. Click ```Generate```. If build is successful, MATLAB will show ```Source Code generation succeeded```. 
- Click ```Next``` and close the ```Finish Workflow``` dialogue box. You will find the C implementation of the bagged trees in ```codegen/lib/bag_predict```. The main function is in ```examples```. You can delete the unnecessary files (e.g., ```.mat```, ```.tmw```, ```.mk```, ```.rsp```, ```.dmr```, html folder and interface folder inside the ```codegen/lib/bag_predict``` folder) to further reduce code size.
