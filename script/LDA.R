# Load necessary libraries
library(caret)
library(MASS)
library(ggplot2)
library(klaR)

# Set base directory (replace with your directory)
base_dir <- "C:/Users/Shir Yoga520/Desktop/UofG/ML1/"

# Load training, validation, and test datasets and remove unrelated columns
train.lda <- read.csv(file.path(base_dir, "train.data2.csv"), header = TRUE, sep = ",")
train.lda <- subset(train.lda, select = -X) # remove unrelated column
train.lda$Class <- factor(train.lda$Class)  # change to factor

valid.lda <- read.csv(file.path(base_dir, "valid.data2.csv"), header = TRUE, sep = ",")
valid.lda <- subset(valid.lda, select = -X)
valid.lda$Class <- factor(valid.lda$Class)

test.lda <- read.csv(file.path(base_dir, "test.data2.csv"), header = TRUE, sep = ",")
test.lda <- subset(test.lda, select = -X)
test.lda$Class <- factor(test.lda$Class)

# Fit LDA model
train.lda.mod <- lda(Class ~ ., data = train.lda)
print(train.lda.mod)

# Visualisation with histogram and density plot between the two classes
# Histogram
train.lda.values <- predict(train.lda.mod)
ldahist(data = train.lda.values$x[,1], g = train.lda$Class)

# Density plot
dataset <- data.frame(Type = train.lda$Class, lda = train.lda.values$x)
ggplot(dataset, aes(x = lda)) +
  geom_density(aes(group = Type, colour = Type, fill = Type), alpha = 0.3) +
  labs(title = "LDA Density Plot", x = "LD1", y = "Density")

# Visualize the resulting classes in all of the 8 variables
partimat(Class ~ ., data = train.lda, method = "svmlight", cost = 1)

# Performance on the validation data
pred.valid.lda <- predict(train.lda.mod, valid.lda)
print(pred.valid.lda)

# Performance measures from the cross-classification table with confusionMatrix command
xtab.valid.lda <- table(pred.valid.lda$class, valid.lda$Class)
confusionMatrix(xtab.valid.lda)

# False discovery rate
lda.class.rates <- sweep(xtab.valid.lda, 2, apply(xtab.valid.lda, 2, sum), "/")
lda.class.rates[1, 2]

# Predict using the fitted models on the test data for future performance
pred.test.lda <- predict(train.lda.mod, test.lda)

xtab.test.lda <- table(pred.test.lda$class, test.lda$Class)
confusionMatrix(xtab.test.lda)

# False discovery rate for test data
lda.class.rates.test <- sweep(xtab.test.lda, 2, apply(xtab.test.lda, 2, sum), "/")
lda.class.rates.test[1, 2]
