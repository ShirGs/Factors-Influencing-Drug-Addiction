# Load necessary libraries
library(e1071)
library(caret)

# Set base directory (replace with your directory)
base_dir <- "C:/Users/Shir Yoga520/Desktop/UofG/ML1/"

# Load training and validation data
train.svm <- read.csv(file.path(base_dir, "train.data.csv"), header = TRUE, sep = ",")
valid.svm <- read.csv(file.path(base_dir, "valid.data.csv"), header = TRUE, sep = ",")

# Scale features for SVM
train.svm.scaled <- scale(train.svm[, -9]) # Exclude the class variable
valid.svm.scaled <- scale(valid.svm[, -9])

# Parameter tuning using grid search
tune_grid <- expand.grid(.C = c(0.1, 1, 10), .sigma = c(0.01, 0.1, 1))
svm_fit <- train(Class ~ ., data = train.svm, method = "svmRadial",
                 trControl = trainControl(method = "cv"), tuneGrid = tune_grid)

# Best parameters
best_params <- svm_fit$bestTune
cat("Best parameters: C =", best_params$.C, ", sigma =", best_params$.sigma, "\n")

# Apply the best model on validation data
svm_model <- svm(Class ~ ., data = train.svm, kernel = "radial", cost = best_params$.C, gamma = best_params$.sigma)
svm_pred <- predict(svm_model, newdata = valid.svm.scaled)
confusionMatrix(svm_pred, valid.svm$Class)
