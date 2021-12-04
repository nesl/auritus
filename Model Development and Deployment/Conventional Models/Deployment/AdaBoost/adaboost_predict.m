function label = adaboost_predict(X)
	adaboost = loadLearnerForCoder('ClassificationLearnerModel');
	label = predict(adaboost,X);
end
