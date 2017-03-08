R Markdown
----------

    # ...   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # ...       - some data sets
    # ...   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

    # ...   gdp data
    #           https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
    #

    #,Gross domestic product 2012,,,,,,,,
    #,,,,,,,,,
    #,,,,(millions of,,,,,
    #,Ranking,,Economy,US dollars),,,,,
    #,,,,,,,,,
    #USA,1,,United States," 16,244,600 ",,,,,
    #CHN,2,,China," 8,227,103 ",,,,,
    #JPN,3,,Japan," 5,959,718 ",,,,,
    #DEU,4,,Germany," 3,428,131 ",,,,,

    #           http://data.worldbank.org/data-catalog/GDP-ranking-table


    # ... educational data

    #CountryCode,Long Name,Income Group,Region,Lending category,Other groups,Currency Unit,Latest population census,Latest household survey,Special Notes,National accounts base year,National accounts reference year,System of National Accounts,SNA price valuation,Alternative conversion factor,PPP survey year,Balance of Payments Manual in use,External debt Reporting status,System of trade,Government Accounting concept,IMF data dissemination standard,Source of most recent Income and expenditure data,Vital registration complete,Latest agricultural census,Latest industrial data,Latest trade data,Latest water withdrawal data,2-alpha code,WB-2 code,Table Name,Short Name
    #ABW,Aruba,High income: nonOECD,Latin America & Caribbean,,,Aruban florin,2000,,,1995,,,,,,,,Special,,,,,,,2008,,AW,AW,Aruba,Aruba
    #ADO,Principality of Andorra,High income: nonOECD,Europe & Central Asia,,,Euro,Register based,,,,,,,,,,,General,,,,Yes,,,2006,,AD,AD,Andorra,Andorra
    #AFG,Islamic State of Afghanistan,Low income,South Asia,IDA,HIPC,Afghan afghani,1979,"MICS, 2003",Fiscal year end: March 20; reporting period for national accounts data: FY.,2002/2003,,,VAB,,,,Actual,General,Consolidated,GDDS,,,,,2008,2000,AF,AF,Afghanistan,Afghanistan
    #AGO,People's Republic of Angola,Lower middle income,Sub-Saharan Africa,IDA,,Angolan kwanza,1970,"MICS, 2001, MIS, 2006/07",,1997,,,VAP,1991-96,2005,BPM5,Actual,Special,,GDDS,"IHS, 2000",,1964-65,,1991,2000,AO,AO,Angola,Angola

    #       https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
    #       http://data.worldbank.org/data-catalog/ed-stats


    # ...   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # ...   gdp data in & clean
    # ...   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    download.file(url, destfile = "./GDP.csv")
    gdp <- read.csv("GDP.csv", sep = ",",
                    header = FALSE,
                    skip = 5,
                    stringsAsFactors = FALSE)

    gdp_names <- c("country_code", "rank", "aaa", "country_name", "economy_dollars")
    names(gdp) <- gdp_names

    gdp$rank <- as.integer(gdp$rank)

    ## Warning: NAs introduits lors de la conversion automatique

    gdp <- gdp[!is.na(gdp$rank),]

    gdp$economy_dollars <- gsub(",", "", gdp$economy_dollars)
    gdp$economy_dollars <- as.numeric(gdp$economy_dollars)

    gdp[3] <- NULL
    width <- dim(gdp)[2]
    gdp[5:width] <- NULL

    # ...   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # ...   educational data in & clean
    # ...   -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
    download.file(url, destfile = "./EDSTATS_Country.csv")
    edu <- read.csv("EDSTATS_Country.csv", sep = ",",
                    header = TRUE,
                    skip = 0,
                    stringsAsFactors = FALSE)

    width <- dim(edu)[2]
    edu[5:width] <- NULL


    gdp_edu <- merge(gdp, edu, by.x = "country_code", by.y = "CountryCode")

    #gdp_edu[gdp_edu$Income.Group == "High income: OECD",]$Income.Group <- "1_High_   OECD" 
    #gdp_edu[gdp_edu$Income.Group == "High income: nonOECD",]$Income.Group <- "2_High_nonOECD" 
    #gdp_edu[gdp_edu$Income.Group == "Upper middle income",]$Income.Group <- "3_UpperMiddle" 
    #gdp_edu[gdp_edu$Income.Group == "High income: OECD",]$Income.Group <- "4_High_OECD" 
    #gdp_edu[gdp_edu$Income.Group == "High income: OECD",]$Income.Group <- "5_High_OECD" 

