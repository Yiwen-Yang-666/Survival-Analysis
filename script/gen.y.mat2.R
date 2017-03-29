gen.y.mat2 <- function(surv.data, cutoffs, class.names=NULL, newdata=surv.data)
  # Calculates the probability that a given patient belongs to a given
  # class.  Returns a matrix where entry (i,j) is the probability that
  # patient i belongs to class j.  The function calculates the
  # probability that a given patient dies between two given cutoffs,
  # and uses this information to calculate the probability that
  # a patient with a censored survival time died in a given interval.
{
  data.sfit <- survfit(Surv(surv.data$y,surv.data$icens)~1)
  surv.ndx <- find.surv.ndx(cutoffs, data.sfit$time)
  surv.probs <- c(0, 1-data.sfit$surv[surv.ndx],1)
  surv.probs <- c(rep(0, sum((surv.ndx==0))), surv.probs)
  cutoffs <- c((min(surv.data$y)-1), cutoffs, (max(surv.data$y)+1))
  y.size <- length(cutoffs)
  y.mat <- matrix(0,nrow=length(newdata$y), ncol=(y.size-1))
  for (i in 2:y.size) {
    cur.int.prob <- surv.probs[i] - surv.probs[i-1]
    y.mat[((newdata$y<=cutoffs[i])&(newdata$y>cutoffs[i-1])&
             (newdata$icens==1)),i-1] <- 1
    which.x <- ((newdata$icens==0)&(newdata$y<=cutoffs[i-1]))
    if (sum(which.x)>0) {
      which.x.vals <- newdata$y[which.x]
      surv.ndx <- find.surv.ndx(which.x.vals,
                                data.sfit$time)
      y.mat[which.x,i-1][surv.ndx==0] <- cur.int.prob
      y.mat[which.x,i-1][surv.ndx!=0] <- cur.int.prob /
        data.sfit$surv[surv.ndx]
    }
    which.x <- ((whinewdata$icens==0)&(newdata$y>cutoffs[i-1])&
                  (newdata$y<=cutoffs[i]))
    if (sum(which.x>0)) {
      which.x.vals <- newdata$y[which.x]
      surv.ndx <- find.surv.ndx(which.x.vals,
                                data.sfit$time)
      y.mat[which.x,i-1][surv.ndx==0] <- surv.probs[i]
      y.mat[which.x,i-1][surv.ndx!=0] <- 1 -
        (1 - surv.probs[i]) / data.sfit$surv[surv.ndx]
    }
  }
  if (!is.null(class.names)) {
    y.mat <- as.data.frame(y.mat)
    names(y.mat) <- class.names
    y.mat <- as.matrix(y.mat)
  }
  y.mat
}