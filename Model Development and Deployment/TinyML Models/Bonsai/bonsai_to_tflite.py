import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'
import tensorflow as tf
from tensorflow import keras
import numpy as np
from edgeml_tf.tflite.bonsaiLayer import BonsaiLayer
import tensorflow.compat.v1.keras.backend as K
import glob
import argparse


parser = argparse.ArgumentParser(description='Converts to TFLite')
parser.add_argument("--model_dir", help="Model Directory", default="'trained_models/'")
args = parser.parse_args()
model_dir = args.model_dir
Z = np.load( glob.glob(model_dir + "/**/Z.npy", recursive = True)[0], allow_pickle=True )
W = np.load( glob.glob(model_dir + "/**/W.npy", recursive = True)[0], allow_pickle=True )
V = np.load( glob.glob(model_dir + "/**/V.npy", recursive = True)[0], allow_pickle=True )
T = np.load( glob.glob(model_dir + "/**/T.npy", recursive = True)[0], allow_pickle=True )
hyperparams = np.load(glob.glob(model_dir + "/**/hyperParam.npy", 
                            recursive = True)[0], allow_pickle=True ).item()

n_dim = hyperparams['dataDim']
projectionDimension = hyperparams['projDim']
numClasses = hyperparams['numClasses']
depth = hyperparams['depth']
sigma = hyperparams['sigma']

dense = BonsaiLayer( numClasses, n_dim, projectionDimension, depth, sigma )
model = keras.Sequential([
keras.layers.InputLayer(n_dim),
dense
])

dummy_tensor = tf.convert_to_tensor( np.zeros((1,n_dim), np.float32) )
out_tensor = model(dummy_tensor)
model.summary()
dense.set_weights( [Z, W, V, T] )
model.compile()

converter = tf.lite.TFLiteConverter.from_keras_model(model)
#converter.optimizations = [tf.lite.Optimize.DEFAULT]
tflite_model = converter.convert()

# Save the TF Lite model as file
out_tflite_model_file = 'bonsai_model.tflite'
f = open(out_tflite_model_file, "wb")
f.write(tflite_model)
f.close()
