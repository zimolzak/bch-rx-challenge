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



data WORK.DRUG_DETAILS    ;
%let _EFIERR_ = 0;
infile 'C:\Users\ch151634\Desktop\surescripts_code\fixed.csv' delimiter = '|' MISSOVER DSD lrecl=32767 firstobs=2 ;
   informat messageid $40. ;
   informat rowid best32. ;
   informat DrugDescription $29. ;
   informat DaySupply best32. ;
   informat Directions $63. ;
   informat DrugCodedProductCode $32. ;
   informat DrugCodedProductCodeQualifier $2. ;
   informat DrugCodedStrength $20. ;
   informat FillNumber best32. ;
   informat FillDate yymmdd10. ;
   informat Quantity best32. ;
   informat QuantityQualifier $2. ;
   informat QuantityValue best32. ;
   informat Refills $1. ;
   informat RefillQualifier $1. ;
   informat RefillQuantity best32. ;
   informat DateWritten yymmdd10. ;
   informat NPI $40. ;
   format messageid $40. ;
   format rowid best12. ;
   format DrugDescription $29. ;
   format DaySupply best12. ;
   format Directions $63. ;
   format DrugCodedProductCode $32. ;
   format DrugCodedProductCodeQualifier $2. ;
   format DrugCodedStrength $20. ;
   format FillNumber best12. ;
   format FillDate yymmdd10. ;
   format Quantity best32. ;
   format QuantityQualifier $2. ;
   format QuantityValue best12. ;
   format Refills $1. ;
   format RefillQualifier $1. ;
   format RefillQuantity best12. ;
   format DateWritten yymmdd10. ;
   format NPI $40. ;
input
            messageid $
            rowid
            DrugDescription $
            DaySupply
            Directions $
            DrugCodedProductCode $
            DrugCodedProductCodeQualifier $
            DrugCodedStrength $
            FillNumber
            FillDate
            Quantity 
            QuantityQualifier $
            QuantityValue
            Refills $
            RefillQualifier $
            RefillQuantity
            DateWritten
            NPI $
;
if _ERROR_ then call symputx('_EFIERR_',1); 
run;
