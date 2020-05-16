library(tidyverse)
library(MonteCarlo)
library(ggplot2)
library(pbapply)
library(scales)
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    observeEvent(input$additional_attacker, {}, ignoreNULL = FALSE)
    
    
    runSimulation <- reactive({
        print(getwd())
        source('code/objects.R', local = TRUE)
        source('code/functions.R', local = TRUE)
        
        # Check if proven should apply
        proven = 0
        if ('proven' %in% input$additional_attacker) proven = input$proven_
        
        attacker <- makeAttacker(
            bs = input$BS_,
            damageDie = input$damageDie_,
            damageModifier = input$damageModifier_,
            penetration = input$penetration_,
            rateOfFire = input$rateOfFire_,
            firingMode = input$firingMode,
            isTearing = 'tearing' %in% input$additional_attacker,
            proven = proven
        )
        
        defender <- makeDefender(
            t = input$T_,
            wounds = input$wounds_,
            armour = input$armour_,
            dodge = input$dodge_,
            forceField = input$forceField_,
            forceFieldOverload = input$forceFieldOverload_,
            isForceFieldOverloaded = 0
        )
        
        simulation <- replicate(input$nReps_, singleAttack()) %>%
            as_tibble()
        
        if( !input$showMisses_ ) simulation <- simulation %>% filter(value > 0)
        
        return(simulation)
    })
    
    output$damagePlot <- renderPlot({
        simulation <- runSimulation()
        
        simulation %>%
            ggplot(aes(x = as.factor(value))) +
            geom_bar(
                aes(y = (..count..)/sum(..count..)),
                fill = '#378CC7') +
            geom_text(
                aes(y = ((..count..)/sum(..count..)),
                    label = percent((..count..)/sum(..count..), 1)),
                stat = "count",
                vjust = -0.75) +
            scale_y_continuous(labels = percent) +
            labs(x = 'Damage to target', y = 'Probability')
    })
    
    output$damagePlotCumulated <- renderPlot({
        simulation <- runSimulation()
        
        simulation <- simulation %>%
            table(dnn = list('x')) %>%
            as_tibble() %>% 
            mutate(cumsum = lag( 1 - cumsum(n) / sum(n), default = 1 ), x = as.integer(x) ) 
        
        simulation %>%
            ggplot(aes(x = as.factor(x),
                       fill = factor(ifelse(simulation$x == input$wounds_, 'Wounds', 'Other')))) +
            geom_bar(
                aes(y = cumsum), 
                stat = 'identity',
                show.legend = FALSE) +
            geom_text(
                aes(y = cumsum),
                label = percent(simulation$cumsum, 1),
                vjust = -0.75) + 
            geom_hline(aes(yintercept = 0.5), color = 'red', alpha = 0.5) +
            scale_y_continuous(labels = percent) +
            scale_fill_manual(name = "area", values=c("#378CC7","#FADA5E")) +
            labs(x = 'Damage to target', y = 'Probability of dealing at least this much damage')
    })
    
})
