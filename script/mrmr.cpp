#include <Rcpp.h>
using namespace Rcpp;

// This is a simple example of exporting a C++ function to R. You can
// source this function into an R session using the Rcpp::sourceCpp 
// function (or via the Source button on the editor toolbar). Learn
// more about Rcpp at:
//
//   http://www.rcpp.org/
//   http://adv-r.had.co.nz/Rcpp.html
//   http://gallery.rcpp.org/
//

double get_correlation(double data [],double namat[], int ind_x, int ind_y, int size){
  //compute correlation of two variables;
  //data: contains all data in a vector; variable-wise appended
  //ind_x: starting index of first variable in data
  //ind_y: starting index of second variable in data
  //size: number of samples for both variables
  double mean_data_x=0.0,mean_data_y=0.0;
  double correlation_nom=0.0,correlation_den_x=0.0,correlation_den_y=0.0;
  
  for(  int i=0; i< size; ++i ) {
    if (namat[ind_x+i]==0 && namat[ind_y+i]==0 ) {
      mean_data_x+=data[ind_x+i];
      mean_data_y+=data[ind_y+i];
    }
  }
  
  mean_data_x=mean_data_x/size;
  mean_data_y=mean_data_y/size;
  
  for(  int i=0; i< size; ++i ) {		
    if(namat[ind_x+i]==0 && namat[ind_y+i]==0){
      correlation_nom+=(data[ind_x+i]-mean_data_x)*(data[ind_y+i]-mean_data_y);
      correlation_den_x+=(data[ind_x+i]-mean_data_x)*(data[ind_x+i]-mean_data_x);
      correlation_den_y+=(data[ind_y+i]-mean_data_y)*(data[ind_y+i]-mean_data_y);
    }
  }
  return correlation_nom/(sqrt(correlation_den_x*correlation_den_y));
}


