#Tidy Tuesday

# Install the required packages
install.packages("remotes")
install.packages("devtools")
remotes::install_github("Shelmith-Kariuki/rKenyaCensus")

# Load the required libraries
library(rKenyaCensus)
library(tidyverse)
library(ggthemes)

# Review ttheme_economist()# Review the data catalogue
data("DataCatalogue")

# Load Table 2.36 - Percentage Distribution of Conventional 
# Households by Ownership of Selected Household Assets by Area 
# of Residence, County and Sub County

# Household Car Ownership in Kenya
# 

df <- V4_T2.36
View(df)

# Load county-specific data from Table 2.36

cty_df <- df %>% filter(AdminArea == "County")
view(cty_df)

# Set an appropriate theme
theme_set(theme_solarized())
# Generate a plot to demonstrate household car ownership in Kenya
ggplot(cty_df, aes(x = reorder(County, -Car), y = Car)) + 
  geom_point(size=3, color = "purple") +  
  # Draw points
  geom_segment(aes(x=SubCounty, xend=SubCounty, 
                   y=0, yend=Car), color = "purple", 
               size = 1) + 
  # Draw lines
  geom_hline(yintercept = 6.3, color = "black") +
  geom_text(aes(x = 38 , y = 6.3, label = "Average Car Ownership (Kenya)"), 
            size = 3, 
            angle=90, vjust = 1.5) +
  geom_hline(yintercept = 3.5, linetype = "dashed", color = "black") +
  geom_text(aes(x = 38 , y = 3.5, label = "Average Car Ownership (Rural)"), 
            size = 3,
            angle=90, vjust = 1.5) +
  geom_hline(yintercept = 10.8, linetype = "dashed", color = "black") +
  geom_text(aes(x = 38 , y = 10.8, label = "Average Car Ownership (Urban)"), 
            size = 3,
            angle=90, vjust = 1.5) +
  labs(title="Car Ownership in Kenya (2019 Census)", 
       subtitle="Percentage of Households that own 
       a car in each of the 47 counties", 
       caption="Visualization: William Okech | 
       Data: rKenyaCensus by Shelmith Kariuki") + 
  xlab("County") + 
  ylab("Household Car Ownership (%)") + 
  theme(axis.text.x = element_text(size=10,color="black")) + 
  theme(axis.text.y = element_text(size=10,color="black")) + 
  coord_flip()

# Save the plot
ggsave("C:/Users/willy/OneDrive/Documents/R Files/
       Census Data Samples/plot3.png", width = 7.5, height = 10)