Data is now gathered, cleaned, merged into one data frame

    sort_gdp_edu <- gdp_edu[order(gdp_edu$economy_dollars),] 


    high_income_OECD <- gdp_edu[gdp_edu$Income.Group == "High income: OECD",]
    mean_oecd <-mean(high_income_OECD$rank)

    high_income_nonOECD <- gdp_edu[gdp_edu$Income.Group == "High income: nonOECD",]
    mean_nonoecd <-mean(high_income_nonOECD$rank)

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  
**Distributional plots**  
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

![](gdp_worldbank_cs1_files/figure-markdown_strict/unnamed-chunk-2-1.png)![](gdp_worldbank_cs1_files/figure-markdown_strict/unnamed-chunk-2-2.png)![](gdp_worldbank_cs1_files/figure-markdown_strict/unnamed-chunk-2-3.png)

... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=============================================================================

... summary statistics
======================

... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=============================================================================

    ## # A tibble: 5 × 8
    ##           Income.Group n_pays min_gdp    qtr_01   mean_gdp    qtr_03
    ##                  <chr>  <int>   <dbl>     <dbl>      <dbl>     <dbl>
    ## 1           Low income     37     596   3814.00   14410.78   17204.0
    ## 2 High income: nonOECD     23    2584  12838.00  104349.83  131204.5
    ## 3  Upper middle income     45     228   9613.00  231847.84  205789.0
    ## 4  Lower middle income     54      40   2548.75  256663.48   81448.0
    ## 5    High income: OECD     30   13579 211146.75 1483917.13 1480047.2
    ## # ... with 2 more variables: max_gdp <dbl>, stdev <dbl>

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  
**Quartile Summary**  
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

    sort_gdp_edu_by_rank <- gdp_edu[order(gdp_edu$rank),] 

    n_ranks <- dim(gdp_edu)[1]
    quint <- c(0 : (n_ranks-1))
    quint <- as.integer(quint/(n_ranks/5) ) + 1

    sort_gdp_edu_by_rank <- cbind (sort_gdp_edu_by_rank, quint)

    hgh_rank_lower_middle_income <- sort_gdp_edu_by_rank[
                                            sort_gdp_edu_by_rank$Income.Group == "Lower middle income"
                                            & quint == 1,]

    sgebr <- sort_gdp_edu_by_rank


    summary_table <- table(sgebr$quint, sgebr$Income.Group)
    summary_table

    ##    
    ##     High income: nonOECD High income: OECD Lower middle income Low income
    ##   1                    4                18                   5          0
    ##   2                    5                10                  13          1
    ##   3                    8                 1                  12          9
    ##   4                    5                 1                   8         16
    ##   5                    1                 0                  16         11
    ##    
    ##     Upper middle income
    ##   1                  11
    ##   2                   9
    ##   3                   8
    ##   4                   8
    ##   5                   9

    barplot(summary_table,legend = T, beside = T, main = 'income by quintile')

![](gdp_worldbank_cs1_files/figure-markdown_strict/unnamed-chunk-4-1.png)

    library(vcd)

    ## Loading required package: grid

    mosaicplot(summary_table, color = TRUE)

![](gdp_worldbank_cs1_files/figure-markdown_strict/unnamed-chunk-4-2.png)
