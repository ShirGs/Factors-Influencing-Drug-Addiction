# Load necessary libraries
library(readr)
library(ggplot2)
library(class)
library(caret)
library(dplyr)
library(corrplot)
library(GGally)

# Function to check data quality
check_data_quality <- function(data) {
  print(str(data, vec.len = 2))
  print(summary(data))
  cat("Missing values:", sum(is.na(data)), "\n")
  cat("Duplicated values:", sum(duplicated(data)), "\n")
}

# Set base directory (replace with your directory)
base_dir <- "C:/Users/Shir Yoga520/Desktop/UofG/ML1/"

# Load the dataset
big.data <- read.csv(file.path(base_dir, "Project Dataset.csv"), header = TRUE, sep = ",")
big.data <- subset(big.data, select = -X)

# Check data quality
check_data_quality(big.data)

# Create a pairplot to visualize the original dataset for dimensional reduction
ggpairs(data = big.data, mapping = aes(color = as.factor(Class)), 
        progress = FALSE, columns = 1:11, 
        upper = list(continuous = wrap('cor', size = 2.2)),
        lower = list(continuous = wrap("points", alpha = 0.5, size=1), 
                     combo = wrap("dot", alpha = 0.7, size=1))) 

# PCA Variance & Covariance Matrix
round(diag(var(big.data[,c(1:11)])),2)
set.seed(1)
big.var <- princomp(big.data[,c(1:11)])

# Proportion variance method 
summary(big.var)
plot(big.var)

# After dimensional reduction, retain the first 8 variables and the class variable
data.pca <- big.data[, c(1, 2, 3, 4, 5, 6, 7, 8, 12)]
write.csv(data.pca, file.path(base_dir, "data.pca.csv"))

# Split the dataset into training, validation, and test sets at 50:25:25
set.seed(42) # For reproducibility
n <- nrow(data.pca)
train_index <- sample(seq_len(n), size = 0.5 * n)
valid_index <- sample(setdiff(seq_len(n), train_index), size = 0.25 * n)
test_index <- setdiff(seq_len(n), c(train_index, valid_index))

train.data <- data.pca[train_index,]
valid.data <- data.pca[valid_index,]
test.data <- data.pca[test_index,]

# Save the datasets
write.csv(train.data, file.path(base_dir, "train.data.csv"))
write.csv(valid.data, file.path(base_dir, "valid.data.csv"))
write.csv(test.data, file.path(base_dir, "test.data.csv"))
