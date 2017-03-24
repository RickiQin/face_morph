%% load and mark point of an image
function out = mark_point(in,point)

point_color=[255,0,0]; % point RGB
out=in;
[m,n,~]=size(in);

for i=1:38 % mark a point
    % [x,y] order in opencv and matlab are differrent
    y=point(i,1);
    x=point(i,2);
    if x>1 && x<m && y>1 && y<n
        % rect with width of 5
        width=2;
        for xx=x-width:x+width
            for yy=y-width:y+width
                out(xx,yy,:)=point_color(:);
            end
        end
    end
end

end