mutual_information <- function(data,res_cindex,nvar,nsample) {
  a=0
  b=0
  mean_a=0
  mean_b=0
  correlation=0
  correlation_nom=0
  correlation_den_a=0
  correlation_den_b=0
  rept=rep(0,nvar*nvar)
  #mim=vector("list",length(nvar*nvar))
  #mim[1]=0
  rept[1]=0
  library(doParallel)
  for(i in 1:nvar-1) {
    #mim[i*nvar+i+1]=0
    rept[i*nvar+i+1]=0
  }
  
  for(i in 1:nvar) {
    for(j in i+1:nvar) {
      #tmp=get_correlation(data,namat,(i-1)*nsample+1,(j-1)*nsample+1,nsample)
      a=(i-1)*nsample+1
      b=(j-1)*nsample+1
      for(k in 1:nsample) {
       # if(namat[a+(k-1)]==0 & namat[b+(k-1)]==0) {
          mean_a=mean_a+data[a+(k-1)]
          mean_b=mean_b+data[b+(k-1)]
          
       #  }
      }
      
      mean_a=mean_a/nsample
      mean_b=mean_b/nsample
      
      for(l in 1:nsample) {
        #if(namat[a+(l-1)]==0&namat[b+(l-1)]==0) {
          correlation_nom=correlation_nom+(data[a+(l-1)]-mean_a)*(data[b+(l-1)]-mean_b)
          correlation_den_a=correlation_den_a+(data[a+(l-1)]-mean_a)*(data[a+(l-1)]-mean_a)
          correlation_den_b=correlation_den_b+(data[b+(l-1)]-mean_b)*(data[b+(l-1)]-mean_b)
        #}
      }
      
      correlation=correlation_nom/(sqrt(correlation_den_a*correlation_den_b))
      rept[(j-1)*nvar+i]=correlation
      rept[(i-1)*nvar+j]=rept[(j-1)*nvar+i]
      #print(j)
    }
    print(i)
  }
  
  return(rept)
  
  
}