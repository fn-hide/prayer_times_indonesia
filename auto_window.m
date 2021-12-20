function varargout = auto_window(varargin)
% AUTO_WINDOW MATLAB code for auto_window.fig
% Last Modified by GUIDE v2.5 14-Dec-2021 13:30:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @auto_window_OpeningFcn, ...
                   'gui_OutputFcn',  @auto_window_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function auto_window_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% latitude longitude of 87 city
lat_lon_cit = readmatrix('latitude_longitude_city.csv', ...
    'OutputType', 'string');

% array of city, latitude, and longitude
cit_array = lat_lon_cit(:, 1);
lat_array = str2double(lat_lon_cit(:, 2));
lon_array = str2double(lat_lon_cit(:, 3));
hei_array = str2double(lat_lon_cit(:, 4));

% store cit, lat, and lon in handles
handles.cit_array = cit_array;
handles.lat_array = lat_array;
handles.lon_array = lon_array;
handles.hei_array = hei_array;

set(handles.pu_city, 'String', handles.cit_array);
% Update handles structure
guidata(hObject, handles);


function varargout = auto_window_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function ent_sta_Callback(hObject, eventdata, handles)



function ent_sta_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function but_sta_Callback(hObject, eventdata, handles)

uicalendar('DestinationUI', {handles.ent_sta, 'String'});


function pu_city_Callback(hObject, eventdata, handles)
% indexing: pick long and lat from csv data with given index value
lon = handles.lon_array(handles.pu_city.Value);
lat = handles.lat_array(handles.pu_city.Value);
hei = handles.hei_array(handles.pu_city.Value);

lat_dms = degrees2dms(lat);
lon_dms = degrees2dms(lon);

set(handles.lat1, 'String', lat_dms(1));
set(handles.lat2, 'String', lat_dms(2));
set(handles.lat3, 'String', lat_dms(3));

set(handles.lon1, 'String', lon_dms(1));
set(handles.lon2, 'String', lon_dms(2));
set(handles.lon3, 'String', lon_dms(3));

set(handles.ent_alt, 'String', hei);


function pu_city_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function cb_city_Callback(hObject, eventdata, handles)

if get(hObject, 'Value') == 1
    set(handles.pu_city, 'Enable', 'on');
else
    set(handles.pu_city, 'Enable', 'off');
end


function lon3_Callback(hObject, eventdata, handles)



function lon3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lat3_Callback(hObject, eventdata, handles)



function lat3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lon2_Callback(hObject, eventdata, handles)



function lon2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lat2_Callback(hObject, eventdata, handles)



function lat2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lon1_Callback(hObject, eventdata, handles)



function lon1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lat1_Callback(hObject, eventdata, handles)



function lat1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function but_gen_Callback(hObject, eventdata, handles)
val_sta = datetime(get(handles.ent_sta, 'String'));
val_end = datetime(get(handles.ent_end, 'String'));

val_dat = val_sta:val_end;
val_jul = zeros(1, length(val_dat));
val_eot = zeros(1, length(val_dat));
val_dec = zeros(1, length(val_dat));

Fajr = cell(length(val_dat), 1);
Dhuhr = cell(length(val_dat), 1);
Asr = cell(length(val_dat), 1);
Maghrib = cell(length(val_dat), 1);
Isha = cell(length(val_dat), 1);
Dhuha = cell(length(val_dat), 1);
Sunrise = cell(length(val_dat), 1);
Imsak = cell(length(val_dat), 1);

lat1 = str2double(get(handles.lat1, 'String'));
lat2 = str2double(get(handles.lat2, 'String'));
lat3 = str2double(get(handles.lat3, 'String'));
val_lat = dms2degrees([lat1 lat2 lat3]);

lon1 = str2double(get(handles.lon1, 'String'));
lon2 = str2double(get(handles.lon2, 'String'));
lon3 = str2double(get(handles.lon3, 'String'));
val_lon = dms2degrees([lon1 lon2 lon3]);

val_alt = str2double(get(handles.ent_alt, 'String'));

for i = 1:length(val_dat)
    val_jul(i) = juliandate(val_dat(i));
    
    [minEot, secEot] = eo_time(val_jul(i));
    eot = dms2degrees([0 minEot secEot]);
    val_eot(i) = eot;
    
    [decDeg, decRad] = declination(val_jul(i));
    val_dec(i) = decDeg;
    
    [a, b, c, d, e, f, g, h] = prayer_times_calculation(val_lat, val_lon, val_eot(i), val_dec(i), val_alt);
    Fajr{i} = strcat(num2str(a(1)), ":", num2str(a(2)), ":", num2str(a(3)));
    Dhuhr{i} = strcat(num2str(b(1)), ":", num2str(b(2)), ":", num2str(b(3)));
    Asr{i} = strcat(num2str(c(1)), ":", num2str(c(2)), ":", num2str(c(3)));
    Maghrib{i} = strcat(num2str(d(1)), ":", num2str(d(2)), ":", num2str(d(3)));
    Isha{i} = strcat(num2str(e(1)), ":", num2str(e(2)), ":", num2str(e(3)));
    Dhuha{i} = strcat(num2str(f(1)), ":", num2str(f(2)), ":", num2str(f(3)));
    Sunrise{i} = strcat(num2str(g(1)), ":", num2str(g(2)), ":", num2str(g(3)));
    Imsak{i} = strcat(num2str(h(1)), ":", num2str(h(2)), ":", num2str(h(3)));
end

% disp('shu')
% disp(Fajr)
% disp('dzu')
% disp(Dhuhr)
% disp('ash')
% disp(Asr)
% disp('mag')
% disp(Maghrib)
% disp('isy')
% disp(Isha)
% disp('dhu')
% disp(Dhuha)
% disp('ter')
% disp(Sunrise)
% disp('ims')
% disp(Imsak)

Date = datestr(reshape(val_dat, [length(val_dat), 1]));

data = table(Date, Imsak, Fajr, Sunrise, Dhuha, Dhuhr, Asr, Maghrib, Isha);

prompt = {'Name your file:'};
dlgtitle = 'Generate';
dims = [1 35];
definput = {'Prayer Times'};
answer = inputdlg(prompt,dlgtitle,dims,definput);

pt_filename = strcat(answer{1}, '.xlsx');

writetable(data, pt_filename);


function but_back_Callback(hObject, eventdata, handles)

close(auto_window);
main_window;


function ent_sta_KeyPressFcn(hObject, eventdata, handles)

uicalendar('DestinationUI', {handles.ent_sta, 'string'});



function ent_alt_Callback(hObject, eventdata, handles)



function ent_alt_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ent_end_Callback(hObject, eventdata, handles)



function ent_end_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function but_end_Callback(hObject, eventdata, handles)

uicalendar('DestinationUI', {handles.ent_end, 'String'});


function ent_end_KeyPressFcn(hObject, eventdata, handles)

uicalendar('DestinationUI', {handles.ent_end, 'string'});
