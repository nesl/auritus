# Converting SVM to C for hardware implementation

- First, run ```Script_1.m``` in MATLAB. It makes the SVM ready to be converted to C using MATLAB coder.
- Launch MATLAB coder by typing ```coder``` in MATLAB command window.
- Type ```svm_predict``` in ```Generate code for function```.
- Type ```function_call_svm``` in the dialogue box for ```Define Input Types```. Hit enter and click ```Next```.
- Click ```Check for Issues```. If no errors persist, click ```Next```.
- Select the appropriate ```Hardware Board``` you want to compile the SVM to (e.g., ```None-Select device below, NXP, Cortex-M4```). For the ```Toolchain```, select ```Automatically locate an installed toolchain```. Click ```Generate```. If build is successful, MATLAB will show ```Source Code generation succeeded```. 
- Click ```Next``` and close the ```Finish Workflow``` dialogue box. You will find the C implementation of the SVM in ```codegen/lib/svm_predict```. The main function is in ```examples```. You can delete the unnecessary files (e.g., ```.mat```, ```.tmw```, ```.mk```, ```.rsp```, ```.dmr```, html folder and interface folder inside the ```codegen/lib/svm_predict``` folder) to further reduce code size.
