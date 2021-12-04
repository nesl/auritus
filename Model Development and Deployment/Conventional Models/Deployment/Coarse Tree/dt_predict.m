function label = dt_predict(X)
	dt = loadLearnerForCoder('ClassificationLearnerModel');
	label = predict(dt,X);
end
