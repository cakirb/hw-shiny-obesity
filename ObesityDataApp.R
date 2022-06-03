#
# This is a Shiny web application. You can run the application by clicking
# the "Run App" button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(GEOquery)
library(tidyverse)
library(plotly)

# Steps to create dataframe (ObeseData.RData)
#
# gds <- getGEO("GSE474", AnnotGPL = TRUE)
# gds <- gds$GSE474_series_matrix.txt.gz
# expr <- as.data.frame(t(gds@assayData$exprs))
# expr <- as.data.frame((gds@assayData$exprs))
# 
# text <- pData(gds)$title
# no <- apply(expr[,grep("-NonObese-", text)], 1, mean)
# mo <- apply(expr[,grep("-MObese-", text)], 1, mean)
# ob <- apply(expr[,grep("-Obese-", text)], 1, mean)
# ObeseData <- as.data.frame(cbind(no,ob,mo))
# colnames(ObeseData) <- c("NonObese", "Obese", "MorbidObese")
# save(ObeseData, file = "ObeseData.RData")

load("ObeseData.RData") 


# Define UI for application that draws scatter plot and shows the table 
ui <- fluidPage(

    # Application title
    titlePanel("Obesity Data Application"),

    # Sidebar with four inputs
    sidebarLayout(
        sidebarPanel(
            p("This application is designed to examine the obesity data by comparing 
              the expression levels of different groups with the plot and the table."),
          
          # input to select plotting options
            radioButtons("plotType", "Choose your plotting option:",
                         c("ggplot" = "ggplot",
                           "plotly" = "plotly")),
        
          # input to select FIRST group to plot and create the table
            selectInput("group1", "Choose the obesity category to view:",
                        c("normal" = "NonObese",
                          "obese" = "Obese",
                          "morbidly obese" = "MorbidObese")),
            
          # input to select SECOND group to plot and create the table
            selectInput("group2", "Choose another category to compare with:",
                        c("normal" = "NonObese",
                          "obese" = "Obese",
                          "morbidly obese" = "MorbidObese")),
            
          # input to select number of genes to plot and create the table
            sliderInput("numGenes", "Number of genes:",
                        min = 10,
                        max = 1000,
                        value = 10)
            ),

      # Show a scatter plot and dataframe with selected inputs in different panels
      mainPanel(
            tabsetPanel(
              # conditionalPanel to indicate different output types for ggplot (plotOutput) and plotly(plotlyOutput)
                tabPanel("Plot", h4("Scatter plot"), conditionalPanel("input.plotType == 'plotly'", plotlyOutput("plotly")), 
                  conditionalPanel("input.plotType == 'ggplot'", plotOutput("plot"))), 
                
                tabPanel("Data", h4("Expression levels of two groups"), dataTableOutput("data")))
    )
))

# Define server logic required to draw the scatter plot and create the table
server <- function(input, output) {
    
    # reactive variable to create the subset according to number of genes and selected groups
    e <- reactive({(ObeseData[(1:input$numGenes),c(input$group1,input$group2)])})
    
    
    # output for ggplot
    output$plot <- renderPlot({
    ggplot(e(), aes(get(input$group1), get(input$group2))) + geom_point() + theme_bw() +
        labs(x = input$group1, y = input$group2)
        })
    
    # output for plotly
    output$plotly <- renderPlotly({
      plot_ly(e(), x=~get(input$group1), y=~get(input$group2), type='scatter') %>%
        layout(xaxis = list(title = input$group1),
               yaxis = list(title = input$group2))
    })

    # output for the table
    output$data <- renderDataTable({
        e()
    })

}

# Run the application 
shinyApp(ui = ui, server = server)


