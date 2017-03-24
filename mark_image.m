%% mark points in an image and display their coordinate
function mark_image()

image_path='f:\face\23.jpg';
point_num=38;

image=imread(image_path);
imshow(image);

[x,y]=ginput(point_num);
x=int32(x);
y=int32(y);
[x,y]

end