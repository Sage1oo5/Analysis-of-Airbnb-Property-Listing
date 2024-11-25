# Analysis of Airbnb Property Listings in Seattle

## Overview
This project examines the influence of **host response time** on the **pricing structure** of Airbnb properties in Seattle. The analysis uses a dataset of 232 Airbnb property listings from January 2016 and employs statistical techniques to investigate relationships between host responsiveness and logarithmically transformed nightly property prices.

Key variables include:
- **Host Response Time**: Categorized as "within an hour," "within a few hours," and "within a day."
- **Log-Transformed Nightly Price**: A refined measure of nightly property costs.

The project utilizes descriptive statistics, hypothesis testing, and advanced inferential methods to uncover insights.

---

## Objectives
1. **Descriptive Analysis**:
   - Summarize data distribution and central tendencies for key variables.
   - Visualize response time categories and their interaction with log-transformed prices.
2. **Global Testing**:
   - Assess whether differences in log-transformed prices exist across response time categories using ANOVA.
   - Test assumptions of normality and variance homogeneity.
3. **Inferential Analysis**:
   - Conduct pairwise comparisons using Tukey’s HSD and Bonferroni correction.
   - Compare results with non-adjusted tests for robustness.

---

## Dataset Description
- **Source**: [Airbnb Listings Dataset](https://www.kaggle.com/datasets/airbnb/seattle).
- **Description**:
  - Dataset of 232 Airbnb listings from Seattle.
  - **Host Response Time** encoded as:
    - 0: "Within an hour."
    - 1: "Within a few hours."
    - 2: "Within a day."
  - Log-transformed prices (`log_price`) used as the response variable.

**Preprocessing**:
- Irrelevant columns and rows with missing data removed.
- Dataset already preprocessed, ready for analysis.

---

## Statistical Methods
The following statistical methods are implemented:
1. **Descriptive Statistics**:
   - Five-number summaries, mean, median, and standard deviation.
   - Data visualizations: Histograms, bar charts, and QQ plots.
2. **Normality and Homogeneity Tests**:
   - Shapiro-Wilk test for normality.
   - Levene’s test for homogeneity of variances.
3. **ANOVA**:
   - One-way ANOVA to test global differences in log-transformed prices.
4. **Pairwise Comparisons**:
   - Tukey’s Honest Significant Difference (HSD).
   - Bonferroni-corrected t-tests for robust comparisons.

---

## Outputs

The following outputs are generated:

1. **Summary Statistics**:
   - Descriptive statistics for log-transformed prices across response categories.
   - Tabular results for hypothesis tests.

2. **Visualizations**:
   - Histograms and bar charts for data distribution.
   - QQ plots for assessing normality.
   - Tukey’s intervals for pairwise comparisons.

3. **Inferential Results**:
   - ANOVA summary tables.
   - Results of Tukey’s HSD and Bonferroni-corrected pairwise t-tests.

---

## Key Insights

1. **Descriptive Analysis**:
   - Log-transformed prices vary significantly across response time categories.
   - Mean log-transformed prices:
     - "Within an hour": 4.61
     - "Within a few hours": 4.82
     - "Within a day": 4.74

2. **Global Testing**:
   - ANOVA results indicate significant differences in log prices (F = 3.648, p = 0.0276).
   - Levene’s test suggests homogeneous variances (p = 0.1752).

3. **Pairwise Comparisons**:
   - Tukey’s HSD identifies significant differences between:
     - "Within an hour" and "Within a few hours" (p = 0.0219).
   - Bonferroni correction confirms robust significance for adjusted pairwise tests.

---

## References

1. Seattle Airbnb Listings. (n.d.). Retrieved from [Kaggle](https://www.kaggle.com/datasets/airbnb/seattle).
2. RStudio Team. *RStudio: Integrated Environment for Development in R*. RStudio, PBC, 2022. [RStudio](https://www.rstudio.com/).
3. Hadley Wickham et al. *dplyr: A Grammar of Data Manipulation* (Version 1.1.2). [CRAN](https://CRAN.R-project.org/package=dplyr).
4. Hadley Wickham. *ggplot2: Elegant Graphics for Data Analysis*. Springer, 2016. [ggplot2 Documentation](https://ggplot2.tidyverse.org/).
5. John Fox and Sanford Weisberg. *An R Companion to Applied Regression*. Sage, 2019. [car Package Documentation](https://CRAN.R-project.org/package=car).
6. Friedrich Leisch. *Multcomp: Simultaneous Inference for General Linear Hypotheses*. [CRAN](https://CRAN.R-project.org/package=multcomp).
7. Hadley Wickham. *Reshaping Data with the reshape Package*. *Journal of Statistical Software*, 21(12), 2007. [Journal Article](https://www.jstatsoft.org/v21/i12/).
