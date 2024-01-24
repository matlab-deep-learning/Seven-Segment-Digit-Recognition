# Seven Segment Digit Recognition

This repository implements seven segment digit recognition in MATLAB&reg;.

[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=matlab-deep-learning/Seven-Segment-Digit-Recognition)

**Creator**: MathWorks Development

Requirements
------------  

- MATLAB R2022b or later
- Deep Learning Toolbox&trade;
- Computer Vision Toolbox&trade;
- Computer Vision Toolbox&trade; Model for Text Detection

Note: Previous MATLAB release users can use [this](https://github.com/matlab-deep-learning/Seven-Segment-Digit-Recognition/tree/previous) branch to download the pretrained models.

Overview
--------

This repository implements seven segment digit recognition using two steps. The first step detects the location of image text using [detectTextCRAFT](https://in.mathworks.com/help/vision/ref/detecttextcraft.html) function that requires Deep Learning Toolbox&trade; and Computer Vision Toolbox&trade; Model for Text Detection. The second stage uses the [OCR](https://in.mathworks.com/help/vision/ref/ocr.html) function from the Computer Vision Toolbox&trade; to recognize the digits. 

The two-step approach helps improve OCR by only processing image regions that contains text. This is useful in industrial automation applications where the digital displays are often surrounded by other objects and background content that can hinder the performance of OCR. 

Recognize Seven Segment Digits
---------------------------------------

```
% Read image.
  orgImg = imread('sevenSeg.png');
  
% Detect seven segment digits.
  bboxes = detectTextCRAFT(orgImg);

% Binarizing the image before using OCR for better results.
  I = rgb2gray(orgImg);
  BW = imbinarize(I, 'adaptive');
  BW = ~BW;
  
% Recognize seven segment digit using ocr.
  output = ocr(BW,bboxes,Model="seven-segment");
 
% Display results.
  recognizedWords = cat(1,output(:).Words);
  Iocr = insertObjectAnnotation(orgImg, 'rectangle',bboxes,recognizedWords);
  figure; imshow(Iocr);
```

<img src="images/workflow.PNG" alt ="image"/>

**Note:** To improve OCR results, see [Troubleshoot ocr Function Results](https://in.mathworks.com/help/vision/ug/troubleshoot-ocr-function-results.html).

References
---------------------------------------
[1] Baek, Y., Lee, B., Han, D., Yun, S. and Lee, H., 2019. Character region awareness for text detection. In Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition (pp. 9365-9374).

Copyright 2021-2024 The MathWorks, Inc.
