function out = getfieldel (in, varargin)
    out = structfun2(@(f) getel(f, varargin{:}), in);
end
