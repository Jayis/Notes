# CNN training heuristics
---
## Optimizer
- ### ADAM vs SGD
    ADAM usually needs a order of magnitude of LR than SGD
    ADAM is more forgiving in terms of LR tuning

## Batchsize-Scheduling-LearningRate
- ### Linear Scaling Rule (from "training imageNet in one hour")
    when the minibatch size is multiplied by k,  
    multiply the learning rate by k,  
    divide the schedule by k

## Multi-tasking
- ### shared-backone learning rate compensation
    doesn't help

- ### weight between different tasks
    use this to make all tasks converge at the same time  
    smaller weight, slower convergence
    ```
    2021, gallopwave, object detection and sementic segmentation shared backbone project
    ```

- ### model capacity
    we can examine the capacity is used up or not by
    training the model on each task individually then compare the performance for each task.

    if we got worse performance on each tasks, maybe we should consider widen (channel++) the model a bit

    *btw, **lottery ticket** theory bring a little bit different view to model capacity*
    *the true capacity might be less then visible capacity due to there're only parts of network were initialized as good initialization.*

## Model-Pruning
- ### lottery ticket
    > when a model is trained, there should be many weights that has small magnitude (if capacity were not used up).
    > if we prune the model by magnitude, we can get a smaller model.
    > if we train the smaller model with the initialization from bigger model, we should get same accuracy

- ### when using network slimming, we should check if bn does meet the assumption
    that is "bn small -> no info".
    It can be break if a softmax following the bn.

---