void build_mim_subset(double mim[],double data[], double namat [],int nvar,int nsample, int subset [],int size_subset){
  //compute mutual information matrix
  //mim:			matrix (stored as vector) in which the mi values will be stored
  //data:			contains all data in a vector; variable-wise appended
  //nvar:			number of variables
  //nsample:		number of samples in dataset
  //subset:		indices of samples to be included in the bootstrapping data
  //size_subset:	number of variables in the bootstrapped dataset
  
  double tmp;
  //double *data_x;
  //int *namat_x;
  double data_x[nvar*size_subset];
  double namat_x[nvar*size_subset];
  
  //namat_x = (int*) (nvar*size_subset, sizeof(int));
  //data_x = (double *) (nvar*size_subset, sizeof(double));
  
  for(int i=0; i< size_subset; ++i){
    for( int j=0; j< nvar; ++j){
      data_x[size_subset*j+i]=data[(subset[i])+nsample*j];
      namat_x[size_subset*j+i]=namat[(subset[i])+nsample*j];
    }
  }
  
  for( int i=0; i< nvar; ++i){
    mim[i*nvar+i]=0;
    for( int j=i+1; j< nvar; ++j){
      tmp=get_correlation(data_x,namat_x,i*size_subset,j*size_subset,size_subset);
      
      
      mim[j*nvar+i]= tmp;
      mim[i*nvar+j]=mim[j*nvar+i];
    }
  }
}
// [[Rcpp::export]]
  RcppExport SEXP mrmr_cIndex1(SEXP Rdata, SEXP Rnamat, SEXP RcIndex, SEXP Rnvar, SEXP Rnsample, SEXP Rthreshold){     
   // double *data, *cIndex; 
   double score=1;
   // double *rel, *red, *res, *mim, score=1,*threshold, *res_final;
   Rcpp::NumericMatrix data(Rdata);
   Rcpp::NumericVector namat(Rnamat);
   Rcpp::NumericVector cIndex(RcIndex);
   double nvar=as<double>(Rnvar);
   int nsample=as<int>(Rnsample);
   int threshold=as<int>(Rthreshold);
    
   // const int *nvar, *nsample;
   // int *ind, *namat;
    
     int n, jmax=0;
    //PROTECT(Rdata = AS_NUMERIC(Rdata));
   // PROTECT(Rnamat = AS_INTEGER(Rnamat));
    //PROTECT(RcIndex = AS_NUMERIC(RcIndex));
    //PROTECT(Rnvar= AS_INTEGER(Rnvar));
    //PROTECT(Rnsample= AS_INTEGER(Rnsample));
    //PROTECT(Rthreshold= AS_NUMERIC(Rthreshold));
    
    
    //data = NUMERIC_POINTER(Rdata);
    //namat=INTEGER_POINTER(Rnamat);
    //cIndex= NUMERIC_POINTER(RcIndex);
   // nvar = INTEGER_POINTER(Rnvar);
   // nsample = INTEGER_POINTER(Rnsample);
   // threshold = NUMERIC_POINTER(Rthreshold);
    
    n = nvar;
    
    //new variables
    //SEXP Rmim, Rres,Rred,Rrel,Rind,Rres_final;
    double mim[n*n];
    double res[n];
    double red[n];
    double rel[n];
    int ind[nsample];
    Rcpp::NumericVector res_final(n);
    
   // PROTECT(Rmim = NEW_NUMERIC(n*n));
    //PROTECT(Rres = NEW_NUMERIC(n));
    //PROTECT(Rres_final = NEW_NUMERIC(n));
    //PROTECT(Rrel = NEW_NUMERIC(n));
    //PROTECT(Rred = NEW_NUMERIC(n)); 
   // PROTECT(Rind = NEW_INTEGER(*nsample));
    
    //ind = INTEGER_POINTER(Rind);	
   // mim = NUMERIC_POINTER(Rmim);
   // res = NUMERIC_POINTER(Rres);
    //rel = NUMERIC_POINTER(Rrel);
   // red = NUMERIC_POINTER(Rred);
  //  res_final = NUMERIC_POINTER(Rres_final);
    
    
    for( int i=0;i < nsample; ++i){
      ind[i]=i;
    }
    
    build_mim_subset(mim, data.begin(), namat.begin(), n, nsample, ind, nsample);
    
    
    for(  int i=0; i< n; ++i ){
      res[i]=threshold;
      res_final[i]=threshold;
    }
    
    //init rel and red and select first
    for(  int j=0; j<n; ++j ) {
      rel[j]=cIndex[j];
      red[j]=0;
      if( rel[j] > rel[jmax])
        jmax = j;
    }
    
    score = rel[jmax];
    rel[jmax]=-1000 ;///////////
    for(int l=0; l<n; ++l )  ///////////
      red[l] += mim[l*n+jmax];/////////////
    if( res[jmax] < score ) {
      res[jmax] = score;
    }
    
    //select others
    for(int k=1; k < n+1; k++ ) { 
      jmax = 0;
      if (rel[jmax]==-1000) {
        jmax=jmax+1;
      }///////////
      
      for(int j=1; j < n; ++j ) {
        if (rel[j]==-1000) {///////////////
          continue;////////////
        }                 /////////
        
        if( (rel[j]/(red[j]/k)) > (rel[jmax] / (red[jmax]/k)) ) { ////////////
          jmax = j;
        }
      } 
      score = (rel[jmax] /(red[jmax]/k));
      if( res[jmax] < score ) {
        res[jmax] = score;
      }
      
      //update rel and red
      rel[jmax]=-1000; 
      for(int l=0; l<n; ++l )  
        red[l] += mim[l*n+jmax];
      
      // stop criterion
      if( score < threshold ) k=n;
      
    }
    
    
    for(int i=0; i< n; ++i ) {
      res_final[i]=res[i];
    }
    UNPROTECT(12);
    return res_final;
  }
  //delete [] namat_x;
  //delete [] data_x;




// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//


