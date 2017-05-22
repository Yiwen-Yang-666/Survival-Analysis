  This is a project related to survival analysis in high dimension feature space. In the literature, there are 3 types of methods (i.e. unsupervised, depending on the clinical data , and semi-supervised) to identify subtypes of survival data (the responses of data are not completed and the responses are multiple ). We investigated and evaluated some of the most important state-of-the-art approaches. In addition, we made improvements on the semi-supervised approaches and the methods based on clinical data. We also developed a model to test whether the methods based on clinical data were valid on our gene data.



Semi-supervised:

   ---Improved SPC (supervised principal components) and used the improved version to solve classification of the survival data.
 
   ---Applied supervised clustering and nearest shrunken centroids to solve classification of the survival data 



Depending on the clinical data:
 
  ---Adopted median cut to create class labels and then trained the nearest shrunken centroids classifier to solve classification     of the survival data.
 
  ---Developed a model that applied MRMR (minimum-redundancy maximum-relevancy) feature selection and Naïve Bayesian classifier to solve classification of the survival data.



Unsupervised:

  ---Implemented unsupervised techniques (e.g. hierarchical clustering) and then trained the nearest shrunken centroids        classifier to solve classification of the survival data.



Future Work:
 
  ---Planned to develop a semi-supervised model that applied the MRMR and Naïve Bayesian classifier.

  ---Planned to adopt GENN (Genetic Evolution Neural Network) to find gene-gene interaction.



Impact

  ---The improved version of SPC got pretty good performance.

  ---The semi-supervised model overpowered the other two types of approaches.

  ---The methods based on clinical data were valid on our gene data.


