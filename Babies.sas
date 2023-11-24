/** SAS project by Fahim Hoq **/

/** Babies Data **/

Libname In 'C:\DATS7510\SAS';

Data In.Babies;
infile 'C:\DATS7510\SAS/babies.txt' ;
input Sex $ 1-6 PrenatalCare $ 9-12 Smoking $ 17-19 WeeksGestaton 25-26 BirthWeight 33-36 Length 41-44 @49 DoB mmddyy10.;
Label Sex = "Sex" PrenatalCare = "Prenatal Care" Smoking = "Smoking status" WeeksGestaton = "Weeks gestaton" BirthWeight = "Birth weight in grams" Length = "Length in inches" DoB = "Date of birth";
format DoB mmddyy10. ;
run;

PROC PRINT DATA=Babies Label;
run;

Proc format;
	value fmtpre 	0 = "Term" 
					1 = "PreTerm"
 run; 


/** 1 Create a new variable for preterm birth that has 2 levels **/

Data Babies1;
infile 'C:\DATS7510\SAS/babies.txt' ;
input Sex $ 1-6 PrenatalCare $ 9-12 Smoking $ 17-19 WeeksGestaton 25-26 BirthWeight 33-36 Length 41-44 @49 DoB mmddyy10.;
Label Sex = "Sex" PrenatalCare = "Prenatal Care" Smoking = "Smoking status" WeeksGestaton = "Weeks gestaton" BirthWeight = "Birth weight in grams" Length = "Length in inches" DoB = "Date of birth";
format DoB mmddyy10. ;
if WeeksGestaton < 37 then preterm = 1;
else if WeeksGestaton >= 37 then preterm = 0;
format preterm fmtpre.;
run;

PROC PRINT DATA=Babies1 Label;
run;

Proc format;
	value fmtwei 	-1 = "Low" 
	                0 = "Normal" 
					1 = "Large"
run;


/** 2 Using the birth weight in grams variable create a variable that has three levels **/

Data Babies2;
infile 'C:\DATS7510\SAS/babies.txt' ;
input Sex $ 1-6 PrenatalCare $ 9-12 Smoking $ 17-19 WeeksGestaton 25-26 BirthWeight 33-36 Length 41-44 @49 DoB mmddyy10.;
Label Sex = "Sex" PrenatalCare = "Prenatal Care" Smoking = "Smoking status" WeeksGestaton = "Weeks gestaton" BirthWeight = "Birth weight in grams" Length = "Length in inches" DoB = "Date of birth";
format DoB mmddyy10. ;

if WeeksGestaton < 37 then preterm = 1;
else if WeeksGestaton >= 37 then preterm = 0;

if BirthWeight < 2500 then Weightclass = -1;
else if . <= BirthWeight <= 4000  then Weightclass = 0;
else if BirthWeight > 4000 then Weightclass = 1;

format preterm fmtpre. Weightclass fmtwei.;

run;

PROC PRINT DATA=Babies2 Label;
run;

/** 3 frequency distribution of all categorical variables including the newly variables above **/

proc freq data = Babies2;
title "Frequency distribution of Gender";
table Sex;
run; 

proc freq data = Babies2;
title "Frequency distribution of PrenatalCare";
table PrenatalCare;
run;

proc freq data = Babies2;
title "Frequency distribution of Smoking status";
table Smoking;
run;

proc freq data = Babies2;
title "Frequency distribution of preterm or term";
table preterm;
run;

proc freq data = Babies2;
title "Frequency distribution of Birthweightgroup of babies";
table Weightclass;
run;


/** 4 cross tabulation of preterm birth with the following variables: the new birth weight group, sex, prenatal care, & smoking status **/

proc freq data = Babies2;
title "Cross table of preterm with weightclass";
tables preterm*Weightclass / out = Table;
run;

proc freq data = Babies2;
title "Cross table of preterm with gender";
tables preterm*Sex / out = Table;
run;

proc freq data = Babies2;
title "Cross table of preterm with Prenatal care";
tables preterm*PrenatalCare / out = Table;
run;

proc freq data = Babies2;
title "Cross table of preterm with smoking status";
tables preterm*Smoking / out = Table;
run;
