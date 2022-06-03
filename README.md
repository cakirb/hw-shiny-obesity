# Shiny Application for Obesity Data

This Shiny application was made as a homework in the scope of [BSB 632: Advanced Bioinformatics with R](https://abl.gtu.edu.tr/ects/?dil=en&modul=ders_bilgi_formu&bolum=2201&tip=doktora&duzey=ucuncu&dno=BSB%20632) course in Bioinformatics and Systems Biology PhD programme of Gebze Technical University.  

### Dataset
This application uses the modified dataframe of [transcriptome data from Park et al (2006) from GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE474). Modified dataframe consists of 22283 genes with Probe IDs as row names, and three columns with average expression values for each obesity category (normal, obese, morbidly obese).  

### Application
This application can plot the expression values as scatter plot where each point corresponds to the expression value of a gene in two categories, and show these values as a table in the second tab

This application allows the user to:
* choose the plotting option (ggplot2 and plotly),
* choose two obesity categories (normal, obese, morbidly obese),
* choose the number of genes.

## Screenshots
<img src="/images/image_plottab.png" width="700"/>. 

<img src="/images/image_datatab.png" width="700"/> 
