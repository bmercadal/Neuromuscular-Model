function old=old_dir(neuropoints,node)
%calculates the previous direction of the tree from the desired node
%(r,theeta,phi)
parent=neuropoints(node,5);
point1=[neuropoints(node,1) neuropoints(node,2) neuropoints(node,3)];
point2=[neuropoints(parent,1) neuropoints(parent,2) neuropoints(parent,3)];
delta=point1-point2;
old(1)=sqrt(sum(delta.^2));
old(2)=acos(delta(3)/old(1));
old(3)=atan2(delta(2),delta(1));
end