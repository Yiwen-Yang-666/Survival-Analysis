  This is a project related to survival analysis in high dimension feature space. In the literature, there are 3 types of methods (i.e. unsupervised, depending on the clinical data , and semi-supervised) to identify subtypes of survival data (the responses of data are not completed and the responses are multiple ). We investigated and evaluated some of the most important state-of-the-art approaches. In addition, we made improvements on the semi-supervised approaches and the methods based on clinical data. We also developed a model to test whether the methods based on clinical data were valid on our gene data.



Semi-supervised:

   ---Improved SPC (supervised principal components) and used the improved version to identify subtypes of the survival data.
 
   ---Applied supervised clustering and nearest shrunken centroids to identify subtypes of the survival data 



Methods Depending on the clinical data:
 
  ---Adopted median cut and train nearest shrunken Centroids to identify subtypes of the survival data..
 
  ---Utilized the Kaplan Meier to create class labels, then developed a model that apply MRMR (minimum-redundancy maximum – relevance) feature selection and Bayesian Classification to identify subtypes of the survival data.



Methods Depending on Unsupervised:

  ---Implemented unsupervised learning (e.g. hierarchical clustering) to create class labels and trained nearest shrunken Centroids to identify subtypes of the survival data.




Impact:

  ---The improved version of SPL obtained the best performance among all algorithms.

  ---The semi-supervised algorithms overpowered the other two types of approaches.

  ---Concluded strengths and weaknesses of each type of method.


