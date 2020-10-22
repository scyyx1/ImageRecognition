%select all the images from animals
list = dir(fullfile('animals', '*.jpg'));
%goto animals file
cd('animals');
%set a dataset X to put all data
X = [];
for i = 1 : length(list)
    image = imread(list(i).name); 
    imgray = rgb2gray(image); %convert RGB images into grayscale images
    imnew = imresize(imgray,[50 50]); %resize the image to 50 * 50
    newmap = reshape(imnew, 1, []); %reshape the array from 2D to 1D
    normimage = im2double(newmap); % Normalize the image value.
    newmap = normimage';
    X(:, i) = newmap';
end
%set up label 1 2 and 3 put it in y where 2 stands for 0104
a = 1;
b = 2;
c = 3;
y = [repmat(a, 1, 1000) , repmat(b, 1, 1000), repmat(c, 1, 1000)];
y = full(ind2vec(y));
cd ../
save('data.mat','X','y');
