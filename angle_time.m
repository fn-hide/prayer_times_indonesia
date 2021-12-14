function [t] = angle_time(lat, dec, h)
%Calculate angle time
%   lat     : latitude
%   dec     : declination
%   h       : sun height

T = -tand(lat)*tand(dec) + sind(h)/cosd(lat)/cosd(dec);

if T > 1
    t = 0;
else
    t = acosd(T);
end
end



