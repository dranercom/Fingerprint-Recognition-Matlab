function varargout = authenticate(varargin)
%AUTHENTICATE M-file for authenticate.fig
%      AUTHENTICATE, by itself, creates a new AUTHENTICATE or raises the existing
%      singleton*.
%
%      H = AUTHENTICATE returns the handle to a new AUTHENTICATE or the handle to
%      the existing singleton*.
%
%      AUTHENTICATE('Property','Value',...) creates a new AUTHENTICATE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to authenticate_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      AUTHENTICATE('CALLBACK') and AUTHENTICATE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in AUTHENTICATE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help authenticate

% Last Modified by GUIDE v2.5 08-Apr-2017 21:27:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @authenticate_OpeningFcn, ...
                   'gui_OutputFcn',  @authenticate_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before authenticate is made visible.
function authenticate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for authenticate
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes authenticate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = authenticate_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function t_f_Callback(hObject, eventdata, handles)
% hObject    handle to t_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t_f as text
%        str2double(get(hObject,'String')) returns contents of t_f as a double


% --- Executes during object creation, after setting all properties.
function t_f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in b_f.
function b_f_Callback(hObject, eventdata, handles)
% hObject    handle to b_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename2, pathname2] = ...
    uigetfile('*.tif','Select second fingerprint', ...
    'D:\College\S6\Mini Project\Databases\FVC 2002\DB1');
set(handles.t_f, 'string', [pathname2 filename2]);

% --- Executes on button press in b_authenticate.
function b_authenticate_Callback(hObject, eventdata, handles)
% hObject    handle to b_authenticate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% read fingerprint for authentication
set(handles.t_header, 'string', '');
drawnow();
path = get(handles.t_f, 'string');
img1 = imread(path);
imshow(img1);title('Input');

fprintf(['>> Beginning extraction process\n']);
set(hObject, 'string', 'Extracting minutiae...');
drawnow();
inp_minutiae = ext_finger(img1, 1);
fprintf(['done!\n']);


fprintf(['>> Comparing against database... ']);
set(hObject, 'string', 'Comparing against database... ');
drawnow();
load database person minutiae

uniq = unique(minutiae(:, 1));
r = size(uniq(:, :));
k = size(minutiae(:, :));
uniq = table2struct(uniq);
uniq = struct2cell(uniq);

first = minutiae(:, 1);
first = table2struct(first);
first = struct2cell(first);
s = 0;

for i=1:r
    temp_struct = struct('X', [], 'Y', [], 'Type', [], 'Angle', [],'S1', [], 'S2', []);
    for j=1:k
        % build temporary structure of minutiae pertaining to a fingerprint
        if strcmp(uniq(i), first(j))
            p = size(temp_struct);
            if p==0
                temp_struct = table2struct(minutiae(j, 2:7));
            else
                temp_struct = [temp_struct; table2struct(minutiae(j, 2:7))];
            end;
        end;
    end;
        
    % getting match score
    temp_struct = transpose(cell2mat(struct2cell(temp_struct)));
    if s==0
        s = match(inp_minutiae, temp_struct);
    else
        s = horzcat(s, match(inp_minutiae, temp_struct));
    end;
        
end;

maxim = max(s);
len = length(s);
for i=1:len
    if s(i)==maxim
        break;
    end;
end;


if (maxim<0.48) 
    fprintf(['>> No match found for given fingerprint.\n']);
    set(handles.t_header, 'string', 'No match found.');
    drawnow();
else
    x = round(i/2);
    name = char(struct2cell(table2struct(person(x, 1))));
    fprintf(['done!\n>> Found fingerprint! Welcome ' name '!\n']);
    set(handles.t_header, 'string', ['Authenticated, hello ' name '!']);
    drawnow();
end;

set(hObject, 'string', 'Authenticate');


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
