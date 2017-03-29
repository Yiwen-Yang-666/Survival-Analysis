library(pamr)
library(survival)
fit=survfit(Surv(y, icens) ~ 1)
plot(fit,conf.int="none")
title(main='KM-Curves for Gene Lung Cancer training Data')

cutoffs <- quantile(y[icens == 1], 0.5)
which.y <-((y>=cutoffs)&(y<=45))
cutoffs <- quantile(y[which.y])
best.chisq <- -Inf
#p.val=vector("list",1)
for (i in 1:length(cutoffs)) {
  aa= pamr.surv.to.class2(y,icens,cutoffs = cutoffs[i])
  cur.chisq <- survdiff(Surv(y, icens)~aa$class)$chisq
  if (cur.chisq > best.chisq) {
    best.i=i
    best.chisq=cur.chisq
   # sdf <- survdiff(Surv(y, icens)~aa$class)
    #p=1 - pchisq(sdf$chisq, length(sdf$n) - 1)
    #c(p.val,p)
  }
}

class= pamr.surv.to.class2(y,icens,cutoffs = cutoffs[best.i])$class
tab=table(class)
numbery1=tab[names(tab)==1]
numbery2=tab[names(tab)==2]
py1=numbery1/(numbery2+numbery1)
py2=numbery2/(numbery2+numbery1)
entropycl=-py1*log10(py1)-py2*log10(py2)

x=t(x)
data=cbind(x,as.matrix(class))
library(discretization)
dict=chiM(data)
aaaaaaaa=dict$Disc.data
p=length(dict$Disc.data[1,])-1
n=nrow(data)
p.y.g=vector("list",length(p))
p.g=vector("list",length(p))
entrolist=vector("list",length(p))
entropyy1=0
entropyy2=0
entropyy=0
igc=0
pgc=0

for (k in 1:p) {
  scal=length(dict$cutp[[k]])+1
  #sca=sort(unique(dict$Disc.data[,i]))
  #lengthcl=length(cl)
  mat=matrix(NA, nrow=scal,ncol = 2)
  matg=matrix(NA, nrow=scal,ncol = 1)
  for(l in 1:scal) {
    first <- apply(as.matrix(l), 1, function(e1,e2) (e1==e2), e2=dict$Disc.data[,k])
    index=which(first==TRUE)
    if(length(index)==0) {
      mat[l,1]=NA
      mat[l,2]=NA
      next
    }
    totalnum=length(index)
    matg[l,1]=totalnum/n
    cl2=dict$Disc.data[,4753][index]
    a=table(cl2)
    p1=a[names(a)==1]
    if(length(p1)==0) {
      p1=0
    }
    p1=p1/totalnum
    p2=a[names(a)==2]
    if(length(p2)==0) {
      p2=0
    }
    p2=p2/totalnum
    mat[l,1]=p1
    if( mat[l,1]!=0 & mat[l,1]!=1 ) {
    entropyy1=entropyy1-(log10(mat[l,1]))*(mat[l,1]*matg[l,1])
    }
    mat[l,2]=p2
    if( mat[l,2]!=0 & mat[l,2]!=1 ) {
    entropyy2=entropyy2-(log10(mat[l,2]))*(mat[l,2]*matg[l,1])
    }
  }
  
  entropyy=entropyy1+entropyy2
  entrolist[[k]]=entropycl-entropyy
  entropyy1=0
  entropyy2=0
  entropyy=0
  p.g[[k]]=matg
  p.y.g[[k]]=mat
  #igc=entropycl+entropyy
}




