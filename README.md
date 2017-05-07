An important goal of DNA microarray research is to develop tools to diagnose cancer more
accurately based on the genetic profile of a tumor. There are several existing techniques in the
literature for performing this type of diagnosis. Most of these techniques assume that
different subtypes of cancer are already known to exist. Their utility is limited when such
subtypes have not been previously identified. Although methods for identifying such subtypes
without a priori knowledge of their existence exist, they do not work well in high dimensional
feature spaces. Recently, several approaches were proposed for survival analysis in high
dimensional feature space, where the feature space consists of the expression profiles from thousands
or even tens of thousands of genes. These approaches can be generally categorized into three
types: unsupervised, supervised and semi-supervised. Their performances have been
evaluated on several data sets. In most of the cases, semi-supervised approaches seem to have
superior performances than the other two.In this study, We investigated and made some improvements on all of the semi-supervised algorithms. Besides, we investigated and modified some of the most important state-of-art unsupervised and supervised algorithms. We also developed a model to compare with those investigated methods. 



Semi-supervised:

-Improved SPC( supervised principal components) and used the improved version to solve classification of the survival data.(i.e no-class label gene data with survival time and censoring status).

-Developed MRMR (minimum-redundancy maximum-relevancy) feature selection and Bayesian classifier to solve classification of the survival data.

-Applied supervised clustering and nearest shrunken centroids to solve classification of survival data 




Unsupervised and supervised

-Implemented unsupervised clustering(e.g. hierarchical clustering)and nearest shrunken centroids to solve classification of the survival data. 

-Adopted KM (Kaplan Meier) graph or median cut to create class labels and then adopted nearest shrunken centroids classifier.

-Planed to adopt GENN(Genetic Evolution Neural Network) to find gene-gene interaction.



Impact

-The improved version of SPC got pretty good performance.

-Explored which combination of feature selection(i.e .cox score and MRMR) with classifier (i.e. nearest shrunken centroids, supervised principal components, and Bayesian classifier) was best for our survival data.

-Concluded strengths and weaknesses of every method when applying different datasets.
