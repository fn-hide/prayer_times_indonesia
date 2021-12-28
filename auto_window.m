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


% add your comment here
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


% automatically generated function
function varargout = auto_window_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% pop-up city component function
function pu_city_Callback(hObject, eventdata, handles)

% indexing: pick long and lat from csv data with given index value
lon = handles.lon_array(handles.pu_city.Value);
lat = handles.lat_array(handles.pu_city.Value);
hei = handles.hei_array(handles.pu_city.Value);

lat_dms = degrees2dms(lat);
lon_dms = degrees2dms(lon);

% set value of latitude, longitude, and altitude entry components
set(handles.lat1, 'String', lat_dms(1));
set(handles.lat2, 'String', lat_dms(2));
set(handles.lat3, 'String', lat_dms(3));

set(handles.lon1, 'String', lon_dms(1));
set(handles.lon2, 'String', lon_dms(2));
set(handles.lon3, 'String', lon_dms(3));

set(handles.ent_alt, 'String', hei);


% function to trigger city checkbox
function cb_city_Callback(hObject, eventdata, handles)

if get(hObject, 'Value') == 1
    set(handles.pu_city, 'Enable', 'on');
else
    set(handles.pu_city, 'Enable', 'off');
end


% generate button function
function but_gen_Callback(hObject, eventdata, handles)

% get start date and end date
val_sta = datetime(get(handles.ent_sta, 'String'));
val_end = datetime(get(handles.ent_end, 'String'));

% get latitude
lat1 = str2double(get(handles.lat1, 'String'));
lat2 = str2double(get(handles.lat2, 'String'));
lat3 = str2double(get(handles.lat3, 'String'));
val_lat = dms2degrees([lat1 lat2 lat3]);

% get longitude
lon1 = str2double(get(handles.lon1, 'String'));
lon2 = str2double(get(handles.lon2, 'String'));
lon3 = str2double(get(handles.lon3, 'String'));
val_lon = dms2degrees([lon1 lon2 lon3]);

% get altitude
val_alt = str2double(get(handles.ent_alt, 'String'));

% calculate prayer times and make table from all results
data = calculate_prayer_times(...
    val_sta, val_end, ...
    val_lat, ...
    val_lon, ...
    val_alt...
);

% handle save dialog box and get full filename
[baseFileName, fullFileName] = make_save_dbox();

% Now write the table to an Excel workbook.
writetable(data, fullFileName);

% display success
success = ['Your ', baseFileName, ' file saved successfully!'];

disp(success)
msgbox(success, 'Information', 'help');


% navigate to "main_window"
function but_back_Callback(hObject, eventdata, handles)

close(auto_window);
main_window;


% open calendar ui when "but_sta" clicked
function but_sta_Callback(hObject, eventdata, handles)

show_uicalendar('start', handles);


% open calendar ui when keyboard pressed in "ent_sta" entry
function ent_sta_KeyPressFcn(hObject, eventdata, handles)

show_uicalendar('start', handles);


% open calendar ui when "but_end" clicked
function but_end_Callback(hObject, eventdata, handles)

show_uicalendar('end', handles);


% open calendar ui when keyboard pressed in "ent_end" entry
function ent_end_KeyPressFcn(hObject, eventdata, handles)

show_uicalendar('end', handles);



% ========================================================== %
% ==================USER DEFINED-FUNCTION=================== %
% ========================================================== %
function [baseFileName, fullFileName] = make_save_dbox()
% Get the name of the file that the user wants to save.
startingFolder = pwd; % Or "c:\" or wherever you want.
defaultFileName = fullfile(startingFolder, '*.xlsx');
[baseFileName, folder] = uiputfile(defaultFileName, 'Specify a file');

if baseFileName == 0
    % User clicked the Cancel button.
    return;
end

% Get base file name, so we can ignore whatever extension they may have typed in.
[~, baseFileNameNoExt, ext] = fileparts(baseFileName);
fullFileName = fullfile(folder, [baseFileNameNoExt, '.xlsx']);    % Force an extension of .xlsx.


function [data] = calculate_prayer_times(val_sta, val_end, val_lat, val_lon, val_alt)

% make date sequence from val_sta til val_end
val_dat = val_sta:val_end;

% make zeros matrix for julian date, eot, and declination
val_jul = zeros(1, length(val_dat));
val_eot = zeros(1, length(val_dat));
val_dec = zeros(1, length(val_dat));

% make cell array for calculation result
Fajr = cell(length(val_dat), 1);
Dhuhr = cell(length(val_dat), 1);
Asr = cell(length(val_dat), 1);
Maghrib = cell(length(val_dat), 1);
Isha = cell(length(val_dat), 1);
Dhuha = cell(length(val_dat), 1);
Sunrise = cell(length(val_dat), 1);
Imsak = cell(length(val_dat), 1);

% calculate prayer times each day
for i = 1:length(val_dat)
    % prepare date, eot, and declination for calculating prayer times
    val_jul(i) = juliandate(val_dat(i));
    
    eot = eo_time(val_jul(i));
    eot = dms2degrees(eot);
    val_eot(i) = eot;
    
    dec = declination(val_jul(i));
    dec = dms2degrees(dec);
    val_dec(i) = dec;
    
    % calculate prayer times
    [a, b, c, d, e, f, g, h] = prayer_times_calculation(val_lat, val_lon, val_eot(i), val_dec(i), val_alt);
    
    % arrange result and pad zeros in front of the number
    Fajr{i} = concate_dms(a);
    Dhuhr{i} = concate_dms(b);
    Asr{i} = concate_dms(c);
    Maghrib{i} = concate_dms(d);
    Isha{i} = concate_dms(e);
    Dhuha{i} = concate_dms(f);
    Sunrise{i} = concate_dms(g);
    Imsak{i} = concate_dms(h);
end

% make date sequence from "ent_sta" entry and "ent_end" entry
Date = datestr(reshape(val_dat, [length(val_dat), 1]));
data = table(Date, Imsak, Fajr, Sunrise, Dhuha, Dhuhr, Asr, Maghrib, Isha);


% function to overcome if there are conflict in date input by user
function show_uicalendar(picked, handles)

if strcmp(picked, 'start') == 1
    picked_date = handles.ent_sta;
    another_date = handles.ent_end;
else
    picked_date = handles.ent_end;
    another_date = handles.ent_sta;
end

picked_old = picked_date.String;

uicalendar('DestinationUI', {picked_date, 'String'});

disp('')
disp('Pick your date!')
i = 0;
while i ~= -1
    picked_new = picked_date.String;
    if strcmp(picked_old, picked_new) == 1
        i = i + 1;
        disp(['waiting time: ', num2str(i), 's'])
        pause(1)
    else
        if length(another_date.String) > 5
            julian_sta = juliandate(datetime(handles.ent_sta.String));
            julian_end = juliandate(datetime(handles.ent_end.String));
            if julian_sta > julian_end
                disp('Start date and End date conflict!')
                uiwait(msgbox('Start date and End date conflict!', 'Error', 'Error'));
                % call function again in here coz date conflict
                show_uicalendar(picked, handles)
            else
                disp('date picked')
            end
        else
            disp('date picked')
        end
        i = -1;
    end
end





% ========================================================== %
% ============AUTOMATICALLY GENERATED FUNCTION============== %
% ========================================================== %
function ent_sta_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pu_city_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lon3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lat3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lon2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lat2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lon1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lat1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ent_alt_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ent_end_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end