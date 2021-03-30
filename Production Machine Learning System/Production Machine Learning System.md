# Production Machine Learning Systems
course link: https://www.coursera.org/learn/gcp-production-ml-systems  

- [Production Machine Learning Systems](#production-machine-learning-systems)
  - [The Components of an ML System](#the-components-of-an-ml-system)

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
