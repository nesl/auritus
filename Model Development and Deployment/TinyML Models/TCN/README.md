# TCN with HIL NAS

- ```auritus_tcn``` has actual Tensorflow Lite Micro style C++ code that can be run on Mbed-enabled boards. Please place it in your home directory in the Mbed programs folder (e.g., ```home/nesl/Mbed Programs/auritus_tcn```). Refer to the TFLM guide to understand how ```main.cpp``` works: https://www.tensorflow.org/lite/microcontrollers
- You can add your own Mbed-enabled target hardware in ```hardware_utls.py```. You need to know the maximum amount of RAM, maximum amount of Flash and a list of arena sizes you want to optimize for for the hardware.
- The Jupyter notebook is well-commented to guide you through the NAS process. One particular thing to note is how the score weighs each optimization variable (accuracy, RAM, flash, latency). You can play around with the weights.

