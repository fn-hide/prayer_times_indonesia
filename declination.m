function [decDeg, decRad] = declination(julianDate)
%DECLINATION Summary of this function goes here
%   Detailed explanation goes here

a = julianDate-5/24;

angleDate = 2*pi*(a-2451545)/365.25;
x = 0.37877+23.264*sin((57.297*angleDate-79.547)*pi/180)+0.3812*sin((2*57.297*angleDate-82.682)*pi/180)+0.17132*sin((3*57.297*angleDate-59.722)*pi/180);

decDeg = x;
decRad = 0.0174533*x;
end

