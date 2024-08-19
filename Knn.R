# Load necessary libraries
library(caret)
library(class)

# Set base directory (replace with your directory)
base_dir <- "C:/Users/Shir Yoga520/Desktop/UofG/ML1/"

# Load training and validation data
train.knn <- read.csv(file.path(base_dir, "train.data.csv"), header = TRUE, sep = ",")
valid.knn <- read.csv(file.path(base_dir, "valid.data.csv"), header = TRUE, sep = ",")

# Parameter tuning using cross-validation
set.seed(42)
tune_grid <- expand.grid(.k = seq(1, 20, by = 1))
train_control <- trainControl(method = "cv", number = 10)

knn_fit <- train(Class ~ ., data = train.knn, method = "knn",
                 trControl = train_control, tuneGrid = tune_grid)

# Best k value
best_k <- knn_fit$bestTune$.k
cat("Best k value:", best_k, "\n")

# Apply the best model on validation data
knn_pred <- knn(train = train.knn[, -9], test = valid.knn[, -9], cl = train.knn$Class, k = best_k)
confusionMatrix(knn_pred, valid.knn$Class)
