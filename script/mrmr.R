mrmr<-function (mim,igc,data,namat,nsample,nvar) {
  red=vector("list",length(nvar))
  rel=vector("list",length(nvar))
  res=vector("list",length(nvar))
  jmax=1
  score=0
  for(j in 1:nvar) {
    rel[j]=igc[j]
    if(rel[j]>rel[jmax]) {
      jmax=j
    }
  }
  
  score=rel[jmax]
  res[jmax]=score
  rel[jmax]=-1000
  for(l in 1: nvar ) {
    red[l] = red[l]+mim[(l-1)*nvar+jmax]
  }  
  
  
  #select others
  for(k in 1:nvar-1) {
    jmax=1
    if(rel[jmax]=-1000) {
      jmax=jmax+1
    }
    for(m in 2:nvar) {
      if(rel[m]=-1000) {
        next
      }
      if((rel[m]/(red[m]/k)) > (rel[jmax]/(red[jmax]/k))) {
        jmax=m
      }
    }
    print(jmax)
    score=rel[jmax]/(red[jmax]/k)
    res[jmax]=score
    
    rel[jmax]=-1000
    for(n in 1:nvar) {
      red[n] = red[n]+mim[(n-1)*nvar+jmax]
    }
    
    #stop condition
    if(score<-100) {
      break
    }
    
  }
   
  return(res)
  
}