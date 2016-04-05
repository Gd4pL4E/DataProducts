library(shiny)

#Calculates the BMI value
calcbmi <- function(height, weight) round(weight/(height/100)^2, 2)
x <- 1:21*5 + 15

#Calculates the weight you would have for a BMI value of 18.5, 25 and 30
#This is to determine what the limits are
calclimits <- function(height) {
  i <- numeric(3)
  i[1] <- 18.5 * (height/100)^2 #<18.5 = underweight
  i[2] <- 25 * (height/100)^2   #18.5 - 25 = normal weight
  i[3] <- 30 * (height/100)^2   #25 - 30 = overweight | >30 = obese
  i
}

#This function makes a plot with the weight as x and BMI as y. This way you can see
#what weight you are "supposed" to have
plotbmi <- function(height, weight, limits, x) {
  y <- calcbmi(height, x)
  plottitle <- paste("The BMI for a height of", as.character(height), "cm, for a given weight")
  plot(x, y, 
       main = plottitle, 
       xlab = "Weight", ylab = "BMI", 
       type = "l", lty = 5)
  #The black line is the input weight
  abline(v = weight, lwd = 2, col = "navy")
  #The following lines are weights that correspond to the limit values, to give some
  #visual aid. Makes it easier to determine your category visually.
  abline(v = limits[1], lty = 2, lwd = 1.5, col = "yellow") 
  abline(v = limits[2], lty = 2, lwd = 1.5, col = "orange")    
  abline(v = limits[3], lty = 2, lwd = 1.5, col = "red")
  #Add text in the plot
  text(x = c(17, (limits + 1)), 
       y = c(max(y)*.85, max(y)*.89, max(y)*.95, max(y)), 
       adj = c(0, 1), 
       labels = c("Underweight", "Normal weight", "Overweight", "Obese"))
}

#This function uses the limits calculated earlier to assign you to one of the
#four classes 
determine.class <- function(weight, limits) {
  if (weight < limits[1]) return("underweight")
  if (weight >= limits [1] && weight <= limits[2]) return("normal weight")
  if (weight > limits [2] && weight <= limits[3]) return("overweight")
  if (weight > limits[3]) return("obese")
}

shinyServer(
  function(input, output) {
    #This is to show the values you put in
    output$height <- renderPrint({input$height})
    output$weight <- renderPrint({input$weight})
    #Calculated BMI
    output$bmi <- renderPrint({calcbmi(input$height, input$weight)})
    #Calculates the weights corresponding to the BMI limits for the give height
    limits <- reactive({calclimits(input$height)})
    #Create the BMI plot for the given height and weight
    output$bmiplot <- renderPlot({plotbmi(input$height, input$weight, limits(), x)})
    #Show the category you fall in to with this height and weight
    class <- reactive({determine.class(input$weight, limits())})
    output$yourclass <- renderText({paste0("With this height and weight, you are ", class(), ".")})
  }
)


