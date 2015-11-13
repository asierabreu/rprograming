# rprograming
## R Programing Training
### Configuration
 - R version: 3.1.1. (2014-07-10)
 - Platform :  x86_64-apple-darwin13.1.0 (64-bit)
### Programing Task 1 Notes
 - Created a class pollutant.R with a pollutant object and a getMean method
 - Created default function pollutantmean.R  
### Results
 - R results and a direct awk sum can differ by up to 1% 
 - Example :
   AWK command : for i in {0,1,2};do cat 07$i.csv | grep -v NA | sed 's/\,/ /g' | awk '{ SUM += $3} END { print SUM/NR}';done
   
   |AWK SUM	|R	| 
   |------------|-------|
   |0.254266	|0.25517|
   |1.45761	|1.43160|
   |2.41861	|2.36321|
