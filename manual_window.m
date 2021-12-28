function varargout = manual_window(varargin)
% MANUAL_WINDOW MATLAB code for manual_window.fig
%       lat = latitude
%       lon = longitude
%       alt = altitude
%       pu_city = city pop-up component
%       but_cal = calculate button component
% Last Modified by GUIDE v2.5 14-Dec-2021 12:39:30
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @manual_window_OpeningFcn, ...
                   'gui_OutputFcn',  @manual_window_OutputFcn, ...
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
% End initialization code - DO NOT EDIT



function manual_window_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% read csv for lat, lon, and alt of 87 city in Indonesia
lat_lon_cit = readmatrix('latitude_longitude_city.csv', ...
    'OutputType', 'string');

cit_array = lat_lon_cit(:, 1);
lat_array = str2double(lat_lon_cit(:, 2));
lon_array = str2double(lat_lon_cit(:, 3));
hei_array = str2double(lat_lon_cit(:, 4));

% make lat, lon, and alt to be handles attributes
handles.cit_array = cit_array;
handles.lat_array = lat_array;
handles.lon_array = lon_array;
handles.hei_array = hei_array;

% input cities name into pu_city
set(handles.pu_city, 'String', handles.cit_array);

% update handles attributes
guidata(hObject, handles);


function varargout = manual_window_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function but_cal_Callback(hObject, eventdata, handles)

% get values from all entries and store its into handles guidata
handles.val_date = get(handles.ent_date, 'String');

lat1 = str2double(get(handles.lat1, 'String'));
lat2 = str2double(get(handles.lat2, 'String'));
lat3 = str2double(get(handles.lat3, 'String'));
handles.val_lat = dms2degrees([lat1 lat2 lat3]);

lon1 = str2double(get(handles.lon1, 'String'));
lon2 = str2double(get(handles.lon2, 'String'));
lon3 = str2double(get(handles.lon3, 'String'));
handles.val_lon = dms2degrees([lon1 lon2 lon3]);

handles.val_alt = str2double(get(handles.ent_alt, 'String'));

eot1 = str2double(get(handles.ent_eot1, 'String'));
eot2 = str2double(get(handles.ent_eot2, 'String'));
eot3 = str2double(get(handles.ent_eot3, 'String'));
handles.val_eot = dms2degrees([eot1 eot2 eot3]);

dec1 = str2double(get(handles.ent_dec1, 'String'));
dec2 = str2double(get(handles.ent_dec2, 'String'));
dec3 = str2double(get(handles.ent_dec3, 'String'));
handles.val_dec = dms2degrees([dec1 dec2 dec3]);

guidata(hObject, handles);

% calculate prayer times
[shu, dzu, ash, mag, isy, dhu, ter, ims] = prayer_times_calculation(handles.val_lat, handles.val_lon, handles.val_eot, handles.val_dec, handles.val_alt);

% insert result into gui label
str_shu = concate_dms(shu);
set(handles.edi_shu, 'String', str_shu);

str_dzu = concate_dms(dzu);
set(handles.edi_dzu, 'String', str_dzu);

str_ash = concate_dms(ash);
set(handles.edi_ash, 'String', str_ash);

str_mag = concate_dms(mag);
set(handles.edi_mag, 'String', str_mag);

str_isy = concate_dms(isy);
set(handles.edi_isy, 'String', str_isy);

str_dhu = concate_dms(dhu);
set(handles.edi_dhu, 'String', str_dhu);

str_ter = concate_dms(ter);
set(handles.edi_ter, 'String', str_ter);

str_ims = concate_dms(ims);
set(handles.edi_ims, 'String', str_ims);


function pu_city_Callback(hObject, eventdata, handles)

% set lat, lon, and alt entries to chosen city from pu_city
lat = handles.lat_array(handles.pu_city.Value);
lon = handles.lon_array(handles.pu_city.Value);
hei = handles.hei_array(handles.pu_city.Value);

% lat lon into dms
lat_dms = degrees2dms(lat);
lon_dms = degrees2dms(lon);

% convert ent_date String to julian date
jul = juliandate(datetime(get(handles.ent_date, 'String')));
% calculate equation of time --> result will be dms format
eot = eo_time(jul);
% calculate declination --> result will be dms format
dec = declination(jul);

% configure gui display
set(handles.lat1, 'String', lat_dms(1));
set(handles.lat2, 'String', lat_dms(2));
set(handles.lat3, 'String', lat_dms(3));

set(handles.lon1, 'String', lon_dms(1));
set(handles.lon2, 'String', lon_dms(2));
set(handles.lon3, 'String', lon_dms(3));

set(handles.ent_alt, 'String', hei);

set(handles.ent_eot1, 'String', eot(1));
set(handles.ent_eot2, 'String', eot(2));
set(handles.ent_eot3, 'String', eot(3));

set(handles.ent_dec1, 'String', dec(1));
set(handles.ent_dec2, 'String', dec(2));
set(handles.ent_dec3, 'String', dec(3));

% store lat, lon, alt, eot, and dec Value to handles
handles.lat_val = lat;
handles.lon_val = lon;
handles.alt_val = hei;
handles.val_eot = dms2degrees(eot);
handles.val_dec = dms2degrees(dec);

% update guidata
guidata(hObject, handles);


% trigger city checkbox
function cb_city_Callback(hObject, eventdata, handles)

if get(hObject, 'Value') == 1
    set(handles.pu_city, 'Enable', 'on');
else
    set(handles.pu_city, 'Enable', 'off');
end


% navigate to "main_window"
function but_back_Callback(hObject, eventdata, handles)

close(manual_window);
main_window;


% open calendar ui when "but_date" clicked
function but_date_Callback(hObject, eventdata, handles)

uicalendar('DestinationUI', {handles.ent_date, 'String'});


% open calendar ui when keyboard pressed in "ent_date" entry
function ent_date_KeyPressFcn(hObject, eventdata, handles)

uicalendar('DestinationUI', {handles.ent_date, 'string'});



%                                                            %
%                                                            %
% ====== other functions that generated automatically ====== %
function ent_eot_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ent_dec_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lon1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function entry_latitude_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ent_alt_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function entry_city_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ent_date_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lon2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lon3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lat1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lat2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lat3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function menu_city_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pu_city_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ent_eot3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ent_eot2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ent_eot1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ent_dec3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ent_dec2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ent_dec1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% ====== end line ======