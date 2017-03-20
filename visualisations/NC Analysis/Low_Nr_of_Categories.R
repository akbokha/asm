#standaard packages: data.table, plyr, plotly
#Bouwt voor op bestanden 'Bar_Chart_Generator'
#en 'Nr categorien per attribuut'

#kijkend naar de tabel zijn de eerste en laatste rij onzinnig om bar charts van te maken
Low_Nr_Categories_a <- Low_Nr_Categories[2:25,]

#eerst hiermee geprobeerd
Standard_Bar_NC(ncdata$`Material type`)
Standard_Bar_NC(ncdata$'NC Status')


#duurt lang
#ncdata filteren voor de low categories
Low_Vector <- unlist((Low_Nr_Categories_a[,1]))
ncdata_lowcategories <- ncdata[Low_Vector]

#bar chart generator applyen op al deze kolommen
apply(ncdata_lowcategories, MARGIN = 2, FUN = function(x) Standard_Bar_NC(x))

#namen komen niet automatisch mee... weet niet zo goed hoe ik dat moet oplossen. Resultaten 
#heb ik geanalyseerd.


