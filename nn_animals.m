load('data.mat');

% create a neural network
net = patternnet(100);

% divided into training, validation and testing simulate
net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0;
net.divideParam.testRatio = 0.2;
%set a learning rate
net.trainParam.lr = 0.01;
rand_indices = randperm(size(X, 2));
% pca code for dimension reduction
% X = X';
% [coeff,score,latent] = pca(X);
% a = cumsum(latent)./sum(latent);
% dimension = 0;
% for i = 1:size(a)
%     if (a(i, 1) >= 0.95)
%         dimension = i;
%         break;
%     end
% end
% tranMatrix = coeff(:,1:dimension);
% X = X * tranMatrix;
% X = X';
trainData = X(:, rand_indices(1:2400));
trainLabels = y(:, rand_indices(1:2400));
testData = X(:, rand_indices(2401:end));
testLabels = y(:, rand_indices(2401:end));
% train a neural network
net = train(net, trainData, trainLabels);

% show the network
view(net);
save('nn_model.mat', 'net');

preds = net(testData);
est = vec2ind(preds) - 1;
tar = vec2ind(testLabels) - 1;

% find percentage of correct classifications
accuracy = 100*length(find(est==tar))/length(tar);
fprintf('Accuracy rate is %.2f\n', accuracy);

% confusion matrix
plotconfusion(testLabels, preds)

