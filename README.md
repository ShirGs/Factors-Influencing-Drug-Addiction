# The Influential Factors in Drug Addiction

## Overview

This repository contains the R code and accompanying report for the Data Mining and Machine Learning I project, focusing on the influential factors in drug addiction. The project aims to analyze a dataset containing patient data to identify which factors most strongly predict drug use.

## Project Description

### Dataset
- The dataset includes 600 observations, each described by 11 features. The target variable is a binary class indicating whether the patient has "Never Used" (0) or "Used at some point" (1) drugs.
- **Features**:
  - Age
  - Education
  - Country of Origin
  - Ethnicity
  - Nscore (Neuroticism)
  - Escore (Extraversion)
  - Oscore (Openness)
  - Ascore (Agreeableness)
  - Cscore (Conscientiousness)
  - Impulsivity
  - Sensation Seeking (SS)

### Methodology

1. **Dimensionality Reduction**:
   - Principal Component Analysis (PCA) was employed to reduce the dimensionality of the dataset, retaining components that explain at least 90% of the original variance.

2. **Data Preparation**:
   - The dataset was split into training, validation, and testing sets in a 50:25:25 ratio.
   - Exploratory Data Analysis (EDA) was performed on the training set to understand correlations and distributions.

3. **Classification Techniques**:
   - Four classification methods were applied:
     1. k-Nearest Neighbors (kNN)
     2. Decision Tree
     3. Support Vector Machine (SVM)
     4. Linear Discriminant Analysis (LDA)
   - Each model was evaluated on accuracy, sensitivity, specificity, and other relevant metrics.

4. **Model Selection**:
   - Linear Discriminant Analysis (LDA) was identified as the most effective model, achieving an accuracy of 78.7% on the validation set. However, performance slightly declined on the test set, suggesting further refinement is necessary.

### Report
- A detailed report is included, summarizing the methodology, results, and conclusions drawn from the analysis.

## Repository Structure

- `data/`: Contains the dataset (if permissible to share).
- `scripts/`: Contains R scripts used for data analysis and modeling.
- `README.md`: This file.

## How to Use

1. **Install Required R Packages**:
   - Ensure you have the necessary R packages installed:
     ```R
     install.packages(c("ggplot2", "caret", "e1071", "MASS", "rpart"))
     ```

2. **Run the Analysis**:
   - Execute the R scripts sequentially to perform data preparation, analysis, and modeling.
   - Example:
     ```R
     source("scripts/data_preparation.R")
     source("scripts/exploratory_analysis.R")
     source("scripts/model_training.R")
     ```

3. **Reproduce Results**:
   - The code is well-commented to guide you through the process of reproducing the results described in the report.

## Key Findings

- **LDA Performance**: The Linear Discriminant Analysis model showed the best performance on the validation set, making it the preferred model for this dataset. However, further model refinement is needed due to a drop in performance on the test set.

- **Feature Importance**: Features such as age, country of origin, and certain personality traits (Oscore, Ascore) were found to be significant predictors of drug use.


## Acknowledgments

This work was completed as part of the Data Mining and Machine Learning I course at the University of Glasgow. Special thanks to the course instructors for their guidance and support.
