
#server.R file for GPA App
# Prediction Equation for College GPA
    colgpa <- function(hsgpa,satscore) round((0.23+0.52*hsgpa+.002*satscore/3),2)
# Read data file. This is in the same directory as server.R
    gpa <- read.csv("gpa.csv")

# Load Libraries
    library(ggmap)
    library(ggplot2)
    library(maps)
    
# Get The States Map data
    all_states <- map_data("state")
    
# Identify and Store observations with the highest and lowest GPA
    maxim <-gpa[which.max(gpa$gpa),]
    mini <-gpa[which.min(gpa$gpa),]

# Save GPA data for making the histogram
    dhist<-gpa$gpa
shinyServer(
    function(input, output){
                
            output$inputValue1 <- renderPrint({
                if(input$goButton!=0){
                input$goButton
                isolate({input$hsgpa})
                }
                })
            
            output$inputValue2 <- renderPrint({
                if(input$goButton!=0){
                input$goButton
                isolate({input$satscore})
                }
                })
                
            output$inputValue3 <- renderPrint({
                
                    if(input$goButton!=0){
                    input$goButton
                    isolate({input$university})
                    }
                })
                      
            output$prediction <- renderPrint({
                
                if(input$goButton!=0){
                input$goButton
                isolate({colgpa(input$hsgpa,input$satscore)})
                }
                })
                   
            output$gpaPlot <- renderPlot({
                if(input$goButton !=0){
                    if(isolate(input$plots)=="option1"){
                    # Plot the Map
                        label1<-  reactive({paste("Your Predicted",isolate(input$university),"GPA:", colgpa(isolate(input$hsgpa),isolate(input$satscore)))})
                        lab2 <-paste("Highest GPA:",maxim$college, maxim$gpa)
                        lab3 <-paste("Lowest GPA:",mini$college, mini$gpa)
                        p <- ggplot(environment=environment())
                        p <- p + geom_polygon( data=all_states, aes(x=long, y=lat, group = group),colour="white" )
                        p <- p + geom_jitter( data=gpa, position=position_jitter(width=0.5, height=0.5), aes(x=lon, y=lat, size = gpa), fill="lightblue",color="black",pch=22) + scale_size(name="GPA")
                        p <- p + geom_text( data=gpa, hjust=0.5, vjst=-0.5, aes(x=lon, y=lat, label=label), colour="red", size=3 )
                        p <- p+  annotate("text", label =label1(), hjust =0.3, x=-115, y = 20, color="red", size=4.5)
                        p <- p+  annotate("text", label =lab2, hjust=0.3, x = -115, y = 24, color="black", size=4)
                        p <- p+  annotate("text", label =lab3, hjust=0.3, x = -115, y = 22, color="black", size=4)
                        p <- p +labs(title = "Map of College GPAs of 140 U.S. Universities/Colleges-2006 data") 
                        p <- p + labs(x ="Longitude", y ="Latitude") 
                        p <- p+coord_map("gilbert")
                        print(p)
                    }
                    if(isolate(input$plots)== "option2"){
                    # Plot Histogram
                        hist(dhist, xlab='GPA', col='light blue',main='Histogram of GPA of 140 US Colleges/Universities- 2006 data', xlim = c(2,4))
                        label1<-  reactive({paste("Your Predicted",isolate(input$university),"GPA:", colgpa(isolate(input$hsgpa),isolate(input$satscore)))})
                        you <-  reactive({colgpa(isolate(input$hsgpa),isolate(input$satscore))})
                        lines(c(you(),you()), c(0,24),col="red",lwd=5)
                        text(3.5, 27, paste(label1()), col ="dark blue")
                        text(you(),25, paste("You"),col="dark blue")
                    }
                
                }
            })
       })
   