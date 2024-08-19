# Load libraries
library(caret)
library(class)
library(klaR)

# Set base directory (replace with your directory)
base_dir <- "C:/Users/Shir Yoga520/Desktop/UofG/ML1/"

# Load training and validation data
train.knn <- read.csv(file.path(base_dir, "train.data.csv"), header = TRUE, sep = ",")
valid.knn <- read.csv(file.path(base_dir, "valid.data.csv"), header = TRUE, sep = ",")

# Manually fitting the KNN model and evaluating for a range of k values
corr.class.rate <- numeric(25)
for(k in 1:25) {
  pred.class <- knn(train.knn[,-9], valid.knn[,-9], train.knn[,9], k=k)
  corr.class.rate[k] <- sum((pred.class == valid.knn$Class)) / length(pred.class)
}

# Plotting Correct Classification Rates for different k values
plot(1:25, corr.class.rate, type="l",
     main="Correct Classification Rates for the Validation Data for a range of k",
     xlab="k", ylab="Correct Classification Rate", cex.main=0.7)

# Display classification rates
corr.class.rate

# Find the optimal value of k
optimal_k <- which.max(corr.class.rate)
cat("Optimal k value:", optimal_k, "\n")

# Plot KNN model into training set with optimal k
partimat(Class ~ ., data = train.knn, method = "sknn", k = optimal_k)

# Evaluate and predict with validation set using the optimal k
pred4 <- knn(train.knn[,-9], valid.knn[,-9], train.knn[,9], k = optimal_k)
accuracy <- sum((pred4 == valid.knn$Class)) / length(pred4)
cat("Validation accuracy with optimal k:", accuracy, "\n")

# Confusion matrix to test performance
confusionMatrix(pred4, valid.knn$Class)

# Correlation classification rate
knn.tab <- table(valid.knn$Class, pred4)
knn.class.rates <- sweep(knn.tab, 2, apply(knn.tab, 2, sum), "/")
knn.class.rates

# False discovery rate
false_discovery_rate <- knn.class.rates[1, 2]
cat("False Discovery Rate:", false_discovery_rate, "\n")
