function dir=calculate_direction(p1,p2)
distance=distance3D(p1,p2);
dir(1)=(p2(1)-p1(1))/distance;
dir(2)=(p2(2)-p1(2))/distance;
dir(3)=(p2(3)-p1(3))/distance;
end