%% face morph based on face template
function varargout = face_morph(varargin)
% FACE_MORPH MATLAB code for face_morph.fig

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @face_morph_OpeningFcn, ...
                   'gui_OutputFcn',  @face_morph_OutputFcn, ...
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


%% todo things before window visible
% --- Executes just before face_morph is made visible.
function face_morph_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to face_morph (see VARARGIN)

% Choose default command line output for face_morph
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes face_morph wait for user response (see UIRESUME)
% uiwait(handles.figure1);

set(handles.axes1,'visible','off');
set(handles.axes2,'visible','off');
set(handles.axes3,'visible','off');


% --- Outputs from this function are returned to the command line.
function varargout = face_morph_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% press button1 to select an input image
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.axes1,'visible','on');

global Face1;
global Face1_marked;
global Path1;
global Point1;

% load image
[filename,pathname]=uigetfile({'*.jpg';'*.bmp';'*.tif';'*.gif'},'Choose Image');
Path1=[pathname filename];
Face1=imread(Path1);
axes(handles.axes1);
imshow(Face1);

% mark points at Face3
pause(1);
Path1_point=strcat(Path1(1:length(Path1)-3),'pnt');
Point1=importdata(Path1_point);
Face1_marked=mark_point(Face1,Point1);
axes(handles.axes1);
imshow(Face1_marked);


%% press button2 to morph input image
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% warp Face1 based on templace Face3 to Face2
global Face1 Face2 Face3;
% Face1 and Face3 point marked
global Face1_marked Face3_marked;
% path of Face1 and Face3
global Path1 Path3;
% point of Face1 and Face3
global Point1 Point3;

% warp Face1 to Face3 store at Face2
Face2=warp(handles,Face1,Point1,Point3);
set(handles.axes2,'visible','on');
axes(handles.axes2);
imshow(Face2);


%% press button3 to select a template image
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.axes3,'visible','on');

global Face3;
global Face3_marked;
global Path3;
global Point3;

% load image
[filename,pathname]=uigetfile({'*.jpg';'*.bmp';'*.tif';'*.gif'},'Choose Image');
Path3=[pathname filename];
Face3=imread(Path3);
axes(handles.axes3);
imshow(Face3);

% mark points at Face3
pause(1);
Path3_point=strcat(Path3(1:length(Path3)-3),'pnt');
Point3=importdata(Path3_point);
Face3_marked=mark_point(Face3,Point3);
axes(handles.axes3);
imshow(Face3_marked);

%%
% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

clc;

% Hint: place code in OpeningFcn to populate axes1
