function [shu, dzu, ash, mag, isy, dhu, ter, ims] = prayer_times_calculation(lat, lon, eot, dec, hei)
%Calculate all prayer times
%   lat     : latitude
%   lon     : longitude
%   eot     : equation of times
%   dec     : declination
%   hei     : altitude or height of selected city
%   shu     : fajr time
%   dzu     : dzuhr time
%   ash     : ashr time
%   mag     : maghrib time
%   isy     : isha time
%   dhu     : dhuha time
%   ter     : sunrise time
%   ims     : imsak time

% final variables
ltc = (105 - lon)/15;
i = dms2degrees([0 01 41.98]);
sd = dms2degrees([0 16 0]);     % semi-diameter matahari
rf = dms2degrees([0 34 30]);    % refraksi
dip = 1.76*sqrt(hei)/60;        % kerendahan ufuk (Dip)

% sun height
h_shu = -20;
h_ash = acotd(tand(lat-dec)+1);
h_mag = -(sd+dip+rf);
h_isy = -18;
h_dhu = dms2degrees([3 30 0]);
h_ter = -(sd+dip+rf);

% angle time
t_shu = angle_time(lat, dec, h_shu);
t_ash = angle_time(lat, dec, h_ash);
t_mag = angle_time(lat, dec, h_mag);
t_isy = angle_time(lat, dec, h_isy);
t_dhu = angle_time(lat, dec, h_dhu);
t_ter = angle_time(lat, dec, h_ter);

% prayer times
shu = fix(degrees2dms(12-eot-t_shu/15+ltc+i));
dzu = fix(degrees2dms(12-eot+ltc+i));
ash = fix(degrees2dms(12-eot+t_ash/15+ltc+i));
mag = fix(degrees2dms(12-eot+t_mag/15+ltc+i));
isy = fix(degrees2dms(12-eot+t_isy/15+ltc+i));
dhu = fix(degrees2dms(12-eot-t_dhu/15+ltc+i));
ter = fix(degrees2dms(12-eot-t_ter/15+ltc+i));
ims = fix(degrees2dms(dms2degrees(shu)-dms2degrees([0 10 0])));
end

