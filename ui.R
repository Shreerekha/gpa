# UI.R for the GPA App
library(shiny)
shinyUI(
    pageWithSidebar(
        headerPanel("College GPA Prediction"),
        sidebarPanel(
            h3("Inputs"),
            sliderInput("hsgpa", "High School GPA", min = 0.00, max = 4.00, value =2.00,step = 0.01),
            sliderInput('satscore','Total SAT Score', min =600, max = 2400, value =1500,step=10),
            textInput("university", "University/College", value=NULL),
            radioButtons("plots", "Choose Plots", c("Map" = "option1", "Histogram" = "option2"),
                               selected = NULL),
                
            actionButton("goButton", "Go!"), 
            h3("How to use the app"),
            # Brief Directions for using App provided on the App page itself. Detailed Readme is also on Shiny Server in the link below.
            helpText(HTML("The app predicts your college GPA based on High School GPA and Total SAT score(Reading+ Writing+ Math=2400).<br/>1. Move sliders to your High School GPA and Total SAT score.<br/>2. Enter the name of university/college.<br/>3. Select the type of plot you wish to see.<br/>4. Press the Go! Button.<br/>Your college GPA is predicted and displayed.If you choose 'Map', a categorical map of the GPAs of 140 US colleges is displayed,along with your predicted GPA. If you choose 'Histogram', you get the histogram of GPAs. The plots show the average GPA of graduating students of all majors in each college for the year 2006. You can compare your predicted performance against the actual GPAs on the map.<br/>Note:<br/><strong>Changes made to the input variables are not reflected in the results unless the Go! Button is clicked.</strong><br/>The University/College input is used only for display,not for the prediction model.<br/>A ReadMe file with more details is given in the link below.")),
            p("ReadMe:",a("gpa",href="GPAReadMe.html")) # ReadMe file on Shiny Server
            ),
        mainPanel(
                          
            h3('Results'),
            h4('Your HS GPA'),
            verbatimTextOutput("inputValue1"),
            h4('Your Total SAT Score'),
            verbatimTextOutput("inputValue2"),
            h4("Your University"),
            verbatimTextOutput("inputValue3"),
            h4('Your Predicted College GPA'),
            verbatimTextOutput("prediction"),
            plotOutput('gpaPlot'),
            plotOutput('myHist')
            )
        )
    )