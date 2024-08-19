# Set seed for reproducibility
set.seed(246)

# Load necessary libraries
library(e1071)
library(MASS)
library(kernlab)
library(caret)

# Set base directory (replace with your directory)
base_dir <- "C:/Users/Shir Yoga520/Desktop/UofG/ML1/"

# Load training, validation, and test datasets and remove unrelated columns
train.svm <- read.csv(file.path(base_dir, "train.data2.csv"), header = TRUE, sep = ",")
train.svm <- subset(train.svm, select = -X)

valid.svm <- read.csv(file.path(base_dir, "valid.data2.csv"), header = TRUE, sep = ",")
valid.svm <- subset(valid.svm, select = -X)

test.svm <- read.csv(file.path(base_dir, "test.data2.csv"), header = TRUE, sep = ",")
test.svm <- subset(test.svm, select = -X)

# Change the Class column to factor with appropriate labels
train.svm$Class <- factor(ifelse(train.svm$Class == 0, "Never Used", "Used"))
valid.svm$Class <- factor(ifelse(valid.svm$Class == 0, "Never Used", "Used"))
test.svm$Class <- factor(ifelse(test.svm$Class == 0, "Never Used", "Used"))

# Tune the SVM model with radial kernel to find optimal cost and gamma
tuning <- tune(svm, Class ~ ., data = train.svm[, c(7, 8, 9)], 
               type = "C-classification", kernel = "radial", 
               ranges = list(cost = c(0.1, 0.5, 1, 10, 100, 1000), 
                             gamma = c(0.01, 0.1, 0.5, 1)))

# Output the tuning results
print(tuning)
summary(tuning)

# Use the best model for prediction on the validation set
pred.valid <- predict(tuning$best.model, newdata = valid.svm[, c(7, 8, 9)])
cat("Confusion Matrix for Validation Set:\n")
print(table(valid.svm[, 9], pred.valid))
summary(tuning$best.model)

# Plot the SVM decision boundaries
windows(width = 10, height = 6)  # Adjust width and height as needed
png("plotsvmradial.png", width = 800, height = 600)  # Adjust width and height as needed
plot(tuning$best.model, train.svm[, c(7, 8, 9)])
dev.off()

# Check performance on the validation set
pred.test <- predict(tuning$best.model, newdata = valid.svm[, c(7, 8, 9)])
test_error_rate <- 1 - sum(diag(table(valid.svm[, 9], pred.test))) / length(pred.test)
cat("Test Error Rate on Validation Set:", test_error_rate, "\n")

# Confusion matrix for validation set
conf_matrix <- confusionMatrix(pred.test, valid.svm$Class)
print(conf_matrix)

# Calculate false discovery rate
svm.tab <- table(valid.svm$Class, pred.test)
svm.class.rates <- sweep(svm.tab, 2, apply(svm.tab, 2, sum), "/")
false_discovery_rate <- svm.class.rates[1, 2]
cat("False Discovery Rate:", false_discovery_rate, "\n")
