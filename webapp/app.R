#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

setwd("~/INFO\ 201/PS/ps6-webapp-jvdyfu/webapp")
getwd()

useOfForce <- read_delim("Use_Of_Force.csv")
useOfForce

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Seattle Police Department: Use of Force Policy"),
  tabsetPanel(
    tabPanel("Introduction",
             mainPanel(
               fluidRow(
                 column(8,
                        h3("Purpose:"),
                        h4("Police brutality against marginalized communities (BIPOC, LGBTQIA+)
                           has sparked discussions on (de)funding, (de)militarization, and the 
                           role of police in society. The Use of Force policy, implemented on 
                           4/15/2021, aims to ensure impartial policing, accountability, and 
                           constant evaluation. We believe that new data on policing patterns
                           can inform this ongoing discourse and shape our opinions."),
                        h3("Source:"),
                        h4("The data comes a reliable source from the City of Seattle's open portal 
                           (data.seattle.gov) where the data is published by city departments.
                           The city department we decided to look in is the Seattle Police 
                           Department with a focus on the use of force policy."),
                        h4("The use of force policy is broken down into four levels:"),
                        h5("Level 1 - Restraint/Transitory Pain"),
                        h5("Level 2 - Bodily Harm"),
                        h5("Level 3 - Bodily Risk"),
                        h5("Level 3 - Officer Involved Shooting (OIS)")
                        ),
                 column(4,
                        HTML("<br>"),
                        h6("A Seattle police officer pepper-sprays protestors in
                           downtown Seattle while another makes an arrest
                           on May 31, 2020.", textOutput("area")),
                        img(src = "~/INFO\ 201/PS/ps6-webapp-jvdyfu/webapp/images/pepperspray.png",
                            height = 400, width = 400)
                        )
                  
                 
               )
             )),
    
    tabPanel("Plot"
      
    ),
    
    tabPanel("Table"
      
    )
    
  )

    # Application title
    #titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    #sidebarLayout(
        #sidebarPanel(
            #sliderInput("bins",
                        #"Number of bins:",
                        #min = 1,
                        #max = 50,
                        #value = 30)
        #),

        # Show a plot of the generated distribution
        #mainPanel(
           #plotOutput("distPlot")
        #)
    #)
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    #output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        #x    <- faithful[, 2]
        #bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        #hist(x, breaks = bins, col = 'darkgray', border = 'white',
             #xlab = 'Waiting time to next eruption (in mins)',
             #main = 'Histogram of waiting times')
    #})
}

# Run the application 
shinyApp(ui = ui, server = server)
