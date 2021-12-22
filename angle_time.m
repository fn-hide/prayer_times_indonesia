function [t] = angle_time(lat, dec, h)
%Calculate angle time
%   lat     : latitude
%   dec     : declination
%   h       : sun height
%   t       : angle time

T = -tand(lat)*tand(dec) + sind(h)/cosd(lat)/cosd(dec);

% overcome arccos error because cos value more than 1
if T > 1
    t = 0;
else
    t = acosd(T);
end
end



