% a function used to standardize the imagesize
function output = imagesize(input)
    input = imread(input);
    if numel(size(input)) == 2
           input = cat(3,input,input,input);% change into three channel
    end
    output = imresize(input, [227 227]);
end