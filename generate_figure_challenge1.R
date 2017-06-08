#write(candidate<-names(data)[p_sobel<0.05/5000],file="candidate.txt")
#write(p_sobel,file="pval.txt",ncolumns=1)


pval<-scan("pval.txt")
set<-as.character(read.table("candidate.txt",header=F)[,1])

require(data.table)
nb_med<-5000
data<-fread("data/challenge1.txt",header=TRUE,data.table=FALSE)



truess<-as.character(read.table("https://www.dropbox.com/s/z3rtupgqdndgdb1/true_challenge1.txt?raw=1")[,1])
truess<-which(names(data)%in%truess)

EtoM<-as.character(read.table("https://www.dropbox.com/s/7vk64u1040bij5y/EtoM_challenge1.txt?raw=1")[,1])
EtoM<-which(names(data)%in%EtoM)

set<-which(names(data)%in%set)

pdf("bla.pdf")
ml<-(-log10(pval))
par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)
plot(ml,xlab="Markers",ylab="-log10(Pval)",cex.lab=1.5,cex.axis=2,cex=2)
points((1:5000)[EtoM],ml[EtoM],pch=19,col=4,cex=1)
points((1:5000)[truess],ml[truess],pch=19,col=2,cex=1)
points((1:5000)[set],ml[set],col=6,pch=0,cex=3)
legend("topright", inset=c(-0.35,0), legend=c("All marks","True XtoM","True Mediation","Candidate"),pch=c(1,19,19,0), col=c(1,4,2,6))
dev.off()
