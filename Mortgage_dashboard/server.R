library(shiny)
library(shinydashboard)
library(ggplot2)
library(scales)

base1 <- fread("~/Documents/shiny apps/Dashboard_test/base1.csv")
base1 <- as.data.frame(base1)
sa <- sort(unique(base1$SITUACION_AMORTIZACION))
rg <- sort(unique(base1$REGIMEN))
tp <- sort(unique(base1$IN_CEDIDA))

server <- function(input, output) {
        output$saControl <- renderUI({checkboxGroupInput('sa', 'Amortization status', sa, selected = sa)})
        
        output$rgControl <- renderUI({checkboxGroupInput('rg', 'Regimen', rg, selected = rg)})
        
        output$tpControl <- renderUI({checkboxGroupInput('tp', 'Regimen', tp, selected = tp)})

        output$plot1 <- renderPlot({
                data <- subset(base1, COSECHA >= input$slider[1] & COSECHA <= input$slider[2]
                               & SITUACION_AMORTIZACION %in% input$sa
                               & REGIMEN %in% input$rg
                               & IN_CEDIDA %in% input$tp
                               )
                data <- summarise(group_by(data, COSECHA), N =  sum(N, na.rm = TRUE))
                ggplot(data, aes(COSECHA, N)) +
                        geom_line(colour = "steelblue", stat = "identity") +
                        geom_point(colour = "black", size=2, shape=1) +
                        theme_bw() +
                        theme(legend.position = "bottom"
                              , title = element_text(size = 12)
                              , axis.text = element_text(size = 10)) +
                        scale_y_continuous(labels = comma) +
                        labs(title = "Mortgages\n", x = "", y = "")
        })
        
        output$plot2 <- renderPlot({
                data <- subset(base1, COSECHA >= input$slider[1] & COSECHA <= input$slider[2]
                               & SITUACION_AMORTIZACION %in% input$sa
                               & REGIMEN %in% input$rg
                               & IN_CEDIDA %in% input$tp
                               )
                ggplot(data, aes(COSECHA, SALDO_TOTAL/1e6)) +
                        geom_bar(fill = "steelblue1", stat = "identity") +
                        theme_bw() +
                        theme(legend.position = "bottom"
                              , title = element_text(size = 12)
                              , axis.text = element_text(size = 10)) +
                        scale_y_continuous(labels = dollar) +
                        labs(title = "Current value (Millions MXP)\n", x = "", y = "")
        })
        
        output$summary1 <- renderText({
                data <- subset(base1, COSECHA >= input$slider[1] & COSECHA <= input$slider[2]
                               & SITUACION_AMORTIZACION %in% input$sa
                               & REGIMEN %in% input$rg
                               & IN_CEDIDA %in% input$tp
                               )
                comma(sum(data$N))
        })
        
        output$summary2 <- renderText({
                data <- subset(base1, COSECHA >= input$slider[1] & COSECHA <= input$slider[2]
                               & SITUACION_AMORTIZACION %in% input$sa
                               & REGIMEN %in% input$rg
                               & IN_CEDIDA %in% input$tp
                               )
                dollar(sum(data$SALDO_TOTAL/1e6))
                
        })
}

