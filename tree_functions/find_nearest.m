function index=find_nearest(point,nodes)
for i=1:length(nodes)
dist(i)=distance3D(point,nodes(i,:));
end
[minim,index]=min(dist);
end

