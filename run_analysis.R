d<-read.csv2("./UCI HAR Dataset/features.txt", sep=" ", header=FALSE)
vars<-as.character(d$V2[grepl("mean()",d$V2,fixed=TRUE) | grepl("std",d$V2)])

skp<-c(rep("NULL",561))
skp[grepl("mean()",d$V2,fixed=TRUE) | grepl("std",d$V2)]<-"numeric"

tr_x<-read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE, colClasses=skp)
tr_y<-read.csv2("./UCI HAR Dataset/train/y_train.txt", sep=" ", header=FALSE)
tr_sub<-read.csv2("./UCI HAR Dataset/train/subject_train.txt", sep=" ", header=FALSE)
tr<-cbind(tr_sub,tr_y,tr_x)

te_x<-read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE, colClasses=skp)
te_y<-read.csv2("./UCI HAR Dataset/test/y_test.txt", sep=" ", header=FALSE)
te_sub<-read.csv2("./UCI HAR Dataset/test/subject_test.txt", sep=" ", header=FALSE)
te<-cbind(te_sub,te_y,te_x)

t<-rbind(tr,te)
t[,1]<-as.factor(t[,1])
t[,2]<-as.factor(t[,2])

lab_act<-read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
levels(t[,2])<-lab_act$V2

varnames<-c("Person","Activity",vars)
names(t)<-varnames

m<-aggregate(t[3:48],by=list(t$Person,t$Activity),FUN=mean,drop=FALSE)
write.table(m,file="./tidy.txt",row.names=FALSE)
