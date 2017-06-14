
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shinydashboard)
library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("McDonald's Online Order"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      wellPanel(selectInput(inputId = "Category", 
                               label = "Category", 
                               choices= NULL, 
                               selected = NULL, 
                               multiple = FALSE)),
      wellPanel(uiOutput("Item")),
      wellPanel(uiOutput("Size")),
      wellPanel(numericInput("Quantity", "Quantity:", 1, min = 1, max = 100)),
      actionButton("Add","Add"),
      width = 4
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel('Select Your Food',
 
                 fluidRow(
                   column(8,
                          # div(style = "height:0px;"),
                          selectInput(inputId = "delete", 
                                        label = "Delete Item", 
                                        choices= NULL, 
                                        multiple = TRUE,
                                        selected = NULL)),
                   
                   column(2, 
                          div(style = "height:30px;"),
                          actionButton("delete1", "Apply Change")),
                   hr(),
                   
                   column(12, dataTableOutput("preorderTable")),
                   column(8, shinydashboard::box(
                     textOutput("preOrder_total"),
                     class = "information",
                     width = 6,
                     status = "success",
                     solidHeader = TRUE,
                     collapsible = F
                   ))
                   
                   # column(2, actionButton("delete1", "Apply Change"))
                  )
          ),
        tabPanel('Review Your Order',
                 fluidRow(
                   dataTableOutput('reviewTable'),
                   column(8, textOutput("preOrder_total2")),
                   column(2, actionButton("submit2", "Submit Order", icon = icon("hand-peace-o")))
                 )
        ),
        tabPanel('Order Status & Order Cancellation',
                 dataTableOutput('orderStatus'),
                 textOutput("preOrder_total3"),
                 hr(),
                 shinydashboard::box(checkboxGroupInput(inputId = 'applyCancel', 
                                    label = "", choices = ""),
                                    title = "Cancel Order",
                                    status = "warning",
                                    column = 12),
                 actionButton("cancel", "Apply for Cancellation")
        )
        )
    )
  )
)
)

