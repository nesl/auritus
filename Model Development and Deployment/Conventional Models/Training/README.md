# Conventional Model Training Guide

We used MATLAB's ```Classification Learner``` and ```Neural Network Pattern Recognition``` toolboxes to train conventional activity detection models (CSVM, Coarse Tree, AdaBoost, Bagged Trees, and MLP). There are three scripts that are important:
- ```Script_FE.m``` (most important) extracts features from the activity detection dataset and saves the features and labels in two ```.csv``` files (```Featmat.csv``` and ```Labelmat.csv```). You can choose the participants for which you want to import the data in the script. The script calls several feature extraction functions. You can add your own features or omit some of the features. In addition, you can specify the window size and stride to use during feature extraction.
- ```Script_FI.m``` imports the two said ```.csv``` files in the MATLAB workspace. You can choose whether the labels should be ordinal (e.g., 1,2,...,9) or one-hot encoded in the script. The features and labels can then be used with the ```Classification Learner``` and ```Neural Network Pattern Recognition``` toolboxes for model training and hyperparameter tuning.
- ```Script_Separator.m``` separates the extracted features into separate ```.csv``` files based on the labels.
- After training the MLP model, you should export the trained model by selecting Export Model > Export Network Function for MATLAB Coder. This will allow you to convert the MLP model for C implementation later.
- After training the other four types of models, export the trained model to workspace and save the variable ```trainedModel``` as a .mat file. This will allow you to convert these models for C implementation later.

Useful documentation:
- MATLAB Classification Learner: https://www.mathworks.com/help/stats/classification-learner-app.html 
- Hyperparameter Tuning in Classification Learner: https://www.mathworks.com/help/stats/hyperparameter-optimization-in-classification-learner-app.html
- MATLAB Neural Network Pattern Recognition: https://www.mathworks.com/help/deeplearning/ref/neuralnetpatternrecognition-app.html

