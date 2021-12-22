function [minEot, secEot] = eo_time(julianDate)
%Calculate equation of time
%   julianDate  : input must be a julian date format
%   minEot      : minutes of eot result
%   secEot      : seconds of eot result

a = julianDate-5/24;

% angleDate = 2*pi*(a-2451545)/365.25;
u = (a-2451545)/36525;
lo = mod((280.46607 + 36000.7698*u),360)*pi/180;

% use fix() to overcome dms 60 value error
eot = (-1*(1789 + 237*u)*sin(lo) - (7146 - 62*u)*cos(lo) + (9934 - 14*u)*sin(2*lo) - (29 + 5*u)*cos(2*lo) + (74 + 10*u)*sin(3*lo) + (320 - 4*u)*cos(3*lo) - 212*sin(4*lo))/1000;
minEot = fix(eot);

secEot = 60*(eot-minEot);
if secEot > 0
    secEot = secEot*1;
else 
    secEot = secEot*-1;
end
end

