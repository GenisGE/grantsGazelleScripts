blockJackUneven<-function(dat,theta=function(x) sum(x[,1])/sum(x[,2])){
  dat<-dat[dat[,3]>0,]
  nblocks<-dim(dat)[1]
  
  thetaEst<-theta(dat)
  etai<-rep(0, nblocks)
  blockSize<-dat[,3]
  blockFrac<-blockSize/sum(blockSize)

  for(i in 1:nblocks)
    etai[i]<-theta(dat[-i,])
#  etai<-(sum(dat[,1])-dat[,1])/(sum(dat[,2])-dat[,2])
  meanJack<-mean(etai)
  jackEst<-nblocks*thetaEst-sum((1-blockFrac)*etai)
  jackVar<-(nblocks-1)/nblocks * sum((etai-meanJack)^2)
  jackVar<-1/nblocks * sum( 1/(1/blockFrac-1) * (1/blockFrac*thetaEst-(1/blockFrac-1)*etai - nblocks*thetaEst+sum((1-blockFrac)*etai))^2)
   
 return(c(jackVar=jackVar,jackEst=jackEst))
}


getD<-function(x,freq,siteInfo){


 f<-freq[,x]
 keep1<-rowSums(is.na(f))==0

  if(sum(keep1)<10){
     res<-rep(NA,8)
     names(res)<-c("D","Djack","SE","Z","diff","total","Nsites","Nblocks")  
     return(res)

 }
 ##n<-(f[,3]-f[,4])*(f[,1]-f[,4])
 #d<-(f[,3]+f[,4]-2*f[,3]*f[,4])*(f[,1]+f[,4]-2*f[,1]*f[,4])
 f<-f[keep1,]
 n<-(f[,3]-f[,4])*(f[,2]-f[,1])
 # return()
 d<-(f[,3]+f[,4]-2*f[,3]*f[,4])*(f[,1]+f[,2]-2*f[,1]*f[,2])
#  return()

 res<-1
 keep<-d>0
 n<-n[keep]
 d<-d[keep]
 est<-sum(n)/sum(d)
 nb<-ctapply(n,siteInfo$block[keep1][keep],sum)
 db<-ctapply(d,siteInfo$block[keep1][keep],sum)
 lb<-ctapply(d,siteInfo$block[keep1][keep],length)
 Z<-NA
 se<-NA
 estJ<-NA

 if(length(lb)>19){
     jackRes<-blockJackUneven(cbind(nb,db,lb))
     estJ<-jackRes[2]
     se<-sqrt(jackRes[1])
     Z<-est/se
 }
 res<-c(est,estJ,se,Z,sum(n),sum(d),sum(keep),length(nb))
 names(res)<-c("D","Djack","SE","Z","diff","total","Nsites","Nblocks")
 
 return(res)
}
