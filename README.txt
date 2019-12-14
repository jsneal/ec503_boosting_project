This repository's main focus is an implementation of AdaBoost on synthetic and non-synthetic datasets for a class project at Boston University (EC503 with Professor Ishwar).

Authors: Nadim El Helou, Karim Khalil, John Neal

GitHub Repository: https://github.com/jsneal/ec503_boosting_project

Functions:

	AdaBoost.m is our implementation of AdaBoost as a function. It calls update_weights and calculate_best_g.m which calls decision_stump.m.
	calculate_gs.m finds all possible classifiers and its output should be passed to AdaBoost. 
	test_our_boosted_classifier.m generates the CCR given the output of AdaBosot.m and the the test data as input. 
	create_confusion.m generates a confusion matrix.
	All our functions have intial comments indicating the inputs and outputs of each.

Scripts:

	Any *script* with "test" at the beginning was used to test a function.

	decision_boundary.m plotted the decision boundaries for the three original synthetic datasets (linear, tilted, circular).
	decision_stumps_ccr.m plots the CCR of the best decision stump on those three datsets (linear, tilted, circular).

	OurAdaBoost.m plots the CCR of the our implemenation of AdaBoost on (linear, tilted, circular).
	test_our_adaboost_against_matlab_adaboost.m plots the CCR of the our implemenation of AdaBoost and MATLAB's on (linear, tilted, circular).

	Sonar_AdaBoost.m plots the CCR of AdaBoost (our implementation) for the Sonar dataset.
	sonar_matlab_adaboost.m plots the CCR of AdaBoost (MATLAB's implementation) for the Sonar dataset.
	Sonar_Kernel_SVM.m plots the CCR of linear SVM and kernel SVM (with RBF kernel) using MATLAB's functions on Sonar dataset.

	additional_dimmensions_and_ccr_exploration.m plots the CCR of a "circular" dataset for k_dimensions for k = 2:10

Incomplete code:

	decision_boundary_unsigned.m, decision_unsigned.m, and plot_tilted_heatmap was an attempt to remove the sign from the output of
	the AdaBoost classifier to label each point strictly as the sum of the weights of the ensemble classifiers. This would generate a heatmap
	that would visualize how likely a given point is either in class 1 or class -1.

Special Instructions to Run:

	Please take note of any filepaths if you are using a UNIX system. Most of the work was done on Windows.

Dataset Sources:

	Synthetic: https://github.com/jsneal/ec503_boosting_project/tree/master/Datasets/synthetic

	Sonar: Dataset info found here: https://www.openml.org/d/40

Code to Process Datasets:

	Synthetic datasets were created by .m files in https://github.com/jsneal/ec503_boosting_project/tree/master/Datasets/synthetic,
	but there is no need to run them as they are the .mat files stored in that folder.

	The Sonar dataset already came preprocessed, except label "Rock" was changed to -1 and label "Mine" to 1.
