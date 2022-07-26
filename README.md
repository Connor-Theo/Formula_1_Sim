# Formula_1_Sim

## Selected topic:

- Using regression testing on practice and qualifying data in order to predict race winners and important features for improved lap times 
---

## Reason topic was selected:

- There was a shared interest in sports among the group. We wanted a sport that was known to keep a wide variety of statistics and setteled on F1 Racing
---

## Description of data source:

- Through this project we are planning on working with a few different datasets. The majority of our data was pulled from Kaggle
- This dataset provides a variety of historical race data for the Formula 1 series from 1950-2022
- Link to data on Kaggle: 
  - https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020?resource=download
---

## Description of communication protocols:

- We plan to communicate during our regularly assigned classtime along with keeping conversations going within the Slack app
  - We have created our own group within Slack and this will be our primary means of communication
---

## Questions we hope to answer with the data:

- We hope to use the above dataset and other supplemental data to get a better understanding what factors have the greatest impact on race finishes
- What features can we add or remove to improve the accuracy of the machine learning model?
- Which features can accurately predict whether or not a racer finishes within the top 10 of their race?
- Which features are most important to the ability of a racer of finishing in the top 10 of their race?
---

## Machine Learning Model:

### Description of Preliminary Data Pre-processing

The data was imported through connecting to pgAdmin to access our postgres database. The data was then examined during our exploratory phase to determine which columns we would like to analyze and how we want our model to analyze the data. This is where we identified the specific columns for the model features and determined we would use whether or not a racer landed in the top 10 position of their race as the dependent variable. Preprocessing of the data was then conducted.

During the preprocessing phase, the data types and the number of null values were determined. Unnecessary columns were dropped from the data set. Any racer that did not finish the race (represented as null in the data) was replaced with the finish position 20, which represents last place. There are three opportunities for racers to obtain the fastest qualifying time. Because only 1 qualifying time is used in the race, we took the fastest possible qualifying time and inserted the value into a new column. Because the previous qualifying times were now unnecessary, they were dropped from the data. Due to the high level of null values, we elected to remove the variable "downforce level" from our data, as it would skew the end results of our analysis.

At this point, we rechecked null values and dropped 35 more rows, thus eliminated all nulls in our data. In order for the model to evaluate our data, we needed to convert the qualifying minimums to nanoseconds, otherwise the model would throw an error. After that we converted our categorical variables (Rainfall, Start Tyre, End Tyre) to integers to be able to pass them through the model. We reconfirmed that there were no nulls, the total population, and data types prior through initiating the model.

---

### The Supervised Machine Learning Model

**Choosing the Model**

Due to the nature of the data, we elected to use a Logistic Regression model. We used this because the data was not complex enough for unsupervised models such as Neural Networks and our general questions were simple and could be solved using logistic regression. Some advantages of this model are that it's easy to implement and train, it does not make any statistical assumptions about distributions, and it also provides additional detail on the appropriateness of various predictors (features). Disadvantages of this model are that there is an assumption of linearity between the independent and dependent variables which means non-linear problems cannot be solved with this model. Additionally, due to the simplicity of the model, complexity of the data may be lost thus losing potential interesting relationships between variables.

**Feature Selection**

Features were chosen during the exploratory analysis phase of this project. We reviewed each potential feature in the various data sets and used our best judgement for potential predictors of finishing in the top 10 of a race. We focused on factors that could impact the drivers ability to perform such as rainfall, temperature, and humidity as well as strategic decisions made by the race team such as tire type and number of stops. We also included the actual performance of the driver through qualifying times, grid position, and finish position.

**Train/Test**

To train the model, the data was split into two separate categories of "training" and "testing." In this way, a subset of the data is used to train the model and a subset is used to test the model. The second subset is sequestered and not used until predictions are run. The goal here is to determine how successful a given model is at predicting an outcome by running the test data through and comparing it to the actual results. The model is ~49% accurate, slightly worse than a coin flip. Additionally, the model is only predicting all "False" or all "True" in the Confusion Matrix. Additional analysis can be done to determine if the model can be improved.

![alt text](https://github.com/Connor-Theo/Formula_1_Sim/blob/4b6e68916d30e0509173ebaf76d5170b0e4d1a83/Images/Old%20Accuracy.png)

**Updates to Model**

After examining the model results and reviewing the features used, it was determined to remove "finish position" from the features. This was because "finish position" was highly correlated with our independent variable of "top ten." Removing this helped reduce the noise in the model. Additionally, the feature "qt_mn_ns" was a very large number and was skewing the end results due to its size. We decided to incoporate StandardScaler to equalize the features in the model. This substantially increased the effecacy of our model. 

Finally, we optimized our model using Gradiant Boosting to 1) determine the best test group size and 2) determine if the model would better fit the data than the Logistic Regression model. After running the loop to determine best test model, we decided to move forward with the Gradiant Boosting model. The changes to the model corrected our issues with the confusion matrix (as seen below).

![alt text](https://github.com/Connor-Theo/Formula_1_Sim/blob/4b6e68916d30e0509173ebaf76d5170b0e4d1a83/Images/Confusion%20Matrix.png)

This resulted in our  which ultimately landed at an accuracy of ~77%. 

![alt text](https://github.com/Connor-Theo/Formula_1_Sim/blob/4b6e68916d30e0509173ebaf76d5170b0e4d1a83/Images/Classification.png)

And we were able to answer our research questions by evaluating feature importance.

![alt text](https://github.com/Connor-Theo/Formula_1_Sim/blob/4b6e68916d30e0509173ebaf76d5170b0e4d1a83/Images/Feature%20Importance.png)

---

## Dashboard:

- The dashboard will be created within Tableau and will contain interactive elements base upon our machine learning model.
- Below is a screenshot of our F1 Dashboard within Tableau. We have interactive filters within the chart along with a visulization of our Feature Importance chart from our machine learning model. 

![Image of Dashboard Tab 1](https://github.com/Connor-Theo/Formula_1_Sim/blob/main/Images/F1_Dashboard_Races.png)

![Image of Dashboard Tab 2](https://github.com/Connor-Theo/Formula_1_Sim/blob/main/Images/F1_Dashboard_Drivers.png)
---

## Resources:

**Datasets:** [Resources](https://github.com/Connor-Theo/Formula_1_Sim/tree/matt_branch/Resources)

**Google Slides:** https://docs.google.com/presentation/d/1T1S13TpNtwNmuS0r2bkTNl7emLizUT_eB4iXwrM04CQ/edit#slide=id.p1

**Tableau Dashboard:** https://tabsoft.co/3AkyuV0
