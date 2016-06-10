function [ cost ] = costFunction( predMask, E, m, p )
%COSTFUNCTION Summary of this function goes here
%   Detailed explanation goes here

shape = generateShape(E, m, p(1:end-4), p(end-3), p(end-2), p(end-1), p(end))';
[x,y] = find(predMask);
[~,d] = knnsearch([x y],shape);
cost = sum(d);
end

