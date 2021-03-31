# Production Machine Learning Systems
course link: https://www.coursera.org/learn/gcp-production-ml-systems  

- [Production Machine Learning Systems](#production-machine-learning-systems)
  - [The Components of an ML System](#the-components-of-an-ml-system)
  - [Training Design Decisions](#training-design-decisions)
    - [How is physics unlike fashion ?](#how-is-physics-unlike-fashion-)
    - [Static vs Dynamic Training](#static-vs-dynamic-training)

---

## The Components of an ML System

![](assets/ml_sys_components.jpg)

- Data Analysis + Validation  
monitor the data distribution 
- Tuner  
there are no globally optimal values for hyperparameters, only problem-specific optima
- Serving  
  - **low-latency** to respond to users quickly
  - **highly efficient** so that many instances can be run simultaneously
  - **scale horizontally** to be reliable and robust to failures
  - **easy to update** to new versions of the model 

---

## Training Design Decisions

### How is physics unlike fashion ?
Physics is constant whereas fashion isn't.  
You have to decide whether the phenomenon you're modelling is more like physics or like fashion.

### Static vs Dynamic Training

![](assets/static_vs_dynamic.jpg)

| Statistically Trained Model |                   Dynamically Trained Model                    |
| :-------------------------: | :------------------------------------------------------------: |
|    Trained once, offline    |                  Add training data over time                   |
|   Easy to build and test    | Engineering is harder<br /> Have to do progressive validation  |
|  Easy to let become stable  | Regularly sync out updated version<br /> Will adapt to changes |


