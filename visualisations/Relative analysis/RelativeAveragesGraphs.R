#Using the Relative_AVerages_Function and the new machines datasets
#packages data.table, plyr, plotly are needed for execution of functions

Relative_Averages(alldataNewMachines, earchiveNewMachines, "Location", "Location", "Average Number of NC's", "Relative number of NC's per Location")

aaaa <- Relative_Averages(alldataNewMachines, earchiveNewMachines, "Type", "Type", "Average Number of NC's", "Relative number of NC's per Product Type")
Relative_Averages(alldataNewMachines, earchiveNewMachines, "'Process R1'", "Process", "Average Number of NC's", "Relative number of NC's per R1 Process")
PNAverages <- Relative_Averages(alldataNewMachines, earchiveNewMachines, "PN", "Product Number", "Average Number of NC's", "Relative number of NC's per Product")



