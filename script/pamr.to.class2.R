pamr.surv.to.class2<-function (y, icens, cutoffs = NULL, n.class = NULL, class.names = NULL, 
          newy = y, newic = icens) 
{
  if (is.null(cutoffs) & is.null(n.class)) {
    stop("Must specify either cutoffs or n.class")
  }
  if (!is.null(cutoffs) & !is.null(n.class)) {
    stop("Can't have both cutoffs and n.class specified")
  }
  data.sfit <- survfit(Surv(y, icens) ~ 1)
  if (!is.null(cutoffs)) {
    if (is.null(class.names)) {
      class.names <- 1:(length(cutoffs) + 1)
    }
    cur.mat <- gen.y.mat2(list(y = y, icens = icens), cutoffs, 
                          class.names, newdata = list(y = newy, icens = newic))
  }
  else {
    if (n.class == 1) {
      stop("Must have at least two classes")
    }
    if (is.null(class.names)) {
      class.names <- 1:n.class
    }
    cur.quantiles <- seq(from = 0, to = 1, length = n.class + 
                           1)
    cur.quantiles <- cur.quantiles[2:n.class]
    cutoffs <- quantile(y[icens == 1], cur.quantiles)
    cur.mat <- gen.y.mat2(list(y = y, icens = icens), cutoffs, 
                          class.names, newdata = list(y = newy, icens = newic))
  }
  mle.classes <- apply(cur.mat, 1, get.mle.class)
  return(list(class = as.numeric(mle.classes), prob = cur.mat, 
              cutoffs = cutoffs))
}