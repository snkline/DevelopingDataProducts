library(shiny)
require(stats) 
require(graphics)

shinyServer(function(input, output) {

  fm1 <- nls(rate ~ Vm * conc/(K + conc), data = Puromycin,
             subset = state == "treated",
             start = c(Vm = 200, K = 0.05))
  fm2 <- nls(rate ~ Vm * conc/(K + conc), data = Puromycin,
             subset = state == "untreated",
             start = c(Vm = 160, K = 0.05))  
  
  output$reactionVelocity <- renderText({
    selectedConc <- input$concentration
    conc <- seq(selectedConc * 0.75, selectedConc * 1.25, length.out=101)
    if (input$puromycinPresent == "Yes") {
      prediction <- predict(fm1, list(conc = conc))
      idx <- match(selectedConc, conc)      
      prediction[idx]
    } else {
      prediction <- predict(fm2, list(conc = conc))
      idx <- match(selectedConc, conc)
      prediction[idx]
    }      
  })
    
  output$predictionCurve <- renderPlot({
    selectedConc <- input$concentration
    conc <- seq(selectedConc * 0.75, selectedConc * 1.25, length.out=101)
    if (input$puromycinPresent == "Yes") {
      plot(conc, predict(fm1, list(conc = conc)), 
           xlab = "Substrate Concentration (ppm)",
           ylab = "Reaction Velocity (counts/min/min)",
           main = "Position on Prediction Curve", type="l", lty = 1)  
    }
    else {
      plot(conc, predict(fm2, list(conc = conc)), 
           xlab = "Substrate Concentration (ppm)",
           ylab = "Reaction Velocity (counts/min/min)",
           main = "Position on Prediction Curve", type="l", lty = 1)      
    }
    abline(v=selectedConc, col=2)  
  })

})
