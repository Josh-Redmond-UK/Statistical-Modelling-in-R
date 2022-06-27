# Statistical Modelling in R #

## All the content in this practical was developed by JJ Valletta and TJ McKinley in 2018 and adapted by Joshua Redmond and Laura Roldan in 2022.

# PART 1: LINEAR MODELS ----

## Simple Regression----

# Context: A cost of increased reproduction in terms of reduced longevity has been shown for female fruitflies, but not for males. We have data from an experiment that used a factorial design to assess whether increased sexual activity affected the lifespan of male fruitflies. 

# The flies used were an outbred stock. Sexual activity was manipulated by supplying individual males with one or eight receptive virgin females per day. The longevity of these males was compared with that of two control types. The first control consisted of two sets of individual males kept with one or eight newly inseminated females. Newly inseminated females will not usually remate for at least two days, and thus served as a control for any effect of competition with the male for food or space. The second control was a set of individual males kept with no females. There were 25 males in each of the five groups, which were treated identically in number of anaesthetisations (using CO2) and provision of fresh food medium. 

### Get ready----

# 1.1. Open the data

ff <- readRDS('data/fruitfly.rds')

# 1.2. Overview of your data

head(ff)

# 1.3. Install the Tydiverse package

install.packages("tidyverse")
library(tidyverse)

### Task  1:---- 

# Produce a scatterplot of longevity against thorax. What does the relationship look like?

# Solution:

plot(longevity ~ thorax, data = ff, 
     pch=19, col='darkgrey')

# or using tidyverse

ggplot(ff) +
  geom_point(aes(x = thorax, y = longevity))

### Task  2:----

# Fit a linear model with lifespan as response variable and thorax length as explanatory variable.

fit <- lm(longevity ~ thorax, ff)
summary(fit)

### Task  3:----

# Display a summary of the fit, together with the 97% confidence interval for the estimated parameters.

confint(fit, level=0.97)


### Task  4:----

# Show the diagnostic plots for the model.

par(mfrow=c(2, 2))
plot(fit, pch=19, col='darkgrey')
par(mfrow=c(1, 1))

#### Bonus track: Predict a specific value---- 
'One of the key benefits of fitting a statistical model is that we can use it to produce predictions of the dependent variable for new values of the independent variable(s). For example, in the fruitflies example above, we may want to produce estimates of average longevity for given values of thorax. To do this we must create a new data.frame object containing all the values of independent variables that we want to use for our prediction.'

## produce predicted longevity for thorax = 0.8mm
newdata <- data.frame(thorax = 0.8)
predict(fit, newdata, interval = "confidence", level = 0.97)




## Regression with Categorical Explanatory Variables----
# Task 1 - Use a plot to see how longevity relates to type

# Task 2 - Plot the relationship between thorax size and longevity - and colour the points by type
# HINT you can control colour of your points with the "col" parameter - just pass the string name of the point
ggplot(mapping = aes(x = thorax, y
                     = longevity, colour = type)) +
  geom_point(data = ff)


# Task 3 - As before, fit a linear model using a single binary categorical variable
fit <- lm(longevity ~ type, ff)
summary(fit)


# Task 4 
# What do you think is going on behind the scenes? Write a quick explanation of how the program handles categorical variables which don't have an order



# Task 5
# Try using the model to predict a category which does not exist in the training data? What happens?
# The model should throw an error - this is because of the way in which the categorical feature is transformed into a dummy variable in the fitting of the model
newdata <- data.frame(type = "Other")
predict(fit, newdata, interval = "confidence", level = 0.97)



# Task 6
# Plot the 97% confidence interval for the categorical variable - how can you interpret this?


# Task 7
# Do the same but for just thorax size from the model which includes both type and thorax - how does the thorax size line change when compared to the line from the simple linear model?


# Now try adding another term - build a linear model for longevity using type and thorax length


# Plot the confidence interval for each line - and compare to your earlier simple model - how does the thorax length line change?





## Multiple Regression----

### Task 1:----

# Fit a linear model with lifespan as response variable and thorax length and type of companion as explanatory variables

fit <- lm(longevity ~ type + thorax, ff)
summary(fit)

### Task 2:----

# Display a summary of the fit, together with the 97% confidence intervals for the estimated parameters

confint(fit, level=0.97)

### Task 3:----

# Interpret: Why do we get two parameters for type of companion and what do they mean in practice?

# SOLUTION: https://exeter-data-analytics.github.io/StatModelling/linear-models.html#practical-3

### Task 4:----

# Plot the mean regression line for each type of companion together with the observed data.
newdata <- expand.grid(
  thorax = seq(min(ff$thorax), 
               max(ff$thorax), length.out = 50),
  type = levels(ff$type)
)
newdata <- cbind(newdata, 
                 longevity = predict(fit, newdata))
ggplot(mapping = aes(x = thorax, y
                     = longevity, colour = type)) +
  geom_point(data = ff) +
  geom_line(data = newdata)

### Task 5:----

# Show the diagnostic plots for the model, what can you say about the model fit?

par(mfrow=c(2, 2))
plot(fit, pch=19, col='darkgrey')
par(mfrow=c(1, 1))

### Task 6:----

# Interpret: Compare the total variation explained by this model with the one that only used thorax as a covariate. What can you say about the importance of the type of companion?

# SOLUTION:
# The R Squared statistic (also known as the coefficient of determination) is the proportion of the total variation that is explained by the regression. Which in this case is 60.2%. This is considerably higher than the 40% achieved with just thorax, suggesting that type of companion is indeed an important covariate and thus should be included in the model.

## Over to you----

### Task 1:----

# Fit a linear model with lifespan as response variable and thorax length and sleep as explanatory variables



### Task 2:----

# Display a summary of the fit, together with the 97% confidence intervals for the estimated parameters



### Task 3:----

# Interpret: Whatâs the practical significance of the estimated parameters?
                     
                     
### Task 4:----

# Show the diagnostic plots for the model, what can you say about the model fit?


### Task 5:----

# Interpret: What is the total variation explained by thorax and sleep?


### Task 6:----

# Visualise the correlation between all explanatory variables, what might this tell you about the application of this model?


### Task 7:----

# Visualise the correlation between all explanatory variables, what might this tell you about the application of this model?