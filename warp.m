%% warp an image to template image
function out = warp(handles,in1,point1,point2)

point_num=38;
[m,n,o]=size(in1); % [400 300 3]
out=double(zeros(m,n,o));

% Delaunay triangulation
TRI = delaunay(point1(:,2),point1(:,1));

%percentage of origin image and template image
p1=0.2;
p2=0.8;
% points combine point1 and point2
stat=point1;
for i=1:point_num
    stat(i,1)=round(p1*point1(i,1)+p2*point2(i,1));
    stat(i,2)=round(p1*point1(i,2)+p2*point2(i,2));
end

% set every point of merged image
for k = 1:size(TRI,1) % every triangle
    [minX,maxX]=min_max_3(stat(TRI(k,1),2),stat(TRI(k,2),2),stat(TRI(k,3),2));
    [minY,maxY]=min_max_3(stat(TRI(k,1),1),stat(TRI(k,2),1),stat(TRI(k,3),1));
    
    % triangle vertex's x and y
    mX=stat(TRI(k,:),2);
    mY=stat(TRI(k,:),1);
    
    % convert progin image
    m0 = [mX, mY, ones(3, 1)]';
    m1=[point1(TRI(k,:),2),point1(TRI(k,:),1),ones(3,1)]';
    tran1 = m1 * m0^-1;
    
    for x=minX:maxX
        for y=minY:maxY
            % if point [x,y] in triangle
            if inpolygon(x, y, mX, mY)
%                 pos1 = tran1 * [x; y; 1];
%                 % write points color to out
%                 out(x,y,:)=in1(round(pos1(1,1)),round(pos1(2,1)),:);
%                 [x,y]
                xx=tran1(1,1)*x+tran1(1,2)*y+tran1(1,3)*1;
                yy=tran1(2,1)*x+tran1(2,2)*y+tran1(2,3)*1;
                out(x,y,:)=in1(round(xx),round(yy),:);
            end
        end
    end
    
    set(handles.axes2,'visible','on');
    axes(handles.axes2);
    imshow(uint8(out));
end

out=uint8(out);

end

%% min and max value of three numbers
function [minn,maxx] = min_max_3(a,b,c)

minn=min(a,b);
minn=min(minn,c);
maxx=max(a,b);
maxx=max(maxx,c);

end