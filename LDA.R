# Load necessary libraries
library(MASS)
library(caret)
library(ggplot2)
library(klaR)

# Set base directory (replace with your directory)
base_dir <- "C:/Users/Shir Yoga520/Desktop/UofG/ML1/"

# Load training, validation, and test data
train.lda <- read.csv(file.path(base_dir, "train.data.csv"), header = TRUE, sep = ",")
valid.lda <- read.csv(file.path(base_dir, "valid.data.csv"), header = TRUE, sep = ",")
test.lda <- read.csv(file.path(base_dir, "test.data.csv"), header = TRUE, sep = ",")

# Fit LDA model
train.lda.mod <- lda(Class ~ ., data = train.lda)
train.lda.mod

# Visualization with histogram and density plot between the two classes
train.lda.values <- predict(train.lda.mod)
ldahist(data = train.lda.values$x[,1], g=train.lda$Class)

# Density plot
dataset <- data.frame(Type=train.lda$Class, lda = train.lda.values$x)
ggplot(dataset, aes(x=lda)) +
  geom_density(aes(group=Type, colour=Type, fill=Type), alpha=0.3) +
  labs(title="LDA Density Plot", x="LD1", y="Density")

# Visualize the resulting classes in all of the 8 variables
partimat(Class~., data = train.lda, method = "lda")

# Performance on the validation data
pred.valid.lda <- predict(train.lda.mod, valid.lda)
confusionMatrix(pred.valid.lda$class, valid.lda$Class)

# ROC Curve for LDA
library(pROC)
lda_roc <- roc(valid.lda$Class, as.numeric(pred.valid.lda$posterior[,2]))
plot(lda_roc, main="ROC Curve for LDA")

# Predict using the fitted model on the test data for future performance
pred.test.lda <- predict(train.lda.mod, test.lda)
confusionMatrix(pred.test.lda$class, test.lda$Class)
