Abstract

An important goal of DNA microarray research is to develop tools to diagnose cancer
more accurately based on the genetic profile of a tumor. There are several existing
techniques in the literature for performing this type of diagnosis. Unfortunately, most
of these techniques assume that different subtypes of cancer are already known to
exist. Their utility is limited when such subtypes have not been previously identified.
Although methods for identifying such subtypes exist, these methods do not work
well for all datasets. There are three main approaches (unsupervised; supervised;
semi-supervised) in the literature to identify such subtypes. The purely unsupervised
and supervised methods have their own limitations and they have not successfully
identified such subtypes in different studies. By contrast, the semi-supervised
approach performs very well when applying different datasets. In this study, we
investigate power of semi-supervised approach on our dataset by comparing two
novel semi-supervised procedures with the unsupervised and supervised algorithms.
In addition, we develop a supervised model that uses MRMR feature selection and
Bayesian classification to compare with those novel semi-supervised procedures. A
semi-supervised model that uses MRMR feature selection and Bayesian classification
will be developed in the future work. However, all methods ignore gene-gene
interactions which is particular problematic for traditional statistical techniques. Some
powerful methods for gene-gene interaction, such as GENN (Grammatical Evolution
Neural Networks) will be tested in the future work.




Semi-supervised:

-Applied supervised clustering and nearest shrunken centroids to solve classification of survival data (i.e no-class label gene data with only survival time and censoring status ).

-Modified the SPC( supervised principal components) and used the modified version to solve classification of the survival data.

-Developed a model that use MRMR (minimum-redundancy maximum-relevancy) feature selection and Bayesian classification to solve classification of the survival data 


Unsupervised and supervised

-Implemented unsupervised clustering(e.g. hierarchical clustering) to solve classification of the survival data. 

-Applied KM (Kaplan Meier) graph or median cut to create class label and then adopted nearest shrunken centroids classifier.

-Planed to adopt GENN(Genetic Evolution Neural Network) to find gene-gene interaction.

Impact
-Explored which combination of feature selection(i.e .cox score for supervised clustering and SPL; MRMR) with classifier (i.e. nearest shrunken centroids; principal component; Bayesian classifier) is best for our survival data.

-Concluded strength and weakness of every method through comparison when applying different datasets