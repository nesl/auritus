classdef HelperBox < handle
%HELPERBOX Draw a box and axes for displaying orientation
%   This class is for internal use only. It may be removed in the future. 

%   Copyright 2017-2018 The MathWorks, Inc.    
    
    properties (Hidden)
        AppWindow;
        
        Title = '';
        AxesPosition = [0.1300 0.1100 0.7750 0.8150];

        XLimits = [-2, 2];
        YLimits = [-2, 2];
        ZLimits = [-2, 2];
        ColorIndex = 1
    end
    
    properties (Access = private)
        pAxes;
        
        pBoxPatch;
        pInitialVertices;

        pBoxAxes; % direction lines
        pInitialDirs;

        pBoxAxesLabels % direction line labels
        pInitialDirLabels;
        
        pLinkedPropsObject;
    end

    properties (Access = private, Constant)
        INITIAL_VIEW_ANGLE = [1, 1, 1];
    end
    
    methods
        % Constructor
        function obj = HelperBox(fig, varargin)
            %varargin: axesposition, title, colorindex
            obj.AppWindow = fig;
            if numel(varargin) > 0
                obj.AxesPosition = varargin{1};
            end
            if numel(varargin) > 1
                    obj.Title = varargin{2};
            end
            if numel(varargin) > 2
                obj.ColorIndex = varargin{3};
            end
            
            initialize(obj);
        end
        
        function initialize(obj)
            %INITIALIZE - draw a box and child frame axes
            %   Draw a box with 3 axes emanating.
            %   Initial axes alignment is 
            %       x pointing north
            %       y pointing east
            %       z pointing down

            ax = createAxes(obj);
            
            % Box drawing via patches
            b = 1;
            a = 1/(0.5 * (1+sqrt(5)));
            xVertices = [-a;a;a;-a; -a;a;a;-a];
            yVertices = [0;0;b;b;     0;0;b;b];
            zVertices = [0;0;0;0;     b;b;b;b];
            xVertices = (xVertices );
            yVertices = (yVertices - b/2);
            zVertices = (zVertices - b/2);
   
            faces = [1 2 3 4; ...
                5 6 7 8; ...
                1 4 8 5; ...
                2 3 7 6; ...
                1 5 6 2; ...
                4 8 7 3];
            vertices = [xVertices yVertices zVertices];
            cdata = repmat(ax.ColorOrder(obj.ColorIndex,:), size(faces,1), 1);
            obj.pBoxPatch = patch(ax,'Vertices',vertices,'Faces',faces,'FaceVertexCData',cdata, ...
                                'FaceColor','flat');
                            
            xBoxAx = line(ax,'XData',[0 2],'YData',[0 0],'ZData',[0 0], ...
                'LineWidth',5,'Marker','none','Color',ax.ColorOrder(2,:),'HandleVisibility','off');
            yBoxAx  = line(ax,'XData',[0 0],'YData',[0 2],'ZData', ...
                [0 0],'LineWidth',5,'Marker','none','Color',ax.ColorOrder(3,:),'HandleVisibility','off');
            zBoxAx  = line(ax,'XData',[0 0],'YData',[0 0],'ZData',[0 2], ...
                'LineWidth',5,'Marker','none','Color',ax.ColorOrder(4,:),'HandleVisibility','off');

            sz = 0.1; % Label size

            % Draw X character on the Box's x-axis
            y = sz.*([0 1 1.5 2 3 2 3 2 1.5 1 0 1] - 1);
            z = sz.*([0 0 .5 0 0 1 2 2 1.5 2 2 1] - 1);
            x = zeros(size(y));
            xBoxAxLabel = patch(ax, x+2,y,z, 'black', ...
                'HandleVisibility', 'off');

            % Draw Y character on the Box's y-axis
            r2 = sqrt(2)/2;
            ls = 1.5 - r2/2 ;
            rs = 1.5 + r2/2;
            mp = 1; %2 - ls;
            x = sz.*([ls rs rs 3 2 1.5 1 0 ls] - 1);
            z = sz.*( (2 - [0   0 mp 2 2 1.5 2 2 mp]) -1);
            y = zeros(size(z));
            yBoxAxLabel = patch(ax, x,y+2,z, 'black', ...
                'HandleVisibility', 'off');

            % Draw Z character on the Box's z-axis
            lpy = 1;
            hpy = 1;
            x = sz.*([0 2 2 lpy 2 0 0 hpy] -1);
            y = sz.*([0 0 .5 .5 2 2 1.5 1.5] - 1);
            z = zeros(size(y));
            zBoxAxLabel = patch(ax, x,y,z+2, 'black', ...
                'HandleVisibility', 'off');
                            
            obj.pInitialVertices = vertices;
            obj.pBoxAxes = [xBoxAx yBoxAx zBoxAx];
            obj.pInitialDirs = [0 0 0; 
                                2 0 0;
                                0 0 0;
                                0 2 0;
                                0 0 0; 
                                0 0 2];

            obj.pBoxAxesLabels = [xBoxAxLabel yBoxAxLabel zBoxAxLabel];    
            obj.pInitialDirLabels{1} = xBoxAxLabel.Vertices;
            obj.pInitialDirLabels{2} = yBoxAxLabel.Vertices;
            obj.pInitialDirLabels{3} = zBoxAxLabel.Vertices;                            
        end

        function deleteAxes(obj)
            delete([obj.pAxes]);
        end
        
        function ax = createAxes(obj)
            %CREATEAXES Draw basic axes for box plotting

            fig = obj.AppWindow;

            ax = axes(fig, 'OuterPosition', obj.AxesPosition);
            
            ax.Title.String = obj.Title;

            view(ax,obj.INITIAL_VIEW_ANGLE);  

            % axis equal;
            ax.DataAspectRatioMode = 'manual';
            ax.DataAspectRatio = [1 1 1];
            ax.PlotBoxAspectRatioMode = 'manual';
            ax.PlotBoxAspectRatio = [1.2 1 1];
            
            % Reference frame is NED. 
            ax.YDir = 'reverse';
            ax.ZDir = 'reverse';
            ax.XLabel.String = 'x (North)';
            ax.YLabel.String = 'y (East)';
            ax.ZLabel.String = 'z (Down)';

            ax.XGrid = 'on';
            ax.XMinorGrid = 'on';
            ax.YGrid = 'on';
            ax.YMinorGrid = 'on';
            ax.ZGrid = 'on';
            ax.ZMinorGrid = 'on';

            ax.XLimMode = 'manual';
            ax.XLim = obj.XLimits;
            ax.YLimMode = 'manual';
            ax.YLim = obj.YLimits;
            ax.ZLimMode = 'manual';
            ax.ZLim = obj.ZLimits;
            
            obj.pAxes = ax;
        end
        
        function update(obj, R)
            %UPDATE - update the orientation of box and axes
            if isa(R, 'quaternion')
                R = rotmat(R, 'frame');
            end
            
            BoxPatch = obj.pBoxPatch;
            initVertices = obj.pInitialVertices;
            % Point Rotation
            BoxPatch.Vertices =  initVertices * R;
            
            dirs = obj.pBoxAxes;
            initDirs = obj.pInitialDirs;
            % Point Rotation
            newDirs = initDirs * R;

            xt = reshape(newDirs(:,1),2,[]);
            yt = reshape(newDirs(:,2),2,[]);
            zt = reshape(newDirs(:,3),2,[]);
            for ii=1:numel(dirs)
                set(dirs(ii), 'XData', xt(:,ii), ...
                    'YData', yt(:,ii), 'ZData', zt(:,ii));
            end    
            
            updateDirLabel(obj, R);
        end

        function updateDirLabel(obj, R)
        %UPDATEDIRLABEL - rotate the X,Y,Z characters to the proper
        %   orientation
            for cc=1:3
                dirLabel = obj.pBoxAxesLabels(cc);
                initDirLabel = obj.pInitialDirLabels{cc};
                % Point Rotation
                newDirLabel = initDirLabel * R;
                dirLabel.Vertices = newDirLabel;
            end
        end
        
        function syncRotationCallback(objs)
        %SYNCROTATIONCALLBACK - link rotation to another set of axes
            linkedPropsObject = linkprop([objs.pAxes], {'XLim', 'YLim', 'ZLim', ...
                'CameraPosition', 'CameraTarget', 'CameraUpVector', 'CameraViewAngle'});
            for i = 1:numel(objs)
                objs(i).pLinkedPropsObject = linkedPropsObject;
            end
        end
    end
end
