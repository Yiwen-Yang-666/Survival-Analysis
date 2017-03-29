pamr.cv.cox <- function(data, cur.tt, n.step=100, lower=quantile(cur.tt,.98),
                        upper=quantile(cur.tt,1-(2/nrow(data$x)))) 
{
  require(survival)
  require(pamr)
  th <- seq(from=lower, to=upper, length=n.step)
  best.chisq <- -Inf
  best.err <- Inf
  for (i in 1:n.step) {
    data1=data
    print(i)
    pp=i
    
    cur.genes <- (cur.tt>th[i])
    cur.y <- kmeans2(t(data$x[cur.genes,]), 2)$cluster
    cur.chisq <- survdiff(Surv(data$y, data$icens)~cur.y)$chisq
    #if (cur.chisq > best.chisq) {
      a=table(cur.y)
      if(a[names(a)==1]==length(cur.y)-1) {
        print(101)
        b=which(cur.y==2)
        cur.y=cur.y[-b]
       # names(cur.y)[56]="V56"
        data1$x=data1$x[,-b]
        cur.y <- kmeans2(t(data1$x[cur.genes,]), 2)$cluster
      }
      if(a[names(a)==2]==length(cur.y)-1) {
        print(101)
        b=which(cur.y==1)
        cur.y=cur.y[-b]
        #names(cur.y)[56]="V56"
        data1$x=data1$x[,-b]
        cur.y <- kmeans2(t(data1$x[cur.genes,]), 2)$cluster
      }
      cur.trn <- pamr.train(list(x=data1$x, y=cur.y))
      cur.cv <- pamr.cv(cur.trn, list(x=data1$x, y=cur.y))
      cur.best.err <- min(cur.cv$error)
      best.i <- max((1:30)[cur.cv$error==cur.best.err])
      
      if (cur.best.err < best.err) {
        best.th <- th[i]
        best.trn <- cur.trn
        best.cv <- cur.cv
        best.chisq <- cur.chisq
        best.err <- cur.best.err
      }
     
    #}
  }
  cur.genes <- (cur.tt>best.th)
  b=table(cur.genes)
  print(b[names(b)==TRUE])
  junk <- list(th=best.th, model.trn=best.trn, model.cv=best.cv)
  return(junk)
}