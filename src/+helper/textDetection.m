function boundingBoxes = textDetection(image,imageScale)
    % This function detects seven segment text in a given image.

    % Copyright 2021 The MathWorks, Inc.
    
    % tunable parameters
    % text confidence threshold: decide which region to be considered as text
    textThreshold = 0.7; 
    % text low-bound score: decide the boundary space around the character 
    lowText  = 0.4; 
    % link confidence threshold: decide the distance between two characters 
    % to be considered as single word
    linkThreshold = 0.4; 
    
    % download pretrained text detector
    model = helper.downloadPretrainedTextDetector;
    craftNet = model.craftNet;
    out = predict(craftNet,image);
    
    output = extractdata(squeeze(out));

    % region and affinity score maps
    regionScore = output(:,:,1);
    affinityScore= output(:,:,2);
    
    % generate quadrilateral shape bounding boxes
    bboxes = helper.getQuadBoxes(regionScore, affinityScore, textThreshold, linkThreshold, lowText);
    % coordinate adjustment
    scale = 2 * (1/imageScale);
    boundingBoxes = round(bboxes .* scale);
    
end