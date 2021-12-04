# Auritus - An Open Source Optimization Toolkit for Training and Deployment of Human Movement Models and Filters Using Earables

![overview](earable_framework_final.png)


### Required items if you want to collect your own dataset:
- An Android Smartphone (check Data Collection Module)
- eSense earables from Nokia Bell Labs (check Data Collection Module)
- Optitrack MoCap Setup (check Data Collection Module)
- Laser RangeFinder (check Data Collection Module)
- Digital Compass (check Data Collection Module)

### Required items for all modules:
- A computer running MacOS (if you want to collect your own data, perform labeling and use MATLAB coder).
- A GPU Workstation running Ubuntu 20.04 (to train TinyML models and perform NAS).
- MATLAB R2021b (with Classification Learner, MATLAB Coder, and Neural Network Pattern Recognition apps) must be installed on both machines. The three apps are available via the Statistics and Machine Learning Toolbox and MATLAB coder. https://www.mathworks.com/products/matlab.html, https://www.mathworks.com/products.html
- Python 3.8+ must be installed on both machines, preferably through Anaconda or Virtualenv, https://docs.conda.io/en/latest/, https://virtualenv.pypa.io/en/latest/
- Python package requirements are listed in the folders for each modules.
- Couple of STM32 Nucleo Boards (must be Mbed enabled) for hardware-in-the-loop NAS, https://www.st.com/en/evaluation-tools/stm32-nucleo-boards.html
- Arduino IDE, https://www.arduino.cc/en/software/


