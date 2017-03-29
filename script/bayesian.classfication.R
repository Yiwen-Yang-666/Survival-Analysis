fit=survfit(Surv(y, icens) ~ 1)
plot(fit)

cutoffs <- quantile(y[icens == 1], 0.5)
which.y <-((y>=cutoffs)&(y<=45))
cutoffs <- quantile(y[which.y])
best.chisq <- -Inf
p.val=vector("list",1)
for (i in 1:length(cutoffs)) {
 aa= pamr.surv.to.class2(y,icens,cutoffs = cutoffs[i])
 cur.chisq <- survdiff(Surv(y, icens)~aa$class)$chisq
 if (cur.chisq > best.chisq) {
   best.i=i
   best.chisq=cur.chisq
   sdf <- survdiff(Surv(y, icens)~aa$class)
   p=1 - pchisq(sdf$chisq, length(sdf$n) - 1)
   c(p.val,p)
 }
}

class= pamr.surv.to.class2(y,icens,cutoffs = cutoffs[best.i])$class
tab=table(class)
numbery1=tab[names(tab)==1]
numbery2=tab[names(tab)==2]
py1=numbery1/(numbery2+numbery1)
py2=numbery2/(numbery2+numbery1)


x=t(x)
score=mrmr.cindex(x,y,icens)
lower=quantile(abs(score),.99)
upper=quantile(abs(score),1)
th <- seq(from=lower, to=upper, length=100)
best.chisq <- -Inf
best.err <- Inf
for (i in 1:n.step) {
  cur.genes <- (abs(score)>th[i])
  cur.y <- kmeans2(x[,cur.genes], 2)$cluster
  cur.chisq <- survdiff(Surv(y, icens)~cur.y)$chisq
  if (cur.chisq > best.chisq) {
    x=x[,cur.genes]
    class=as.matrix(class)
    data=cbind(x,class)
    
    n=nrow(data)
    breaks <- round(seq(from=1,to=(n+1),length=(10+1)))
    cv.order <- sample(1:n)
    for (j in 1:10) {
      cur.lo <- cv.order[(breaks[j]):(breaks[j+1]-1)]
      data=data[-cur.lo,]
      dict=chiM(data)
      p=length(dict$Disc.data[1,])-1
      plist=vector("list",length(p))
      tail=length(dict$Disc.data[1,])
      for (k in 1:p) {
        scal=length(dict$cutp[[k]])+1
        #sca=sort(unique(dict$Disc.data[,i]))
        #lengthcl=length(cl)
        mat=matrix(NA, nrow=scal,ncol = 2)
        for(l in 1:scal) {
          first <- apply(as.matrix(l), 1, function(e1,e2) (e1==e2), e2=dict$Disc.data[,k])
          index=which(first==TRUE)
          if(length(index)==0) {
            mat[l,1]=NA
            mat[l,2]=NA
            next
          }
          totalnum=length(index)
          cl2=dict$Disc.data[,49][index]
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
          mat[l,2]=p2
        }
        plist[[k]]=mat
      }
      datatst=data[cur.lo,]
      ntst=nrow(datatst)
      for(m in 1:ntst) {
        
      }
      
    }
  }
}

