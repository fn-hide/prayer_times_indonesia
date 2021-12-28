function varargout = manual_window(varargin)
% MANUAL_WINDOW MATLAB code for manual_window.fig
%       ent_date, but_date
%       pu_city, cb_city
%       lon1, lon2, lon3
%       lat1, lat2, lat3
%       ent_alt
%       ent_eot
%       ent_dec
%       but_cal
%       but_back
%      MANUAL_WINDOW, by itself, creates a new MANUAL_WINDOW or raises the existing
%      singleton*.
%
%      H = MANUAL_WINDOW returns the handle to a new MANUAL_WINDOW or the handle to
%      the existing singleton*.
%
%      MANUAL_WINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MANUAL_WINDOW.M with the given input arguments.
%
%      MANUAL_WINDOW('Property','Value',...) creates a new MANUAL_WINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before manual_window_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to manual_window_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help manual_window

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
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to manual_window (see VARARGIN)

% Choose default command line output for manual_window
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


function varargout = manual_window_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function but_cal_Callback(hObject, eventdata, handles)
% % calculate day of year
% day_year = calculate_day_year(get(handles.ent_date, 'String'));

% catch all value and store into guidata
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
shu = round(shu);
str_shu = strcat(num2str(shu(1), '%02.f'), ':', num2str(shu(2), '%02.f'), ':', num2str(shu(3), '%02.f'));
set(handles.edi_shu, 'String', str_shu);

dzu = round(dzu);
str_dzu = strcat(num2str(dzu(1), '%02.f'), ':', num2str(dzu(2), '%02.f'), ':', num2str(dzu(3), '%02.f'));
set(handles.edi_dzu, 'String', str_dzu);

ash = round(ash);
str_ash = strcat(num2str(ash(1), '%02.f'), ':', num2str(ash(2), '%02.f'), ':', num2str(ash(3), '%02.f'));
set(handles.edi_ash, 'String', str_ash);

mag = round(mag);
str_mag= strcat(num2str(mag(1), '%02.f'), ':', num2str(mag(2), '%02.f'), ':', num2str(mag(3), '%02.f'));
set(handles.edi_mag, 'String', str_mag);

isy = round(isy);
str_isy= strcat(num2str(isy(1), '%02.f'), ':', num2str(isy(2), '%02.f'), ':', num2str(isy(3), '%02.f'));
set(handles.edi_isy, 'String', str_isy);

dhu = round(dhu);
str_dhu= strcat(num2str(dhu(1), '%02.f'), ':', num2str(dhu(2), '%02.f'), ':', num2str(dhu(3), '%02.f'));
set(handles.edi_dhu, 'String', str_dhu);

ter = round(ter);
str_ter= strcat(num2str(ter(1), '%02.f'), ':', num2str(ter(2), '%02.f'), ':', num2str(ter(3), '%02.f'));
set(handles.edi_ter, 'String', str_ter);

ims = round(ims);
str_ims= strcat(num2str(ims(1), '%02.f'), ':', num2str(ims(2), '%02.f'), ':', num2str(ims(3), '%02.f'));
set(handles.edi_ims, 'String', str_ims);


function pu_city_Callback(hObject, eventdata, handles)
% set latitude and longitude entry to chosen city pop-up menu
% indexing: pick long and lat from csv data with given index value

% cit = handles.cit_array(handles.pu_city.Value);

% get lat and lon index and catch the value
lat = handles.lat_array(handles.pu_city.Value);
lon = handles.lon_array(handles.pu_city.Value);
hei = handles.hei_array(handles.pu_city.Value);

% convert ent_date String to julian date
jul = juliandate(datetime(get(handles.ent_date, 'String')));

% calculate equation of time
[minEot, secEot] = eo_time(jul);
eot = dms2degrees([0 minEot secEot]);

% calculate declination
[decDeg, decRad] = declination(jul);
dec_dms = degrees2dms(decDeg);

% lat lon into dms
lat_dms = degrees2dms(lat);
lon_dms = degrees2dms(lon);

% configure gui display
set(handles.lat1, 'String', lat_dms(1));
set(handles.lat2, 'String', lat_dms(2));
set(handles.lat3, 'String', lat_dms(3));

set(handles.lon1, 'String', lon_dms(1));
set(handles.lon2, 'String', lon_dms(2));
set(handles.lon3, 'String', lon_dms(3));

set(handles.ent_alt, 'String', hei);

set(handles.ent_eot1, 'String', 0);
set(handles.ent_eot2, 'String', minEot);
set(handles.ent_eot3, 'String', secEot);

set(handles.ent_dec1, 'String', dec_dms(1));
set(handles.ent_dec2, 'String', dec_dms(2));
set(handles.ent_dec3, 'String', dec_dms(3));

% store lat, lon, eot, and dec Value to handles
handles.lat_val = lat;
handles.lon_val = lon;
handles.alt_val = hei;
handles.val_eot = eot;
handles.val_dec = decDeg;

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
disp('but_date_callback');


% open calendar ui when keyboard pressed in "ent_date" entry
function ent_date_KeyPressFcn(hObject, eventdata, handles)

uicalendar('DestinationUI', {handles.ent_date, 'string'});
disp('ent_date_KeyPressFcn');



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