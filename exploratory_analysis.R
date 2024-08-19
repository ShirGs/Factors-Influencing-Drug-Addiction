# Load necessary libraries
library(GGally)
library(ggplot2)
library(dplyr)

# Function to visualize data distributions and correlations
visualize_data <- function(data) {
  ggpairs(data = data, mapping = aes(color = as.factor(Class)),
          progress = FALSE, columns = 1:8,
          upper = list(continuous = wrap('cor', size = 2.2)),
          lower = list(continuous = wrap("points", alpha = 0.5, size=1),
                       combo = wrap("dot", alpha = 0.7, size=1)))
}

# Set base directory (replace with your directory)
base_dir <- "C:/Users/Shir Yoga520/Desktop/UofG/ML1/"

# Load training data
train.data <- read.csv(file.path(base_dir, "train.data.csv"), header = TRUE, sep = ",")

# Visualize data
visualize_data(train.data)

# Checking for data skewness and other anomalies
summary(train.data)

# Check the correlation matrix
correlation_matrix <- cor(train.data[, -9]) # Exclude the class variable
corrplot(correlation_matrix, method = "circle")
