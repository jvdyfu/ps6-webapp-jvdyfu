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

useOfForce <- read_delim("Use_Of_Force.csv")

ui <- fluidPage(
  titlePanel("Seattle Police Department: Use Of Force Policy"),
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
                       h5("Level 3 - Officer Involved Shooting (OIS)"),
                       h4("This dataset contains", nrow(useOfForce), "documented use of force incidents
                          from the police in the City of Seattle."),
          
                      ),

                    )
             )),
    tabPanel("Race Bar Plot",
             fluidRow(column(8, h4("This race bar plot attempts to answer the 
                                                 question of whether or not there is a correlation
                                                 between race and the number of police cases
                                                 where force was used. "))),
             sidebarLayout(
               sidebarPanel(
                 selectInput("raceInput", "Choose Race to Display:",
                             choices = c("Black or African American", "White",
                                         "Asian", "Not Specified",
                                         "American Indian/Alaska Native", "Hispanic or Latino",
                                         "Two or More Races",
                                         "Nat Hawaiian/Oth Pac Islander"),
                             selected = "Black or African American",
                             multiple = TRUE),
                 selectInput("colorInput", "Choose Bar Color:",
                             choices = c("Red", "Orange", "Yellow",
                                         "Green", "Blue", "Purple"),
                             selected = "Red")),
               mainPanel(plotOutput("racePlot"),
                         textOutput("color"),
                         textOutput("highestCountRace")),
             )
    ),
    
    tabPanel("Gender Table Panel",
             fluidRow(column(8, h4("This gender table panel attempts to answer the 
                                                 question of whether or not there is a correlation
                                                 between gnder and the number of police cases
                                                 where force was used. We also can answer the 
                                                 question of if there's a correlation with the 
                                                 level of force used (incident type)."))),
             sidebarLayout(
               sidebarPanel(
                 selectInput("forceInput", "Choose Level of Force to Display:",
                              choices = c("Level 1 - Use of Force", "Level 2 - Use of Force",
                                          "Level 3 - Use of Force", "Level 3 - OIS"),
                              selected = "Level 1 - Use of Force"),
                ),
               mainPanel(tableOutput("genderTable"), 
                         textOutput("highestCountGender"),
                         textOutput("lowestCountGender")),
             )
    )
    
  )
)

server <- function(input, output) {
  
  raceData <- reactive({
    useOfForce %>%
      filter(Subject_Race %in% input$raceInput)
  })
  
  
  barColor <- reactive({
    switch(input$colorInput,
           "Red" = "brown3",
           "Orange" = "darkorange",
           "Yellow" = "darkgoldenrod1",
           "Green" = "darkolivegreen3",
           "Blue" = "cornflowerblue",
           "Purple" = "blueviolet"
          )
  })
  
  output$racePlot <- renderPlot({ 
    ggplot(raceData(), aes(x = Subject_Race)) +
      geom_bar(fill = barColor()) +
      labs(x = "Race", y = "Number of Cases where Force was Used", title = "Race Distribution") +
      theme_minimal()
  })
  
  output$genderTable <- renderTable({
    useOfForce %>% 
      filter(Incident_Type == input$forceInput) %>% 
      group_by(Subject_Gender, Incident_Type) %>% 
      summarize(Number_Of_Cases = n()) 
  })
  
  
  output$color <- renderText({
    paste("The selected color is: ", input$colorInput, ".", sep = "")
  })
  
  output$highestCountRace <- renderText({
      paste("Now displaying race: ", input$raceInput, ". \n", sep = "")
  })
  
  output$highestCountGender <- renderText({
    useOfForce %>% 
      filter(Incident_Type == input$forceInput) %>% 
      group_by(Subject_Gender, Incident_Type) %>% 
      summarize(Number_Of_Cases = n()) %>% 
      pull(Number_Of_Cases) %>% 
      max() %>% 
      paste("The max number of cases within the selected level of use of force is ", ., ".", sep = "")
      
  })
  
  output$lowestCountGender <- renderText({
    useOfForce %>% 
      filter(Incident_Type == input$forceInput) %>% 
      group_by(Subject_Gender, Incident_Type) %>% 
      summarize(Number_Of_Cases = n()) %>% 
      pull(Number_Of_Cases) %>% 
      min() %>% 
      paste("The min number of cases within the selected level of use of force is ", ., ".", sep = "")
    
  })
  

}

# Run the application 
shinyApp(ui = ui, server = server)
