function label = svm_predict(X)
	SVM = loadLearnerForCoder('ClassificationLearnerModel');
	label = predict(SVM,X);
end
