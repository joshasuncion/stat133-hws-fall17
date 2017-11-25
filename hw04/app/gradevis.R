# load required libraries
library("shiny")
library("ggvis")

#
source("../code/functions.R")

#
scores <- read.csv("../data/cleandata/cleanscores.csv")

#
scores$Grade <- factor(scores$Grade,
                       levels = c('A+', 'A', 'A-', 'B+', 'B', 'B-',
                                  'C+', 'C', 'C-', 'D', 'F'))

#
freq <- table(Grade = scores$Grade)
prop <- round(prop.table(freq), 2)
grade_table <- data.frame(freq, Prop = as.numeric(prop))

#
continuous <- colnames(scores)[1:22]

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # application title
   titlePanel("Grade Visualizer"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        conditionalPanel(condition = "input.tabselected==1",
                         h3("Grades Distribution"),
                         tableOutput("table")),
        conditionalPanel(condition = "input.tabselected==2",
                         selectInput("hist_var", "X-axis variable",
                                     continuous, selected = "HW1"),
                         sliderInput("bins", "Bin Width",
                                     min = 1,
                                     max = 10,
                                     value = 1))
        #conditionalPanel(condition = "input.tabselected==3",
        #                 selectInput("var2", "X-axis variable",
        #                             continuous, selected = "Test1"),
        #                 selectInput("var3", "Y-axis varibale",
        #                             continuous, selected = "Overall"),
        #                 sliderInput("opacity", "Opacity",
        #                             min = 0,
        #                             max = 1,
        #                             value = 0.1),
        #                 radioButtons("line", h3("Show line"),
        #                              list("none" = 1,
        #                                   "lm" = 2,
        #                                   "loess" = 3),
        #                              selected = 1))
        ),
      
      # Show a plot of the generated distribution
      mainPanel(
         tabsetPanel(type = "tabs",
                     tabPanel("Barchart", value = 1,
                              ggvisOutput("barchart")),
                     tabPanel("Histogram", value = 2,
                              ggvisOutput("histogram"),
                              
                              h4("Summary Statistics"),
                              verbatimTextOutput("summary")),
                     
                     tabPanel("Scatterplot", value = 3,
                              ggvisOutput("scatterplot")),
                     id = "tabselected"))
      )
   )

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  #
  vis_barchart <- reactive({
    scores %>%
      ggvis(x = ~Grade, fill := "#3b9bef") %>% 
      layer_bars(stroke := '#3b9bef', width = 0.9,
                 fillOpacity := 0.8, fillOpacity.hover := 1) %>%
      add_axis("y", title = "frequency")
  })
  vis_barchart %>% bind_shiny("barchart")
  
  #
  output$table <- renderTable({
    grade_table
  })
  
  # Histogram (for 2nd tab)
  vis_histogram <- reactive({
    
    # Normally we could do something like ggvis(x = ~mpg),
    # but since the inputs are strings, we need to do a little more work.
    hist_var <- prop("x", as.symbol(input$hist_var))
    
    scores %>% 
      ggvis(x = hist_var, fill := "#abafb5") %>% 
      layer_histograms(stroke := 'white', width = input$bins)
  })
  vis_histogram %>% bind_shiny("histogram")
  
  #
  output$summary <- renderPrint({
    hist_var <- input$hist_var
    print_stats(summary_stats(scores[ , hist_var]))
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
