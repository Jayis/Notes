# CNN training observations
---
## BN's abs(w) vs LR
    under same model, same training task
    it seems that we have some positive correlation between BN's abs(w) and LR

## train resolution vs inference resolution 
### while infer res < train res
    It's worth to remind yourself that CNN is a architecture that a single model can run on various input resolutions.
    Several things were observed.
    1. the closer the inference, train resolution, the better result.
    2. higher resolution usually performs better.

### while infer res > train res
    While we training, we subconsciously link resolution, scale, predict space together.
    While train, test were recorded with different camera, this is especially important.
    Compare with new resolution model

    if we try to do inference on bigger resolution
    we can observe that model perdict better on farther objects when resolution gets bigger.
    Maybe we should relate a “view angle” or "resolution" that a model was best at.

### Random Crop
    since the cropped patch would be further resized to training resolution.
    it would be better to be aware of the ratio of inference resolution 

### ADAM vs SGD
    Both optimization method will decrease the abs(bn) along the training.
    But Adam tends to decrease more. 
    The last 40% even drops to 1e-4 while SGD never done that.