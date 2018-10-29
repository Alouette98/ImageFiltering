function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% when operating in convolution mode. See 'help imfilter'. 
% While "correlation" and "convolution" are both called filtering, 
% there is a difference. From 'help filter2':
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should meet the requirements laid out on the project webpage.

% Boundary handling can be tricky as the filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% we look at 'help imfilter', we see that there are several options to deal 
% with boundaries. 
% Please recreate the default behavior of imfilter:
% to pad the input image with zeros, and return a filtered image which matches 
% the input image resolution. 
% A better approach is to mirror or reflect the image content in the padding.

% Uncomment to call imfilter to see the desired behavior.
% output = imfilter(image, filter, 'conv');

%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%

% Computer Vision Project 1


output = [];


% % ===== Extend Image array ====

image_height = size(image,1);
image_width = size(image,2);
colors = size(image,3);
filter_height = size(filter,1);
filter_width = size(filter,2);
new_rows = floor((filter_height - 1)/2); 
new_cols = floor((filter_width - 1)/2);
new_image = padarray(image, [new_rows new_cols]);

% rotate the filter by 90d counter-clockwised
filter = rot90(filter,2);  

for i = 1 : colors
    for j =  1+new_rows : new_rows+image_height
        for k = 1+new_cols : new_cols+image_width
            output(j-new_rows,k-new_cols,i)= fil([j k i],new_image,filter);
        end
    end
end
end

function new_pixel_val = fil(data, input_image, filter)
    filter_height = size(filter,1);
    filter_width = size(filter,2);
    
    colors = data(3);
    
    row_low = data(1) - floor(filter_height/2);
    col_low = data(2) - floor(filter_width/2);
    row_upp = data(1) + floor(filter_height/2);
    col_upp = data(2) + floor(filter_width/2);
    
    sub_mat = input_image(row_low:row_upp, col_low:col_upp, colors);
    
    new_pixel_val = sum(sum(sub_mat.*filter));
end
