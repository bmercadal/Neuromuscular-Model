function [r theta]=sunflower(n, alpha)   %  example: n=500, alpha=2
    clf
    hold on
    b = round(alpha*sqrt(n));      % number of boundary points
    phi = (sqrt(5)+1)/2;           % golden ratio
    for k=1:n
        r(k) = radius(k,n,b);
        theta(k) = 2*pi*k/phi^2;
%         xp(k)=r(k)*cos(theta(k))
%         yp(k)=r(k)*sin(theta(k))
    end
end

function r = radius(k,n,b)
    if k>n-b
        r = 1;            % put on the boundary
    else
        r = sqrt(k-1/2)/sqrt(n-(b+1)/2);     % apply square root
    end
end