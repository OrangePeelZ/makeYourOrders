
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output, session) {
  preOrderDF <- reactiveValues()
  preOrderDF$df = data.frame(Food = character(), 
                          Size = character(), 
                          Price = numeric(), 
                          name = character(), 
                          foodSize = character(),
                          Quantity = integer(),
                          subtotal = numeric(), 
                          stringsAsFactors=FALSE)
  observe({
    validate(
      shiny::need(menu,"Fetching data")
    )
    updateSelectInput(session, "Category",
                      choices = cbind("", unique(as.character(menu$name))))
    
  })
  
  df0 <- reactive({
    withProgress(message = 'Loading Data', {
      subset(menu, name %in% input$Category)
    })
  })
  
  output$Item <- renderUI({
    if (is.null(df0()$Food))
      return(NULL)
    fd <- cbind("", unique(df0()$Food))
    selectInput(inputId = "Food", 
                label = "Food", 
                choices = fd, 
                selected = NULL, 
                multiple = FALSE, 
                selectize = TRUE)
  })
  
  df1 <- reactive({
    withProgress(message = 'Loading Data', {
      subset(df0(), Food %in% input$Food)
    })
  })
  
output$Size <- renderUI({
    if (is.null(df1()$Size))
      return(NULL)
    sz <- cbind("",unique(df1()$Size))
    st = NULL
    if (length(sz) == 1){st = sz}
    selectInput(inputId = "Size", 
                "Size", 
                sz, 
                selected = st, 
                multiple = FALSE, 
                selectize = TRUE, 
                width = NULL, 
                size = NULL)
  })

  df2 <- reactive({
    withProgress(message = 'Loading Data', {
      validate(
        need(nrow(df1()) > 0 & !is.null(df1()) &!is.na(df1()), "waiting for your select" )
      )
      if (input$Size != "" | !is.null(input$Size)){
        subset(df1(), Size %in% input$Size) %>%
          mutate(foodSize = paste0(Food, ' ', Size))
      } else df1()%>%mutate(foodSize = paste0(Food, ' ', Size))
    })
  })
  
  

  
  observeEvent(input$Add, {
  
    validate(
      need(nrow(df2()) > 0 & !is.null(df2()) &!is.na(df2()), "")
    )
    newLines =  subset(isolate(df2()), Size %in% input$Size)%>%
      mutate(Quantity = input$Quantity) %>%
      mutate(subtotal = Quantity*Price ) 
    
    preOrderDF$df = preOrderDF$df %>% 
      bind_rows(newLines)
    
    updateSelectInput(session, 
                      "delete",
                      choices =c("",unique(as.character(preOrderDF$df$foodSize))),
                      selected =c("", unique(as.character(preOrderDF$df$foodSize))))
    
    updateSelectInput(session, inputId = "Category", 
                      selected = '')
    updateSelectInput(session, inputId = "Food",
                      selected = '')
    updateSelectInput(session, inputId = "Size", 
                      selected = '')
    updateNumericInput(session , inputId = "Quantity",  value = 1, min = 1, max = 100)
    
    
    
  })
  
  
  observeEvent(input$delete1, {
    validate(
      shiny::need(nrow(preOrderDF$df) > 0
                  ,"Fetching data")
      # need(!is.null(input$delete), "")
    )
# 
#     
#     print(input$delete)
#     print(preOrderDF$df)
#     
    preOrderDF$df = subset(preOrderDF$df, foodSize%in%input$delete)
    
    
  })
  
  preOrder_final = reactive({
    preOrderDF$df
  })

  
  output$preorderTable <- renderDataTable({
    preOrder_final()[, c("Food", "Size", "name", "Price", "Quantity", "subtotal")]
  })
  
  output$reviewTable <- renderDataTable({
    preOrder_final()[, c("Food", "Size", "name", "Price", "Quantity", "subtotal")]
  })
  
  output$preOrder_total <- renderText({
    # total = sum(preOrder_final()$subtotal)
    paste0("Your total is: $", sum(preOrder_final()$subtotal))
  })

  output$preOrder_total2 <- renderText({
    # total = sum(preOrder_final()$subtotal)
    paste0("Your total is: $", sum(preOrder_final()$subtotal))
  })
  
  output$orderStatus <- renderDataTable({
    ## implement status here
    preOrder_final()[, c("Food", "Size", "name", "Price", "Quantity", "subtotal")]
  })
  
  output$preOrder_total3 <- renderText({
    # total = sum(preOrder_final()$subtotal)
    paste0("Your total is: $", sum(preOrder_final()$subtotal))
  })
  
  observe({
    validate(
      shiny::need(nrow(preOrder_final()) > 0
                  ,"Fetching data"))
    # print()
    updateCheckboxGroupInput(session,inputId = 'applyCancel', choices = preOrder_final()$foodSize)
  })
  

})
