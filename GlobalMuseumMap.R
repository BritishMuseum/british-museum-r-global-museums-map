#------------------------Plotting Museums of the world on a map using rworldmap -------------------------------------------------------------
#https://github.com/BritishMuseum/RGlobalMuseumMap
#Date: 05/06/2016
#Author: Alice Daish
#Purpose : To plot museum numbers on world map
#Edit: 27/06/2016 Simple DRY by @portableant for attribution

#------------------Install package-----------------------------------------------------------------------------------------------------------
list.of.packages <- c("rworldmap", "RCurl")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(RCurl)
library(rworldmap)

#------------------Download data ---------------------------------------------------------------------------------------------------------------
data1<- getURL("https://raw.githubusercontent.com/BritishMuseum/RGlobalMuseumMap/master/museums_countries_data.csv")
data <- read.csv(text = data1)
attribution <- "Data Source :Museums of the World. (2015). Berlin, Boston: De Gruyter Saur. Retrieved 5 Jun. 2016, from http://www.degruyter.com/view/product/448539"

#--------MAP PLOTTING -----------------------------------------------------------------------------------------------------------------------
#Example using country name to link data to map more likely to have errors 
#mapDevice('x11') #create a map-shaped window #Plot museum numbers on yellow to red colour sprectum map  (no legend)
#dmap <- joinCountryData2Map(data, joinCode="NAME", nameJoinColumn="country") #Join data to map using "NAME" as identifer
#map1<-mapCountryData(dmap, nameColumnToPlot="number_of_museums",mapTitle="Number of museums by country",catMethod="fixedWidth",addLegend=T) #display the map


#-------MAP PLOT USING ISO code (more accurate using ISO join) (YellowMap)------------------------------------------------------------------
#Legend Scale
mapDevice('x11') #create a map-shaped window
dmap <- joinCountryData2Map(data, joinCode="ISO3", nameJoinColumn="ISO") #Join data to map using "ISO" code as identifer
mapCountryData(dmap, nameColumnToPlot="number_of_museums", catMethod="fixedWidth",mapTitle="Number of museums by country") #display the map
mtext(attribution,side=1,line=-1) #add data citation

#Group numeric legend (more accurate with Legend)
mapDevice('x11') #create a map-shaped window
dmap <- joinCountryData2Map(data, joinCode="ISO3", nameJoinColumn="ISO") #Join data to map using "ISO" code as identifer
map1 <- mapCountryData(spdf, nameColumnToPlot="number_of_museums",mapTitle="Global Museum Numbers by Country",catMethod="fixedWidth",addLegend=F)#display the map
do.call(addMapLegendBoxes,c(map1,x="bottom",horiz = T, title = "")) #add numeric catergory legend
mtext(attribution,side=1,line=-1) #add data citation



#--------COLOURFUL MAP OF MUSEUM BY NUMBER COLOUR GROUPS ------------------------------------------------------------------------------------
mapDevice('x11') #create a map-shaped window
dmap <- joinCountryData2Map( data,joinCode = "ISO3",nameJoinColumn = "ISO" )
col <- palette(c("red","orange","yellow","green")) #creating a user defined colour palette
cutVector <- quantile(dmap@data[["number_of_museums"]],na.rm=TRUE) #find quartile breaks
dmap@data[["museumnumber"]] <- cut( dmap@data[["number_of_museums"]],cutVector, include.lowest=TRUE ) #classify the data to a factor
levels(dmap@data[["museumnumber"]]) <- c("very low (0-2)","low (3-12)","med (13-70)","high (71-8344)") #rename the categories
mapCountryData( dmap, nameColumnToPlot="museumnumber",catMethod="categorical",mapTitle="Global Museum Numbers by Country",colourPalette="palette", oceanCol="lightblue",missingCountryCol="white") #display map
mtext(attribution,side=1,line=-1) #add data citation


#----- BLACK AND WHITE MUSEUM MAP-(dark)-------------------------------------------------------------------------------------------------------
mapDevice('x11') #create a map-shaped window
dmap <- joinCountryData2Map( data,joinCode = "ISO3",nameJoinColumn = "ISO" ) #Join data to map using "ISO" code as identifer
col <- palette(c("white","light grey","dark grey","black")) #creating a user defined colour palette
cutVector <- quantile(dmap@data[["number_of_museums"]],na.rm=TRUE) #find quartile breaks
dmap@data[["museumnumber"]] <- cut( dmap@data[["number_of_museums"]],cutVector, include.lowest=TRUE ) #classify the data to a factor
levels(dmap@data[["museumnumber"]]) <- c("very low (0-2)","low (3-12)","med (13-70)","high (71-8344)") #rename the categories
mapCountryData( dmap, nameColumnToPlot="museumnumber",catMethod="categorical",mapTitle="Global Museum Numbers by Country",colourPalette="palette", oceanCol="dimgrey",missingCountryCol="white",borderCol="black") #display map
mtext(attribution,side=1,line=-1) #add data citation


#----- BLACK AND WHITE (greyscale) MUSEUM MAP--------------------------------------------------------------------------------------------------
mapDevice('x11') #create a map-shaped window
dmap <- joinCountryData2Map( data,joinCode = "ISO3",nameJoinColumn = "ISO" ) #Join data to map using "ISO" code as identifer
col <- palette(c("white","light grey","dark grey","dim grey")) #creating a user defined colour palette
cutVector <- quantile(dmap@data[["number_of_museums"]],na.rm=TRUE) #find quartile breaks
dmap@data[["museumnumber"]] <- cut( dmap@data[["number_of_museums"]],cutVector, include.lowest=TRUE ) #classify the data to a factor
levels(dmap@data[["museumnumber"]]) <- c("very low (0-2)","low (3-12)","med (13-70)","high (71-8344)") #rename the categories
mapCountryData( dmap, nameColumnToPlot="museumnumber",catMethod="categorical",mapTitle="Global Museum Numbers by Country",colourPalette="palette", oceanCol="darkgrey",missingCountryCol="white",borderCol="black") #display map
mtext(attribution,side=1,line=-1) #add data citation

#-------------End---------------------------------------------------------------------------------------------------------------------------------