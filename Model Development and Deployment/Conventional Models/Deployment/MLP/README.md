# Converting MLP to C for hardware implementation

- Launch MATLAB coder by typing ```coder``` in MATLAB command window.
- Type ```MLP_best``` in ```Generate code for function``` (this is the name of our MLP function. Yours may be different). Hit enter and click ```Next```.
- Type ```function_call_mlp``` in the dialogue box for ```Define Input Types```. Hit enter and click ```Next```
- Click ```Check for Issues```. If no errors persist, click ```Next```.
- Select the appropriate ```Hardware Board``` you want to compile the MLP to (e.g., ```None-Select device below, NXP, Cortex-M4```). For the ```Toolchain```, select ```Automatically locate an installed toolchain```. Click ```Generate```. If build is successful, MATLAB will show ```Source Code generation succeeded```. 
- Click ```Next``` and close the ```Finish Workflow``` dialogue box. You will find the C implementation of the MLP in ```codegen/lib/MLP_best```. The main function is in ```examples```. You can delete the unnecessary files (e.g., ```.mat```, ```.tmw```, ```.mk```, ```.rsp```, ```.dmr```, html folder and interface folder inside the ```codegen/lib/MLP_best``` folder) to further reduce code size.
