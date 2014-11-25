
library(shiny)

shinyUI(fluidPage(
  titlePanel("Predicting Enzymatic Reaction Rates"),

  sidebarLayout(
    sidebarPanel(
      p("This application will predict the enzymatic reaction Rates of Galactosyltransferase, based on it's concentration and the presence or lack of Puromycin."),
      p("Simply enter the enzyme concentration and select whether the Puromycin is present, and the application will predict the reaction rate"),
      hr(),
      numericInput("concentration", "Enzyme Concentration (ppm)", 0.2, 0, 1.2, 0.001),
      selectInput("puromycinPresent", "Is Puromycin Present?", c("No", "Yes"))
    ),
    mainPanel(
      h3("Predicted Reaction Velocity (counts/min/min)"),
      textOutput("reactionVelocity"),
      plotOutput("predictionCurve")
    )
  )
))
