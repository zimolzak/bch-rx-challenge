OPTIONS FORMCHAR="|----|+|---+=|-/\<>*";

ods html close;
ods listing;

x "cd C:\Users\ch151634\Desktop\surescripts_code";

PROC IMPORT OUT= WORK.DRUG_DETAILS 
            DATAFILE= "C:\Users\ch151634\Desktop\surescripts_code\fixed.
csv" 
            DBMS=DLM REPLACE;
     DELIMITER='7C'x; 
     GETNAMES=YES;
     DATAROW=2; 
RUN;


