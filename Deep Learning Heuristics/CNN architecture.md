# CNN architecture heuristics
---
## Depth-wise Seperate Convolution
according to efficientnet2 paper
use this in early layer is actually slower

## Prediction layer
- no BN

## Interpolation: align_corner = True or False ?
By definition, if
- align_corner = True, the input and output tensors are aligned by the center points of their corner pixels, preserving the values at the corner pixels
- align_corner = False, the input and output tensors are aligned by the corner points of their corner pixels, and the interpolation uses edge value padding for out-of-boundary values, making this operation independent of input size when scale_factor is kept the same.

My conclusion would be: 
- when used in CNN 2x upsampling, should set to `True`, because this corresponds to how CNN do convolution with stride=2.
- when used as pure image resize, should set to `False`, because this make resized image look visually the same. also this perform better coordinate transform.

Update:
Through experiments, segmentation performs much better visually with align_corner=False, detection performs alittle better with align_corner=True

ref: https://zhuanlan.zhihu.com/p/87572724