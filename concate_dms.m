function [str_prayer_time] = concate_dms(prayer_time)
%CONCATE_DMS Summary of this function goes here
%   Detailed explanation goes here

prayer_time = round(prayer_time);
str_prayer_time = strcat(num2str(prayer_time(1), '%02.f'), ':', num2str(prayer_time(2), '%02.f'), ':', num2str(prayer_time(3), '%02.f'));
end

