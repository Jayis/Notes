# Production Machine Learning Systems
course link: https://www.coursera.org/learn/gcp-production-ml-systems  

- [Production Machine Learning Systems](#production-machine-learning-systems)
- [Architecting Production ML Systems](#architecting-production-ml-systems)
  - [The Components of an ML System](#the-components-of-an-ml-system)
  - [Training Design Decisions](#training-design-decisions)
    - [How is Physics unlike Fashion?](#how-is-physics-unlike-fashion)
    - [Static vs Dynamic Training](#static-vs-dynamic-training)
  - [Serving Design Decisions](#serving-design-decisions)
    - [Static vs Dynamic Serving](#static-vs-dynamic-serving)
    - [Peakedness and Cardinality](#peakedness-and-cardinality)
- [Ingesting data for Cloud-based analytics and ML](#ingesting-data-for-cloud-based-analytics-and-ml)
  - [Data Scenarios](#data-scenarios)
  - [Different Types of GCP Buckets](#different-types-of-gcp-buckets)
  - [Different Service for Different Databases](#different-service-for-different-databases)
  - [Automatic ETL Pipelines into GCP](#automatic-etl-pipelines-into-gcp)
- [Designing Adaptable ML systems](#designing-adaptable-ml-systems)
  - [Adapting to Data](#adapting-to-data)
  - [Right and Wrong Decisions](#right-and-wrong-decisions)
  - [System Failure](#system-failure)
  - [Summary](#summary)
- [Designing High-performance ML Systems](#designing-high-performance-ml-systems)
  - [Aspects of Performance](#aspects-of-performance)
    - [Training](#training)
    - [Prediction](#prediction)
  - [Why Distributed Training?](#why-distributed-training)
  - [Distributed Training Architectures](#distributed-training-architectures)
    - [Data Parallelism](#data-parallelism)
    - [Model Parallelism](#model-parallelism)
  - [Faster Input Pipelines](#faster-input-pipelines)
  - [Inference](#inference)
    - [Batch Pipeline](#batch-pipeline)
    - [Streaming Pipeline](#streaming-pipeline)
- [Hybrid ML systems](#hybrid-ml-systems)
  - [Machine Learning on Hybrid Cloud](#machine-learning-on-hybrid-cloud)
    - [Composability](#composability)
    - [Portability](#portability)
    - [Scalability](#scalability)
  - [Kubeflow](#kubeflow)
  - [TensorFlow Lite](#tensorflow-lite)

---

# Architecting Production ML Systems

In this module, we’ll talk about what else a production ML system needs to do and how you can meet those needs. We’ll then review some important, high-level, design decisions around training and model serving that you’ll need to make in order to get the right performance profile for your model.

---

## The Components of an ML System

![](assets/ml_sys_components.jpg)

- Data Analysis + Validation  
  monitor the data distribution 
- Trainer  
  support for both data and model parallelism
- Tuner  
  there are no globally optimal values for hyperparameters, only problem-specific optima
- Serving  
  - **low-latency** to respond to users quickly
  - **highly efficient** so that many instances can be run simultaneously
  - **scale horizontally** to be reliable and robust to failures
  - **easy to update** to new versions of the model 

---

## Training Design Decisions

### How is Physics unlike Fashion?
Physics is constant whereas fashion isn't.  
You have to decide whether the phenomenon you're modelling is more like physics or like fashion.

### Static vs Dynamic Training

![](assets/static_vs_dynamic.jpg)

| Statistically Trained Model |                   Dynamically Trained Model                    |
| :-------------------------: | :------------------------------------------------------------: |
|    Trained once, offline    |                  Add training data over time                   |
|   Easy to build and test    | Engineering is harder<br /> Have to do progressive validation  |
|  Easy to let become stable  | Regularly sync out updated version<br /> Will adapt to changes |

---

## Serving Design Decisions

### Static vs Dynamic Serving

|              |     Static      |      Dynamic      |
| :----------- | :-------------: | :---------------: |
| Storage Cost |     higher      |       lower       |
| Latency      |   low, fixed    |     variable      |
| Maintenance  |      lower      |      higher       |
| Resources    | space intensive | compute intensive |

### Peakedness and Cardinality

Regarding the serving input,

- **Peakedness** is how concentrated the distribution is.  
- **Cardinality** is the number of values in the set.

Based on the peakedness and the cardinality, we decide which design to use.

![](assets/serving_peakedness_cardinality.jpg)

---

# Ingesting data for Cloud-based analytics and ML

In this module, we’ll talk about how to bring your data to the cloud. There are many ways to bring your data into cloud to power your machine learning models. We’ll first review why your data needs to be on the cloud to get the advantages of scale and using fully-managed services and what options you have to bring your data over.

---

## Data Scenarios
- Use local network to upload local data
- Use storage devices to transfer data offline  
  When the network is the bottleneck (e.g., the data is too big, the network is too slow).
- Cloud2Cloud
- Transfer from existing database

---

## Different Types of GCP Buckets

![](assets/GCP_buckets.jpg)

---

## Different Service for Different Databases

![](assets/different_storage_for_different_data_type.jpg)

---

## Automatic ETL Pipelines into GCP

![](assets/ETL_pipeline.jpg)

Depends on how the ETL pipeline is invoked, there are
- Push model  
  load data on demand, best for ad hoc or envent-based loading.

- Pull model  
  schedule the data loading periodically, better for when there are a repeatable process and scheduled interval.

---

# Designing Adaptable ML systems

In this module, we’ll learn how to recognize the ways that our model is dependent on our data, make cost-conscious engineering decisions, know when to roll back our models to earlier versions, debug the causes of observed model behavior and implement a pipeline that is immune to one type of dependency.

---

## Adapting to Data

Here are several examples that changes in them could affect our models.

1. An upstream model
2. A data source maintained by other team  
3. The relationship between features and labels
4. The distribution of inputs

**How to deal with 1 and 2?**  
Think carefully before consuming data from sources when there's a chance you won't know about changes to them.  
For 1, you can also make a local version of upstream models and update it on your schedule.

**How to deal with 3?**  
Features should always be scrutinized before being added.  
And all features should be subjected to **leave one out evaluations** to assess their importance.

**How to deal with 4?**  
- monitor descriptive statistics(mean, std, etc.) for your input and outputs
- monitor your residuals(prediction error) as a function of your inputs
- use custom weights in your loss function to emphasize data recency
- use dynamic training architecture and regularly retrain your model


![](assets/interpolation_extrapolation.jpg)
*Machine learning is good at interpolation(green), which means to generalize within bounds we've seen in training data, rather than extrapolation(blue).*

---

## Right and Wrong Decisions

Some decisions about data are a matter of weighing cost versus benefit, like short-term performance goals against long-term maintainability. Others though are about right and wrong.

- use feature that is not available during decision time
- partition train-val-test the wrong way

---

## System Failure

- make version control of models, so you can roll back your model state to a time before the data pollution
- dynamically retrain your model on newer data 
- understand the limits of your model

---

## Summary

- **Keep humans in the loop**  
  You need to monitor everything, from the distribution of your inputs to the distribution of your outputs, but also critically to your business performance metrics
  that we're often optimizing for something other than what we ultimately care about
- **Prioritize maintainability**  
  You need to constantly assess the value of all data sources, and weigh their performance benefit against the cost to maintain them
- **Get ready to roll back**  
  There is no way to unteach a model something that it has learned already. The only thing you can do is to roll back to a model version that didn't learn from polluted data.

---

# Designing High-performance ML Systems

In this module, you will learn how to identify performance considerations for machine learning models. Machine learning models are not all identical. For some models, you will be focused on improving I/O performance, and on others, you will be focused on squeezing out more computational speed.

---

## Aspects of Performance

### Training

There are three considerations
- time  
- cost
- scale (data size, parallelism)

There will be several trade-offs
- training time vs. accuracy
- data size vs. accuracy
- single powerful machine vs. multiple weak machines
- ..., etc.

You also have the choice of starting from an earlier model checkpoint and training for just a few steps.  
Typically, this will converge faster than training from scratch each time.

| Constraint      |                             Input / Ouput                             |                                  CPU                                  |                              Memory                              |
| :-------------- | :-------------------------------------------------------------------: | :-------------------------------------------------------------------: | :--------------------------------------------------------------: |
| Commonly Occurs |    Large inputs <br /> Input requires parsing <br /> Small models     |          Expensive computations <br /> Underpowered hardware          |           Large number of inputs <br /> Complex model            |
| Take Action     | Store efficiently <br /> Parallelize reads <br /> Consider batch size | Train on faster accel. <br /> Upgrade processor <br /> Simplify model | Add more memory <br /> Use fewer layers <br /> Reduce batch size |

### Prediction

- Batch Prediction  
  The considerations are very similar to that of training.

- Online Prediction  
  The considerations are quite different. This is because the end user is actually waiting for the prediction.

For example, if you're doing product recommendations for the next day.  
How many percent of users' recommendations should be precomputed by batch prediction and handle the rest via online prediction? 

---

## Why Distributed Training?

Machine learning gets complex quickly, it's necessary to accelerate the training through parallel training.
- heterogeneous systems
- distributed systems
- model architectures

![](assets/loss_vs_datasize.jpg)
*test loss vs. datasize*

![](assets/model_flops_vs_year.jpg)
*training flops vs. year*

---

## Distributed Training Architectures

### Data Parallelism

![](assets/data_parallelism.jpg)

Two approaches to data parallelism
- Parameter server  
  (pros)  
  - scales very well  
  - more mature  
  - applicable to model parallelism  
  - heterogeneous workers  
  - workers can be preempted by higher priority jobs, or go down to maintenance  
  
  (cons)  
  - workers can get out of sync, which could delay the convergence  
  
- Sync Allreduce  
  (pros)
  - converge faster  

  (cons)
  - need homogeneous worker to reduce the variance of step time  
  - need strong communication links to reduce the overhead of communication  

Distribute training can be called directly through `estimator.train_and_evaluate()`.  
Parameter server will be used as default.  
Sync Allreduce can be refered to a TF function called `MirroredStrategy()`.  

![](assets/async_parameter_server.jpg)
*In asynchronous parameter server architecture, some devices are designated to be parameter servers, and others as workers. Each worker independently fetches the latest parameters from the parameter server, and computes gradients based on a subset of training samples. It then sends the gradients back to the parameter server which updates its copy of the parameters with those gradients.*

![](assets/sync_allreduce.jpg)
*In this approach, each worker holds a copy of the model's parameters. Each worker then compute gradients based on the training samples that they see, and they can communicate this between themselves to propagate the gradients and update their parameters. All of the workers are synchronized, conceptually the next forward pass does not begin until each worker has received the gradients, and updated their parameters.*

![](assets/async_paraserver_vs_sync_allreduce.jpg)

### Model Parallelism

![](assets/model_parallelism.jpg)
*When your model is so big that it doesn't fit into a single devices memory. So you then have to divide it into smaller parts that can compute over the same training samples on multiple devices*

---

## Faster Input Pipelines

There are three approaches to reading data into TensorFlow. (from *slowest* to *fastest*)
- Directly feed from Python
- Use native TensorFlow Ops  
  keep all of the operations in C++, rather than bringing data to python.
- Read transformed TensorFlow records

Here're several things you can do to even speed up the input pipeline.
1. Parallelize file reading (I/O parallel)
2. Parallelize map for transformation (CPU parallel)
3. Pipelining with prefetching
4. Using fused transformation ops

---

## Inference

Several aspects to consider
- throughput (QPS, queries per second)
- latency (how long a query take)
- cost (in terms of infrastructure and maintenance)

### Batch Pipeline
![](assets/batch_pred_pipelines.jpg)
![](assets/performance_for_batch_pipelines.jpg)

### Streaming Pipeline
![](assets/streaming_pipelines.jpg)
![](assets/performance_for_streaming_pipelines.jpg)

---

# Hybrid ML systems

Understand the tools and systems available and when to leverage hybrid machine learning models.

---

## Machine Learning on Hybrid Cloud

In order to build hybrid machine learning systems that work well both on-premises and in the cloud, your machine learning framework has to support three things, composability, portability, and scalability.

### Composability

Each machine learning stage, data analysis, training, model validation, monitoring, these are all independent systems. Everyone has a different way to handle all these stages.  
So when we say composability, it's about the ability to compose a bunch of microservices together and the option to use what makes sense for your problem.

![](assets/composability.jpg)

### Portability

Bring your workflow across different environments like developing/staging/production.

### Scalability

- More accelerators (GPU, TPU)
- More CPUs
- More dist/networking
- More skillsets (data engineers, data scientists)
- More teams
- More experiments
- ...

---

## Kubeflow

So, you know what is really good at composability, portability, and scalability?  
**Containers** and **Kubernetes**, except, turns out even then it's not so easy.

The Kubeflow mission is to make it easy for everyone to develop, deploy, and manage portable, distributed machine learning on Kubernetes.

Kubeflow currently provides
- Jupyter notebook
- Multi-architecture, distributed training
- Multi-framework model serving
- ...

---

## TensorFlow Lite
TensorFlow Lite make specific compromises to enable machine-learning inference on low power or under-resourced devices.

- variable node -> constant node
- quantize model weight
- ...