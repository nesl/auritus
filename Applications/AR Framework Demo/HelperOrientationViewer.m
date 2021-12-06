classdef HelperOrientationViewer < matlab.System
%HelperOrientationViewer - Orientation visualization
%
%   % EXAMPLE: Visualize fused orientation data.
%
%   fused = quaternion(1,0,0,0);
%   viewer = HelperOrientationViewer;
%   viewer(fused)

%   Copyright 2017-2018 The MathWorks, Inc.

    properties
        Title = {''}
    end

    properties (Nontunable) %(Access = private, Nontunable)
        NumInputs = 1;
    end

    properties (Access = private)
        pVisualizationObjects;
        IsTopLevelUI = false;
    end

    properties (Hidden)
        AppWindow;

        AxesPosition = [0.1300 0.1100 0.7750 0.8150];
    end
    
    properties (Access = private, Constant)
        BorderHeight = 0.05;
    end

    methods
        % Constructor
        function obj = HelperOrientationViewer(varargin)
            setProperties(obj,nargin,varargin{:});
            createUI(obj);
        end

        % Destructor
        function delete(obj)
            fig = obj.AppWindow;
            if (obj.IsTopLevelUI && ~isempty(fig) && ishghandle(fig))
                delete(fig);
            end
        end

        function show(obj)
            fig = obj.AppWindow;
            if (obj.IsTopLevelUI && ~isempty(fig) && ishghandle(fig))
                fig.Visible = 'on';
            end
        end

        function hide(obj)
            set(obj.AppWindow,'Visible','off');
        end
    end

    methods (Access = protected)
        function setupImpl(obj, varargin)
            %Clear out any existing visualization objects
            for ii=1:numel(obj.pVisualizationObjects)
                deleteAxes(obj.pVisualizationObjects);
            end
            
            numInputs = numel(varargin);

            fig = obj.AppWindow;
            appPosition = obj.AxesPosition;

            if (numInputs == 1)
                borderHeight = 0;
            else
                borderHeight = obj.BorderHeight;
            end
            
            currAxesPosition = appPosition;
            axesHeight = (appPosition(4)-borderHeight*(numInputs+1)) / numInputs;
            currAxesPosition(2) = currAxesPosition(2) + borderHeight;
            currAxesPosition(4) = axesHeight;

            t = obj.Title;
            nt= numel(t);
            for nn = (nt+1):numInputs %Fill in missing titles with ''
                t{nn} = '';
            end
            for i = 1:numInputs
                vizObjs{i} = HelperBox(fig, currAxesPosition, t{i} , i ); %#ok<AGROW>
                currAxesPosition(2) = currAxesPosition(2) + axesHeight + borderHeight;
            end

            obj.NumInputs = numInputs;
            obj.pVisualizationObjects = [vizObjs{:}];
            syncRotationCallback(obj.pVisualizationObjects);
            show(obj);
        end

        function val = getNumInputsImpl(obj)
            val = obj.NumInputs;
        end

        function stepImpl(obj, varargin)
            vizObjs = obj.pVisualizationObjects;
            numInputs = obj.NumInputs;
            assert(numInputs == numel(varargin));
            for i = numInputs:-1:1
                q(:,i) = varargin{i};
            end
            for sampleNum = 1:size(q, 1)
                for i = 1:numInputs
                    update(vizObjs(i), q(sampleNum,i));
                end
                drawnow limitrate;
            end
        end
        
    end

    methods (Access = private)
        function createUI(obj)
            createAppWindow(obj);
        end

        function createAppWindow(obj)
            fig = obj.AppWindow;
            if (isempty(fig) || ~ishghandle(fig))
                fig = figure('Name', 'Orientation Viewer', ...
                             'NumberTitle', 'off', ...
                             'DockControls','off', ...
                             'Units', 'normalized', ...
                             'OuterPosition', [0 0.5 0.25 0.5], ...
                             'Visible', 'off', ...
                             'IntegerHandle', 'off', ...
                             'HandleVisibility', 'on', ...
                             'NextPlot', 'new', ...
                             'CloseRequestFcn', @(x,~)set(x,'Visible', 'off'));
                obj.AppWindow = fig;
                obj.IsTopLevelUI = true;
            end
        end

    end
end
