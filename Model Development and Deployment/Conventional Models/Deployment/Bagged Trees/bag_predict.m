function label = bag_predict(X)
	bag = loadLearnerForCoder('ClassificationLearnerModel');
	label = predict(bag,X);
end
