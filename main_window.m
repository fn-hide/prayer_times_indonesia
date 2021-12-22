function varargout = main_window(varargin)
% MAIN_WINDOW MATLAB code for main_window.fig
%      MAIN_WINDOW, by itself, creates a new MAIN_WINDOW or raises the existing
%      singleton*.
%
%      H = MAIN_WINDOW returns the handle to a new MAIN_WINDOW or the handle to
%      the existing singleton*.
%
%      MAIN_WINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_WINDOW.M with the given input arguments.
%
%      MAIN_WINDOW('Property','Value',...) creates a new MAIN_WINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_window_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_window_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_window

% Last Modified by GUIDE v2.5 28-Nov-2021 12:48:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_window_OpeningFcn, ...
                   'gui_OutputFcn',  @main_window_OutputFcn, ...
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


function main_window_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_window (see VARARGIN)

% Choose default command line output for main_window
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


function varargout = main_window_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function manual_Callback(hObject, eventdata, handles)

close(main_window);
manual_window;


function auto_Callback(hObject, eventdata, handles)

close(main_window);
auto_window;
