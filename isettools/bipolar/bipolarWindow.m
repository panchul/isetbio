function varargout = bipolarWindow(varargin)
% BIPOLARWINDOW MATLAB code for bipolarWindow.fig
%      BIPOLARWINDOW, by itself, creates a new BIPOLARWINDOW or raises the existing
%      singleton*.
%
%      H = BIPOLARWINDOW returns the handle to a new BIPOLARWINDOW or the handle to
%      the existing singleton*.
%
%      BIPOLARWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BIPOLARWINDOW.M with the given input arguments.
%
%      BIPOLARWINDOW('Property','Value',...) creates a new BIPOLARWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bipolarWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bipolarWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bipolarWindow

% Last Modified by GUIDE v2.5 17-Mar-2017 16:19:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bipolarWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @bipolarWindow_OutputFcn, ...
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
end

% --- Executes just before bipolarWindow is made visible.
function bipolarWindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bipolarWindow (see VARARGIN)

% check inputs and get the bipolar object
if isempty(varargin) || ~isa(varargin{1}, 'bipolar')
    error('bipolar object required');
end
bp = varargin{1};
bp.figureHandle = hObject;   % Store this figure handle

% Choose default command line output for bipolarWindow
handles.output = hObject;
handles.bipolar = varargin{1};
% handles.spikesMovie = [];  % spike movie

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bipolarWindow wait for user response (see UIRESUME)
% uiwait(handles.bipolarWindow);

% Refresh/Initialize window information
bipolarWindowRefresh(handles);

% Very important for good rendering speed
set(hObject, 'Renderer', 'OpenGL')

end

% --- Outputs from this function are returned to the command line.
function varargout = bipolarWindow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --------------------------------------------------------------------
function menuFile_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function menuEdit_Callback(hObject, eventdata, handles)
% hObject    handle to menuEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% handles.linearMov = [];
% handles.psthMov = [];
end

% --------------------------------------------------------------------
function menuPlot_Callback(hObject, eventdata, handles)
% hObject    handle to menuPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function menuMosaic_Callback(hObject, eventdata, handles)
% hObject    handle to menuMosaic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function menuAnalyze_Callback(hObject, eventdata, handles)
% hObject    handle to menuAnalyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --- Executes on selection change in popupResponseSelect.
function popupResponseSelect_Callback(hObject, eventdata, handles)
% Popup over main response window
%
% hObject    handle to popupResponseSelect (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupResponseSelect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupResponseSelect

% These are all the strings in the popup
contents = cellstr(get(hObject,'String'));

% This is the selected string
str = contents{get(hObject,'Value')};

% Clear the axis in the image
cla

switch str

    case 'Bipolar mean (image)'
        handles.bipolar.plot('response image');
         
    case 'Bipolar plot'
        handles.bipolar.plot('response');
        
    case 'Bipolar movie'
        handles.bipolar.plot('movieResponse');
        
    otherwise
        error('Unknown string %s\n',str);
end

end

% --- Executes during object creation, after setting all properties.
function popupResponseSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupResponseSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end


% --------------------------------------------------------------------
% function menuPlotPSTH_Callback(hObject, eventdata, handles)
% % Plot | PSTH
% %
% % hObject    handle to menuPlotPSTH (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% disp('Plot | PSTH')
% end

% --------------------------------------------------------------------
function menFileSave_Callback(hObject, eventdata, handles)
% File | Save
%
% hObject    handle to menFileSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Save')
end

% --------------------------------------------------------------------
function menuFileRefresh_Callback(hObject, eventdata, handles)
% hObject    handle to menuFileRefresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bipolarWindowRefresh(handles)
end

% --------------------------------------------------------------------
function menuFileClose_Callback(hObject, eventdata, handles)
% File | Close
% hObject    handle to menuFileClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.bp.figureHandle = [];
delete(handles.bipolarWindow);
end

%% Internal functions

function bipolarWindowRefresh(handles)
% Update all the text fields and such with the data in the mosaic

bp  = handles.bipolar;
fig   = figure(bp.figureHandle);
gdata = guidata(fig);

% Show the appropriate response axis plot
axes(gdata.axisResponse);
cla(gdata.axisResponse,'reset');

% Selected string in the popup
contents = cellstr(get(gdata.popupResponseSelect,'String'));
str = contents{get(gdata.popupResponseSelect,'Value')};
switch(str)
    case 'Bipolar mean (image)'
        gdata.bipolar.plot('response image');
         
    case 'Bipolar plot'
        gdata.bipolar.plot('response');
        
    case 'Bipolar movie'
        gdata.bipolar.plot('movieResponse');
        
    otherwise
        error('Unknown plot type %s\n',str);
end

% % Make a button for rfOverlay
% rfOverlay = false;
% if rfOverlay
%     bp.plot('mosaic');
% end

% % Text description
% str = bp.describe;
% set(gdata.bipolarProperties,'string',str);

end


% --- Executes on button press in btnPlayPause.
function btnPlayPause_Callback(hObject, eventdata, handles)
% hObject    handle to btnPlayPause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of btnPlayPause
end

% --- Executes on slider movement.
function sliderMovieProgress_Callback(hObject, eventdata, handles)
% hObject    handle to sliderMovieProgress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
end

% --- Executes during object creation, after setting all properties.
function sliderMovieProgress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderMovieProgress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end
