DrugDetails = read.csv("/Users/ajz/Desktop/local/surescript-code/fixed_drug_details.csv", sep="|", quote="", colClasses=c("character", "integer", "character", "integer", "character", "character", "factor", "character", "numeric", "Date", "character", "factor", "numeric", "character", "factor", "integer", "Date", "character"))

MedicationHistoryRecords = read.csv("/Users/ajz/Desktop/local/surescript-code/Medication_History_Records.csv", sep=",", quote="", colClasses=c("character", "character", "integer", "character"))

joined = merge(x = DrugDetails, y = MedicationHistoryRecords, by = "messageid") # around a minute

joined = joined[order(joined$patientid, joined$DrugCodedProductCode, joined$FillDate),] # 10 sec

#### elementary counts

length(unique(joined$patientid)) # 35190 patients
length(unique(joined$DrugCodedProductCode)) # 16015 NDCs

##### find most frequently prescribed NDCs

row.names(joined) = (1:dim(joined)[1])

df_ndc = data.frame(ndc = joined$DrugCodedProductCode, stringsAsFactors=FALSE)
ndc_bestsellers = rle(sort(df_ndc$ndc)) # 15 sec
ndc_best_df = data.frame(count = unlist(ndc_bestsellers[1]), DrugCodedProductCode = unlist(ndc_bestsellers[2]))
ndc_best_df = ndc_best_df[order(ndc_best_df$count, decreasing = TRUE),]

uniq_drug_rownames = row.names(unique(df_ndc))
uniq_drugs = joined[uniq_drug_rownames,] # about 45 sec of CPU-intensive
ndc_dict = uniq_drugs[c("DrugDescription", "DrugCodedProductCode")]

bestseller_w_names = merge(x=ndc_dict, y=ndc_best_df, by="DrugCodedProductCode")
bestseller_w_names = bestseller_w_names[order(bestseller_w_names$count, decreasing=TRUE),]

head(bestseller_w_names, n=100)

#### elementary analyses on DrugDescription

length(unique(uniq_drugs$DrugDescription)) # 9451; not all NDCs have unique descriptions
head(unique(sort(uniq_drugs$DrugDescription)),n=100) # first few DrugDescriptions in alphabetical.

#### elementary analysis on delay between date rx written and date rx filled.

delay = joined[joined$FillNumber==0,"FillDate"] - joined[joined$FillNumber==0,"DateWritten"]
require(ggplot2)
plot = ggplot(data.frame(delay = as.numeric(delay)), aes(x=delay))
plot + geom_density() + scale_x_log10() # univar distribution of delay (rx vs fill) is kinda bimodal

delay_all = data.frame(delay = as.numeric(joined$FillDate - joined$DateWritten))
joined = cbind(joined,delay_all)

plot2 = ggplot(head(joined,n=10000), aes(x=DateWritten, y=delay))
plot2 + geom_density2d() + geom_point()  + ylim(0, 150) + xlim(as.Date("2012-07-01"), as.Date("2013-12-31"))
  # envelope effect of delay vs date written, 2D density looks like flat trend.

plot3 = ggplot(head(joined,n=100000), aes(x=DateWritten, y=delay))
plot3 + geom_density2d() + ylim(0, 150) + xlim(as.Date("2012-07-01"), as.Date("2013-12-31"))
  # just a zoomed in 2D density plot

#### rectangle plot for a few patients

do_rectangle_plot = function(drug_fill_data_frame) {
	pt_ndc_pairs = unique(drug_fill_data_frame[c("patientid", "DrugCodedProductCode")])
	pt_ndc_pairs$n = 1:dim(pt_ndc_pairs)[1]

	pt_n = unique(drug_fill_data_frame["patientid"])
	pt_n$pt_n = 1:dim(pt_n)[1]

	j_drugeras = merge(x= drug_fill_data_frame, y=pt_ndc_pairs, by = c("patientid", "DrugCodedProductCode"))
	j_drugeras = merge(x=j_drugeras, y=pt_n, by = "patientid")

	rect_plot = ggplot(j_drugeras, 
		aes(xmin=n-0.5, xmax=n+0.5, ymin=FillDate, ymax=FillDate+DaySupply, alpha=0.5, color=as.factor(pt_n)))
	rect_plot + geom_rect() + coord_flip() # + scale_y_discrete() #+ scale_y_continuous()
}

do_rectangle_plot(head(joined, n=300))

#### NPI (provider) level analysis

sort_me_by_npi = head(joined, n=100000)
sort_me_by_npi = sort_me_by_npi[sort_me_by_npi$NPI != "" & ! is.na(sort_me_by_npi$FillDate),] # 2161 non-blank out of 10000
sort_me_by_npi = sort_me_by_npi[order(sort_me_by_npi$NPI),]
common_npis = rle(sort_me_by_npi$NPI)
sorted_npis = data.frame(NPI = common_npis$values[order(common_npis$lengths, decreasing=TRUE)], count = common_npis$lengths[order(common_npis$lengths, decreasing=TRUE)], stringsAsFactors=FALSE)
my_NPI = sorted_npis$NPI[1] 

# good npis:
# "914e2abf389eea3e7aad540d8e1d0de31587d88d"
# "3d735541e2ac8521379b2b11d043ebf274bcfd3d" has <NA> dates
# "7337ba41a39090a060a7b6b52dd3b256c4f4d370"

my_data = joined[joined$NPI == my_NPI,]

# dim(data_for_popular_doc)[1]
# sorted_npis$count[1]
# dim(data_for_popular_doc)[1] == sorted_npis$count[1]

do_rectangle_plot(my_data)

f = my_data[c( "FillDate", "DrugDescription", "DrugCodedStrength", "DaySupply", "DateWritten", "Directions", "QuantityValue")]
f[order(f$FillDate, f$DrugDescription),]

my_patients = unique(my_data$patientid)
my_patients_data = joined[joined$patientid %in% my_patients,]
my_patients_doctors = unique(my_patients_data$NPI)

#### patient level analysis

# FIXME - abstract this out.
patients = head(joined, n=100000)
patients = patients[order(patients$patientid),]
common_patients_rle = rle(patients$patientid)
common_patients = data.frame(patientid = common_patients_rle$values[order(common_patients_rle$lengths, decreasing=TRUE)], count = common_patients_rle$lengths[order(common_patients_rle$lengths, decreasing=TRUE)], stringsAsFactors=FALSE)
my_patientid = common_patients$patientid[1] 

my_data = joined[joined$patientid == my_patientid,]
f = my_data[c( "FillDate", "DrugDescription", "DaySupply", "DateWritten", "DrugCodedProductCode", "messageid", "MessageDate")]
head(f[order(f$FillDate, f$DrugDescription),], n=100) # Good example of duplicate drugs!

# FIXME - MessageDate did not import properly as class Date.
