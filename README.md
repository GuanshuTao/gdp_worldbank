# gdp_worldbank
WorldBank GDP data sets and evaluation

This project evaluates realtionships between national economic indicators and educational levels attained by different populations.  
The data that is considered for this evaluation is based on data sets provided by the World Bank.  

Specifically, the 1st data set included is : GDP Ranking for the nations of the world. This data set is annualized, time series data, which is generally updated on a quarterly basis. The data includes information from 217 national economies. The data is a subset of the data supporting evaluations of Economy & Growth.

Secondly, the data set World Bank EdStats All Indicator Query that describes indicators related to education levels attained. This data set includes information from 214 economies, is also annual, time-series data which is generally updated on a quarterly basis.

The specific questions to be addressed by this evaluation are :

1 : How many countries have matched data between the GDP Ranking and the Educational Data ?  
2 : For ascendingly sorted GDPs, which country is the 13th ranked GDP  ?  
3 : What are the average GDP rankings for the "High income: OECD" and "High income:
nonOECD" groups ?  
4 : Depiction of the distribution of GDP values for all the countries, identified by income group.  
5 : Summary statistics of GDP by income groups are provided.  
6 : Tabluar description of the GDP ranking by Income Group, based on quintile groups.  
7 : The identified of the number of countries with "Lower middle income" and also within the group of (top 38) nations with highest GDP ?  


For convenience, the presentation of this information is separated into distinct sub-folders of this repository, to enable the reader to select just the elements most interesting for the reader's purpose and interestes. This is enabled by the following organization :  

##__Data Collection__  
* data collection and cleaning is completed within the ./data folder 
 + within this folder, the code that harvest the data from the appropriate web-sites is available, along with 
 + this summary can be found here : https://github.com/bici-sancta/gdp_worldbank/blob/master/data/gather/read_clean_data.md  
 
##__Analysis__  
* analysis of the data to respond to the specifically requested resutls (i.e., the 7 questions above) is completed in the ./analysis folder
 + this summary can be found here :  https://github.com/bici-sancta/gdp_worldbank/blob/master/analysis/analysis.md  
 
   
   
##__Summary Presentation__  
* a summary statement related to the findings of this project are maintained in the ./presentation folder, and can be found here :   
https://github.com/bici-sancta/gdp_worldbank/blob/master/presentation/presentation.md  


* and finally, in order to facilitate the execution of this analysis, within the RStudio environment, the Makefile in this repository main folder provides the ability to complete the execution from the singular Makefile : https://github.com/bici-sancta/gdp_worldbank/blob/master/Makefile  




 
