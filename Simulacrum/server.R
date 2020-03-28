library(tidyverse)
library(MonteCarlo)
library(ggplot2)
library(pbapply)
library(scales)

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    
    output$damagePlot <- renderPlot({
        print(getwd())
        source('code/objects.R', local = TRUE)
        source('code/functions.R', local = TRUE)
        
        attacker <- makeAttacker(
            bs = input$BS_,
            damageDie = input$damageDie_,
            damageModifier = input$damageModifier_,
            penetration = input$penetration_,
            rateOfFire = input$rateOfFire_,
            firingMode = input$firingMode,
            isTearing = 'tearing' %in% input$additional_attacker
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
    
})
