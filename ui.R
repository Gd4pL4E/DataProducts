library(shiny)
shinyUI(pageWithSidebar(
  headerPanel(
    h1("A simple Shiny app: calculate BMI")
  ),
  sidebarPanel(
    h2("Measurements"),
    #Sliders are used to give your weight height and weight in cm and kg respectively
    sliderInput("height", "Height (cm)", value = 170, min = 140, max = 200, step = 1),
    sliderInput("weight", "Weight (kg)", value = 70, min = 20, max = 120, step = 1),
    h2("Documentation"),
    #A little bit of explanation about BMI
    p("The body mass index (BMI) is a value derived from the mass (weight) and height 
      of an individual.The BMI is an attempt to quantify the amount of tissue mass 
      (muscle, fat, and bone) in an individual, and then categorize that person as 
      underweight, normal weight, overweight, or obese based on that value."),
    a(href="https://en.wikipedia.org/wiki/Body_mass_index", "Source"),
    hr(),
    #Explanation about this Shiny App
    p("Give the height and weight of the person using the sliders under the
      Measurements section. In the main panel the calculated BMI is given including
      which weight category you fall in. A plot is shown with the weight on the
      x-axis and BMI on the y-axis to make it easier to visually determine what
      weight category one falls in."),
    hr(),
    p("By Fabian van Beveren"),
    p("For the Coursera course 'Data Products', 2016.")
  ),
  mainPanel(
    #Input values
    h2("Input values"),
    p("Height"),
    verbatimTextOutput("height"),
    p("Weight"),
    verbatimTextOutput("weight"),
    
    #This reports your BMI value, and what category you belong to
    h2("Calculated BMI"),
    verbatimTextOutput("bmi"),
    textOutput('yourclass'),
    
    #The plot
    h2("BMI plot"),
    plotOutput("bmiplot")
  )
))