# -*- coding: utf-8 -*-
"""
Created on Wed Jan 17 12:48:49 2018

@author: Bryan
"""

import matplotlib.pyplot as plt
plt.style.use('classic')
# %matplotlib inline
import numpy as np
import pandas as pd
import seaborn as sns
sns.set()

hours_sunshine = np.array(([2,3,5,7,9]))
print('Hours of Sunshine',hours_sunshine)

cones_sold = np.array([4,5,7,10,15])
print('Cones Sold', cones_sold)

from sklearn.linear_model import LinearRegression

model = LinearRegression(fit_intercept=True)
model.fit(hours_sunshine[:, np.newaxis], cones_sold)
xfit = np.linspace(0,10,1000)

yfit = model.predict(xfit[:,np.newaxis])

plt.scatter(hours_sunshine, cones_sold)
plt.plot(xfit,yfit);

# Multi-Variate Linear Regression...
iris = sns.load_dataset("iris")
iris.head()

iris.describe()

sns.pairplot(iris, hue='species', size=2.5);

with sns.axes_style(style='ticks'):
    g = sns.factorplot("petal_length", "species", data=iris, kind="box")
    g.set_axis_labels("Petal Length", "Species");
 
g = sns.PairGrid(iris, vars=['petal_length', 'petal_width', 'sepal_length', 'sepal_width'],
                 hue='species', palette='RdBu_r')
g.map(plt.scatter, alpha=0.8)
g.add_legend();

sns.violinplot("species", "petal_width", data=iris, palette=["lightblue", "lightpink"]);


    
    