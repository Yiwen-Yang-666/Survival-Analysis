library(doParallel)
nvar=4752
rept=rep(0,nvar*nvar)
  foreach(i=1:(nvar-1)) %dopar%  {
    
      rept[i*nvar+i+1]=5
    
   
  }
 





