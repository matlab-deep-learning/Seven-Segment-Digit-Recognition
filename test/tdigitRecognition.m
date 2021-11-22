classdef(SharedTestFixtures = {DownloadPretrainedCRAFTFixture}) tdigitRecognition < matlab.unittest.TestCase
    % Test for TextDetection
    
    % Copyright 2021 The MathWorks, Inc.
    
    % The shared test fixture downloads the model. Here we check the
    % inference on the pretrained model.
    properties        
        RepoRoot = getRepoRoot;        
    end
    methods(TestClassSetup)
        function setupWorkingDir(test)
            import matlab.unittest.fixtures.CurrentFolderFixture;
            test.applyFixture(CurrentFolderFixture ...
                (getRepoRoot()));
        end
    end
    
    methods(Test)
        function exerciseDetection(test)            
           
            inpImage = imread(fullfile(test.RepoRoot,'images','sevenSeg.png'));

            expectedBBoxes = [59 95 135 41];
            %Pre process
            [image, imageScale] = helper.preprocess(inpImage);
           
            %Detect seven segment digits
            boundingBoxes = helper.textDetection(image,imageScale);
            
            % Recognize seven segment digit using ocr.
            roi = boundingBoxes;
            txt = ocr(inpImage, roi,'TextLayout','block','Language','src/tessdata/seven-segment.traineddata');
            words = [txt(:).Words];
            
            test.verifyEqual(boundingBoxes,expectedBBoxes,'AbsTol',double(1e-4));
        end      
    end
end