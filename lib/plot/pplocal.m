function varargout = pplocal (azim, radius, CentreValue, varargin)
  if (nargin < 2) || isempty(radius),  radius = ones(size(azim));  end
  if (nargin < 3) || isempty(CentreValue),  CentreValue = 0;  end
  [varargout{1:nargout}] = pp(azim*pi/180, radius, ...
    'ThetaDirection','cw', ...
    'ThetaStartAngle',+270, ...
    'CentreValue',CentreValue, ...
    varargin{:} ...
  );
  axis equal
  % other useful options:
  % (pls copy them to YOUR script, rather than changing this function!)
  %  'MaxValue',1, ...
  %  'RingStep',0.25, ...
  %  'RingTickLabel',...
  %    arrayfun(@(x) sprintf('%.0f^\\circ', x), acos(1:-0.25:0)'*180/pi, ...
  %      'UniformOutput',false), ...
  %  'Marker','none', ...
  %  'LineWidth',2, ...
  %  'LineColor','k' ...
end
