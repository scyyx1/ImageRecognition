net = alexnet;
trainsferLayer = net.Layers(1:end-3);

imds = imageDatastore('animal',...
    'includeSubfolders',true,...
    'labelsource','foldernames','ReadFcn',@imagesize);
T = countEachLabel(imds);
disp(T);
[imdsTrain,imdsTest] = splitEachLabel(imds,0.75);

%% train
layers = [trainsferLayer;
    fullyConnectedLayer(3,'WeightLearnRateFactor',50,'BiasLearnRateFactor',50);
    softmaxLayer();
    classificationLayer()];
options = trainingOptions('sgdm',...
    'Plots','training-progress', ...
    'Maxepochs',5,...
    'InitialLearnRate',0.0001);
network = trainNetwork(imdsTrain,layers,options);

%% predict
predictLabels = classify(network,imdsTest);
testLabels = imdsTest.Labels;

accuracy = sum(predictLabels == testLabels)/numel(predictLabels);
disp(['accuracy:',num2str(accuracy)]);
plotconfusion(testLabels, predictLabels);