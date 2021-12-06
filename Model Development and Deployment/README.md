# Model Development and Deployment

There are two folders in this module. One contains code and guide to train and deploy conventional ML activity classification models (Coarse Tree, Bagged Trees, AdaBoost, CSVM, and MLP). Other contains code and guide to train and deploy TinyML activity classification models (Bonsai, ProtoNN, FastRNN, FastGRNN, and TCN). The conventional model codebase is implemented in MATLAB, while the TinyML codebase in implemented in Python.

- In the folder ```Conventional Models```, there are two folders, namely ```Training``` and ```Deployment```. The training folder contains guide (and necessary code) on how to train conventional activity classification models in MATLAB. The ```Deployment``` folder contains guide (and necessary code) on how to convert these models to C++ code deployable on Cortex M4 class processors. We also provide the best-performing pre-trained conventional models in each folder within the ```Deployment``` folder to allow users run the deployment scripts.
- In the folder ```TinyML Models```, we provide each class of models in separate folders. Each Jupyter notebook for each model primarily imports the dataset, extracts features (optional), performs hyperparameter tuning or NAS via Bayesian optimization, trains the best model and provides deployable ```C++``` / ```.tflite``` files for model deployment. The notebooks have sufficient comments for the user to look into. ```TCN``` goes one step further, performing HIL NAS and providing the actual files used in running the models on specific hardware.
- Before running the code in ```TinyML Models```, please run ```data_prep.py``` to prepare the dataset ready for use by the dataset importer used in the TinyML model scripts.

Useful documentation:
- MATLAB Classification Learner: https://www.mathworks.com/help/stats/classification-learner-app.html 
- Hyperparameter Tuning in Classification Learner: https://www.mathworks.com/help/stats/hyperparameter-optimization-in-classification-learner-app.html
- MATLAB Neural Network Pattern Recognition: https://www.mathworks.com/help/deeplearning/ref/neuralnetpatternrecognition-app.html
- MATLAB Coder for transfering models to C++: https://www.mathworks.com/help/stats/code-generation-for-prediction-of-machine-learning-model-using-matlab-coder-app.html
- Bonsai, ProtoNN, FastRNN and FastGRNN (Microsoft EdgeML library): https://github.com/microsoft/EdgeML 
- Tensorflow Lite Micro: https://www.tensorflow.org/lite/microcontrollers 
