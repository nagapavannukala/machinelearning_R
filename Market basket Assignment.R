
rm(list = ls())
setwd ("C:/Users/nagapavan/Desktop/great lakes/R/classroom")
getwd()

MARKET_BASKET_ANALYSIS <- read.csv("MARKET_BASKET_ANALYSIS.csv")
data = MARKET_BASKET_ANALYSIS



data$Item_Desc[data$Item_Desc == "Saintary Pads"] = "Sanitary Pads"

 data$Item_Desc[data$Item_Desc =='Aerated Drinks' ] = 'Beverages'
 data$Item_Desc[data$Item_Desc =='Pepsi' ] = 'Beverages'
 data$Item_Desc[data$Item_Desc =='Incense Sticks'] = 'Agarbatties'
 
 
 
 data$Item_Desc[data$Item_Desc =='Plain Biscuits'] =  'Biscuits'
 
 data$Item_Desc[data$Item_Desc =='Branded Cakes'] =  'Cakes'
 data$Item_Desc[data$Item_Desc =='PASTRIES'] =  'Cakes'
 data$Item_Desc[data$Item_Desc =='Plain Dahi'] ='Dahi'
 data$Item_Desc[data$Item_Desc =='Regular Eggs' ] = 'Eggs'
 data$Item_Desc[data$Item_Desc == 'Block Games' ] =  'Games'
 data$Item_Desc[data$Item_Desc =='Puzzle Games' ] =  'Games'
 
 data$Item_Desc[data$Item_Desc =='Remote Controlled Games' ] =  'Games'
 data$Item_Desc[data$Item_Desc =='Bed Sheets' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Dinner Set' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Disposable Ware' ] ='Household'
 data$Item_Desc[data$Item_Desc =='Fridge Bottles' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Frying Pan' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Hand Blender' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Hand Towel' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Handicrafts' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Hangers' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Household Needs' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Indian Confectionery' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Infant Formula' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Inflatables' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Ironing Boards' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Irons' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Jars' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Jars / Dabbas' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Kitchenware' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Knife' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Laundry Bag' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Laundry Basket' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Laundry' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Lighter' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Liquid Detergents' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Local Confectionery' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Living Room Accessories' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Magazines' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Mats' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Measure Tapes' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Paper Napkins' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Photo Frames' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Plastic Bag' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Pressure Cooker' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Rugs' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Utensils' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Water Bottle' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Water Can' ] =  'Household'
 data$Item_Desc[data$Item_Desc =='Dupatta' ] =  'Ladies Tops'
 data$Item_Desc[data$Item_Desc =='Ladies Casuals' ] =  'Ladies Tops'
 data$Item_Desc[data$Item_Desc =='Ladies Stole' ] =  'Ladies Tops'
 data$Item_Desc[data$Item_Desc =='Ladies TShirts' ] =  'Ladies Tops'
 data$Item_Desc[data$Item_Desc =='Mosquito Repeller' ] =  'Mosquito Repellant'
 data$Item_Desc[data$Item_Desc =='Boiled Rice'] =  'Rice'
 data$Item_Desc[data$Item_Desc =='Salad Dressings'] =  'Sauces & Salad Dressing'
 ################
 data$Item_Desc[data$Item_Desc == 'Auto Accessories'] = 'Automobile'
 data$Item_Desc[data$Item_Desc =="Plugs/Sockers"]='Automobile'
 data$Item_Desc[data$Item_Desc =='Peripheral'= 'Automobile'
 data$Item_Desc[data$Item_Desc =='Baby Grooming'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Baby Care'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Baby Lotion'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Face Care'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Face Packs'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Facical Tissues'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Fairness Whitening'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Hair Care'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Hair Creams'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Hair Dye'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Hair Gel'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Hair Oil'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Hair Bags'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Hand Bags'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Hand Wash'] =  'Health'
 data$Item_Desc[data$Item_Desc =='Ladies Hair Accessories'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Lip Care'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Soaps'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Mens Fragrances'] =  'Cosmetics'
 data$Item_Desc[data$Item_Desc =='Ladies Flip Flops' ] ='Footwear'
 data$Item_Desc[data$Item_Desc =='Ladies Sleepers' ] ='Footwear'
 data$Item_Desc[data$Item_Desc =='Mens Flip Flops' ] =  'Footwear'
 data$Item_Desc[data$Item_Desc =='Mens Shoes' ] =  'Footwear'
 data$Item_Desc[data$Item_Desc =='Mens Deos' ] ='Fragrance'
 data$Item_Desc[data$Item_Desc =='Room Fresheners' ] ='Fragrance'
data$Item_Desc[data$Item_Desc =='Frozen Chicken']='Frozen Non Veg'
data$Item_Desc[data$Item_Desc =='Frozen Fish']='Frozen Non Veg'
data$Item_Desc[data$Item_Desc =='Frozen Pork'] ='Frozen Non Veg'
data$Item_Desc[data$Item_Desc =='Frozen Parathas']='Frozen Veg'
data$Item_Desc[data$Item_Desc =='Frozen Peas' ] ='Frozen Veg'
data$Item_Desc[data$Item_Desc =='Frozen Pizza'] ='Frozen Veg'
data$Item_Desc[data$Item_Desc =='Frozen Starers'] ='Frozen Veg'
data$Item_Desc[data$Item_Desc =='Frozen Vegetables']='Frozen Veg'
data$Item_Desc[data$Item_Desc =='Frozen Veg' ] ='Frozen Veg'
 data$Item_Desc[data$Item_Desc =='Apple' ] =  'Fruits'
 data$Item_Desc[data$Item_Desc =='Banana' ] =  'Fruits'
 data$Item_Desc[data$Item_Desc =='Berries' ] =  'Fruits'
 data$Item_Desc[data$Item_Desc =='Canned Fruits' ] =  'Fruits'
data$Item_Desc[data$Item_Desc =='Fruits Juices' ] =  'Fruits'
 data$Item_Desc[data$Item_Desc =='Fruits Salads' ] =  'Fruits'
 data$Item_Desc[data$Item_Desc =='Imported Fruits' ] =  'Fruits'
 data$Item_Desc[data$Item_Desc =='Juices' ] =  'Fruits'
 data$Item_Desc[data$Item_Desc =='Mangoes' ] =  'Fruits'
 data$Item_Desc[data$Item_Desc =='Melons' ] =  'Fruits'
 data$Item_Desc[data$Item_Desc =='Organic Fruits' ] =  'Fruits'
data$Item_Desc[data$Item_Desc =='Papaya' ] =  'Fruits'
 data$Item_Desc[data$Item_Desc =='Pomogranate' ] =  'Fruits'
 data$Item_Desc[data$Item_Desc =='Multipurpose Gift Pack'] =  'Gift'
 data$Item_Desc[data$Item_Desc =='Antiseptic Liquid' ] =  'Health'
 data$Item_Desc[data$Item_Desc =='Exercise Accessories' ] =  'Health'
 data$Item_Desc[data$Item_Desc =='Hand Sanitizers' ] =  'Health'
 data$Item_Desc[data$Item_Desc =='Hand Formulas' ] =  'Health'
 data$Item_Desc[data$Item_Desc =='Hand Supplements' ] =  'Health'
 data$Item_Desc[data$Item_Desc =='HealthSnacks' ] =  'Health'
 data$Item_Desc[data$Item_Desc =='Mouthwash' ] =  'Health'
 data$Item_Desc[data$Item_Desc =='Oats' ] =  'Health'
 data$Item_Desc[data$Item_Desc =='Oral Care Aids' ] = 'Health'
 data$Item_Desc[data$Item_Desc =='Saintary Pads' ] =  'Health'
 data$Item_Desc[data$Item_Desc =='Saintary Ware' ] =  'Health'
 data$Item_Desc[data$Item_Desc =='Ice Bucket' ] =  'Ice Cream'
 data$Item_Desc[data$Item_Desc =='Ice Cream Scoop' ] =  'Ice Cream'
 data$Item_Desc[data$Item_Desc =='Icecream Family Pack' ] =  'Ice Cream'
 data$Item_Desc[data$Item_Desc =='Instant Coffee ' ] =  'Instant Food'
 data$Item_Desc[data$Item_Desc =='Instant Cup Noodles' ] =  'Instant Food'
 data$Item_Desc[data$Item_Desc =='Instant Mixes' ] =  'Instant Food'
 data$Item_Desc[data$Item_Desc =='Jams & Spreads' ] =  'Instant Food'
 data$Item_Desc[data$Item_Desc =='Jams Marmalade' ] =  'Instant Food'
 data$Item_Desc[data$Item_Desc =='Jellies Gelatin' ] =  'Instant Food'
 data$Item_Desc[data$Item_Desc =='Noodles' ] =  'Instant Food'
 data$Item_Desc[data$Item_Desc =='Pasta' ] =  'Instant Food'
 data$Item_Desc[data$Item_Desc =='Pastas' ] =  'Instant Food'
 data$Item_Desc[data$Item_Desc =='PeanutButter' ] =  'Instant Food'
 data$Item_Desc[data$Item_Desc =='Poha' ] =  'Instant Food'
 data$Item_Desc[data$Item_Desc =='Potato Chips' ] =  'Instant Food'
 data$Item_Desc[data$Item_Desc =='Premium Cakes' ] =  'Instant Food'
 data$Item_Desc[data$Item_Desc =='Ready to Eat Food' ] =  'Instant Food'
 data$Item_Desc[data$Item_Desc =='Salted Chips' ] =  'Instant Food'
 data$Item_Desc[data$Item_Desc =='Ladies Pyjama' ] =  'Ladies Bottom'
 data$Item_Desc[data$Item_Desc =='Panties' ] =  'Ladies Bottom'
 data$Item_Desc[data$Item_Desc =='Ladies Basic Denim' ] =  'Ladies Bottom'
data$Item_Desc[data$Item_Desc =='Mens Denim' ] =  'Men Tops'
 data$Item_Desc[data$Item_Desc =='Mens Pyjama' ] =  'Men Tops'
 data$Item_Desc[data$Item_Desc =='Mens Trousers' ] =  'Men Tops'
 data$Item_Desc[data$Item_Desc =='Mens Trunks' ] =  'Men Tops'
 data$Item_Desc[data$Item_Desc =='Mens Undergarments' ] =  'Men Tops'
 data$Item_Desc[data$Item_Desc =='Marinated Chicken' ] =  'Non Veg'
 data$Item_Desc[data$Item_Desc =='Marinated Mutton' ] =  'Non Veg'
 data$Item_Desc[data$Item_Desc =='Pork' ] =  'Non Veg'
 data$Item_Desc[data$Item_Desc =='Raw Chicken' ] =  'Non Veg'
 data$Item_Desc[data$Item_Desc =='Raw Mutton' ] =  'Non Veg'
 data$Item_Desc[data$Item_Desc =='Ladies Socks'] =  'Socks'
 ata$Item_Desc[data$Item_Desc =='Mens Socks'] =  'Socks'
 data$Item_Desc[data$Item_Desc =='Badminton'] =  'Sports'
 data$Item_Desc[data$Item_Desc =='Basket Ball'] =  'Sports'
 data$Item_Desc[data$Item_Desc =='OtherSports'] =  'Sports'
 data$Item_Desc[data$Item_Desc =='Beans'] =  'Vegetables'
 data$Item_Desc[data$Item_Desc =='Gourds'] =  'Vegetables'
 data$Item_Desc[data$Item_Desc =='Leafies'] =  'Vegetables'
 data$Item_Desc[data$Item_Desc =='Onion'] =  'Vegetables'
 data$Item_Desc[data$Item_Desc =='Potato'] =  'Vegetables'
 
 
 
 
# MARKET BASKET MODEL:
   
 
 data$Invoice_No <- as.factor(data$Invoice_No)
 Agg.data <- split(data$Item_Desc,data$Invoice_No)
 class(Agg.data)
 Agg.data
 
 Agg.data_DD <- list()
 > for (i in 1:length(Agg.data)) {
    Agg.data_DD[[i]] <- as.character(Agg.data[[i]][!duplicated(Agg.data[[i]])])
    }
  
 
 Txns <- as(Agg.data_DD,"transactions")
 Txns
 summary(Txns)
 
 inspect(Txns[10])
 
 
 ## Let us see the support
 freq <- itemFrequency(Txns)
 class(freq)
 freq <- freq[order(-freq)]
 
 freq["Bread"]
 
 barplot( freq[1:20] )
 
 ?itemFrequencyPlot
 itemFrequencyPlot(Txns, support = 0.10)
 itemFrequencyPlot(Txns, topN = 10)
 
 
 ##install.packages("arulesViz")
 library("arulesViz")
 ?apriori
 arules1 <- apriori(data = Txns)
 summary(arules1)
 
 ## See the Association Rules
 inspect(arules1)
 
 inspect(sort(arules1, by = "lift") )
 
 
 arules2 <- apriori(data = Txns, 
                    parameter = list(support = 0.05, confidence = 0.5, maxlen = 2 )
 )
 
 summary(arules2)
 ##inspect(arules2)
 inspect(sort(arules2, by = "lift")[1:30] )
 
 
 
 #Scatter plot of rules:
 library("RColorBrewer")
 plot(arules2,control=list(
   col=brewer.pal(11,"Spectral")),
   main="Association Rules Plot"
 )
 
 #Rules with high lift typically have low support.
 
 
 ## Plot Interactivee Graphs
 subrules2 <- head(sort(arules2, by="support"), 20)
 plot(subrules2, method="grouped" , interactive=TRUE )
 
 #Plot graph-based visualisation:
 plot(subrules2, method="graph",control=list(type="items",main=""))
 inspect(subrules2)
 
 plot(subrules2, method="grouped" , interactive=TRUE )
 
 rules_df <- as(arules2,"data.frame")
 rules_df$lhs_suuport <- rules_df$support / rules_df$confidence;
 rules_df$rhs_support <- rules_df$confidence / rules_df$lift;
 View(rules_df)
 write.table(rules_df, file = "output/mba_output.csv", sep = "," , append = F, row.names = F)
 unlink("mba_output.csv")
 
 