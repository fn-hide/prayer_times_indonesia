function [dec] = declination(julianDate)
%Calculate declination
%   julianDate  : input must be a julian date format
%   decDeg      : declination result in degree
%   decRad      : declination result in radian

a = julianDate-5/24;

angleDate = 2*pi*(a-2451545)/365.25;
x = 0.37877+23.264*sin((57.297*angleDate-79.547)*pi/180)+0.3812*sin((2*57.297*angleDate-82.682)*pi/180)+0.17132*sin((3*57.297*angleDate-59.722)*pi/180);

% return values
% in degree
decDeg = x;

% % in radian
% decRad = 0.0174533*x;

dec = degrees2dms(decDeg)
end

