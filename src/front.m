function varargout = front(varargin)
% FRONT MATLAB code for front.fig
%      FRONT, by itself, creates a new FRONT or raises the existing
%      singleton*.
%
%      H = FRONT returns the handle to a new FRONT or the handle to
%      the existing singleton*.
%
%      FRONT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FRONT.M with the given input arguments.
%
%      FRONT('Property','Value',...) creates a new FRONT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before front_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to front_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help front

% Last Modified by GUIDE v2.5 06-Apr-2017 00:07:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @front_OpeningFcn, ...
                   'gui_OutputFcn',  @front_OutputFcn, ...
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


% --- Executes just before front is made visible.
function front_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to front (see VARARGIN)

% Choose default command line output for front
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes front wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = front_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in b_enrol.
function b_enrol_Callback(hObject, eventdata, handles)
% hObject    handle to b_enrol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
enrol

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in p_authenticate.
function p_authenticate_Callback(hObject, eventdata, handles)
% hObject    handle to p_authenticate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
authenticate
