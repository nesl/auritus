# Fall Detection

- Fall detection is just activity detection with two classes (Fall and no fall). Simply replace the ```data_utils.py``` found in the TinyML model training folders with the ```data_utils_fd.py``` found here. Then run those scripts in the same fashion. This ```data_utils_fd.py``` returns two classes (fall and no fall) instead of 9. 
- Note that you might want to alter the range of hyperparameters / network parameters to lower values to force the Bayesian Optimizer / Bayesian NAS give you ultra tiny models (~1 to 10 kB).
