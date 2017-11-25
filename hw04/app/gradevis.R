# load required libraries
library("shiny")
library("ggvis")

# source in functions
source("../code/functions.R")

# read in "cleanscores.csv"
scores <- read.csv("../data/cleandata/cleanscores.csv")

# convert letter grades to factors to order them
scores$Grade <- factor(scores$Grade,
                       levels = c('A+', 'A', 'A-', 'B+', 'B', 'B-',
                                  'C+', 'C', 'C-', 'D', 'F'))

# create table of frequency and proportion of letter grades
freq <- table(Grade = scores$Grade)
prop <- round(prop.table(freq), 2)
grade_table <- data.frame(freq, Prop = as.numeric(prop))

# create vector of each column excluding grade
continuous <- colnames(scores)[1:22]

# define UI for application
ui <- fluidPage(
   
   # application title
   titlePanel("Grade Visualizer"),
   
   # sidebar with conditional panels for multiple tabs
   sidebarLayout(
      sidebarPanel(
        
        # first tab
        conditionalPanel(condition = "input.tabselected==1",
                         h3("Grades Distribution"),
                         tableOutput("table")),
        
        # second tab
        conditionalPanel(condition = "input.tabselected==2",
                         selectInput("hist_var", "X-axis variable",
                                     continuous, selected = "HW1"),
                         sliderInput("bins", "Bin Width",
                                     min = 1,
                                     max = 10,
                                     value = 1)),
        
        # third tab
        conditionalPanel(condition = "input.tabselected==3",
                         selectInput("x_var", "X-axis variable",
                                     continuous, selected = "Test1"),
                         selectInput("y_var", "Y-axis variable",
                                     continuous, selected = "Overall"),
                         sliderInput("opacity", "Opacity",
                                     min = 0,
                                     max = 1,
                                     value = 0.1)
                         #radioButtons("line", h3("Show line"),
                         #             list("none" = 1,
                         #                  "lm" = 2,
                         #                  "loess" = 3),
                         #             selected = 1)
                         )
        ),
      
      # show outputs for each tab
      mainPanel(
         tabsetPanel(type = "tabs",
                     
                     # first tab
                     tabPanel("Barchart", value = 1,
                              ggvisOutput("barchart")),
                     
                     # second tab
                     tabPanel("Histogram", value = 2,
                              ggvisOutput("histogram"),
                              
                              # show text of summary statistics
                              h4("Summary Statistics"),
                              verbatimTextOutput("summary")),
                     
                     # third tab
                     tabPanel("Scatterplot", value = 3,
                              ggvisOutput("scatterplot"),
                              
                              # show text of correlation
                              h4("Correlation:"),
                              verbatimTextOutput("correlation")),
                     
                     id = "tabselected"))
      )
   )

# define server logic
server <- function(input, output) {
  
  # barchart (for first tab)
  vis_barchart <- reactive({
    scores %>%
      ggvis(x = ~Grade, fill := "#3b9bef") %>%
      layer_bars(stroke := '#3b9bef', width = 0.9,
                 fillOpacity := 0.8, fillOpacity.hover := 1) %>%
      add_axis("y", title = "frequency")
  })
  vis_barchart %>% bind_shiny("barchart")
  
  # grades distribution table (for first tab)
  output$table <- renderTable({
    grade_table
  })
  
  # histogram (for second tab)
  vis_histogram <- reactive({
    
    # convert input from string to symbol
    hist_var <- prop("x", as.symbol(input$hist_var))
    
    scores %>% 
      ggvis(x = hist_var, fill := "#abafb5") %>% 
      layer_histograms(stroke := 'white', width = input$bins)
  })
  vis_histogram %>% bind_shiny("histogram")
  
  # summary statistics (for second tab)
  output$summary <- renderPrint({
    hist_var <- input$hist_var
    print_stats(summary_stats(scores[ , hist_var]))
  })
  
  # scatterplot (for third tab)
  vis_scatterplot <- reactive({
    
    # convert input from string to symbol
    x_var <- prop("x", as.symbol(input$x_var))
    y_var <- prop("y", as.symbol(input$y_var))
    
    scores %>%
      ggvis(x = x_var, y = y_var, opacity = input$opacity) %>%
      layer_points()
  })
  vis_scatterplot %>% bind_shiny("scatterplot")
  
  # correlation (for third tab)
  output$correlation <- renderPrint({
    x_var <- input$x_var
    y_var <- input$y_var
    cor(x_var, y_var)
  })
}

# run the application 
shinyApp(ui = ui, server = server)
