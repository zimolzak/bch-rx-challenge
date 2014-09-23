OPTIONS FORMCHAR="|----|+|---+=|-/\<>*";
ods html close;
ods listing;
x "cd C:\Users\ch151634\Desktop\surescripts_code";

data WORK.DRUG_DETAILS    ;
%let _EFIERR_ = 0;
infile 'C:\Users\ch151634\Desktop\surescripts_code\fixed.csv' delimiter = '|' MISSOVER DSD lrecl=32767 firstobs=2 ;
   informat messageid $40. ;
   informat rowid best32. ;
   informat DrugDescription $35. ;
   informat DaySupply best32. ; *string 3;
   informat Directions $140. ;
   informat DrugCodedProductCode $32. ;
   informat DrugCodedProductCodeQualifier $2. ;
   informat DrugCodedStrength $60. ;
   informat FillNumber best32. ; *string 2;
   informat FillDate yymmdd10. ;
   informat Quantity best32. ; *not used;
   informat QuantityQualifier $2. ;
   informat QuantityValue best32. ; *string 10;
   informat Refills $1. ; *not used;
   informat RefillQualifier $1. ;
   informat RefillQuantity best32. ; *string 2;
   informat DateWritten yymmdd10. ;
   informat NPI $40. ;
   format messageid $40. ;
   format rowid best12. ;
   format DrugDescription $35. ;
   format DaySupply best12. ;
   format Directions $140. ;
   format DrugCodedProductCode $32. ;
   format DrugCodedProductCodeQualifier $2. ;
   format DrugCodedStrength $60. ;
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

proc univariate data=drug_details;
	var rowid daysupply fillnumber filldate quantityvalue refillquantity datewritten;
run;

proc freq data=drug_details; *strictly integer;
	tables rowid daysupply fillnumber refillquantity;
run;

proc sgplot data=drug_details;	density filldate / type=kernel; run;
proc sgplot data=drug_details;	density rowid / type=kernel; run;
proc sgplot data=drug_details;	density daysupply / type=kernel; xaxis max=200; run;
proc sgplot data=drug_details;	density fillnumber / type=kernel; xaxis max=15; run;
proc sgplot data=drug_details(where=(quantityvalue < 120));	density quantityvalue / type=kernel; xaxis min=0 max=120; run;
proc sgplot data=drug_details;	density refillquantity / type=kernel; xaxis max=12; run;
proc sgplot data=drug_details;	density datewritten / type=kernel; run;

****non numeric;

proc freq data=drug_details;
	tables drugcodedproductcodequalifier quantityqualifier refillqualifier;
run;

proc freq data=drug_details;
	tables refillqualifier * refillquantity / missing;
run;
