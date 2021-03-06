function answer = tricond_pos (A_norm, Q, uplow)
    if (nargin < 3),  uplow = Q.uplow;  end
    if ~strncmpi(uplow, Q.uplow, 1)
        error ('packed:tricond_pos:badUplow', ...
            '"uplow" asked is different than matrix''s uplow property.');
    end

    if ~strcmp(get_caller_name, 'tricond'),
        error ('packed:tricond_pos:privFunc', 'This is a private function.');
    end

    myassert (ispacked(Q));
    myassert (istri_type(Q));

    A_norm = cast (A_norm, class(Q));
    [info, answer] = call_lapack ('pp', 'con', ...
        Q.uplow, Q.order, Q.data, [], A_norm);
    myassert (info >= 0);
end

%!test
%! % tricond_pos ()
%! warning('off', 'test:noFuncCall');

%!error
%! s = lasterr ('', '');
%! tricond_pos (packed(eye(2)));

%!test
%! s = lasterror;
%! myassert (s.identifier, 'packed:tricond_pos:privFunc');


%!error
%! s = lasterr ('', '');
%! rcond(packed(complex([1 1 1]), 'tri', 'u'));

%!test
%! % rcond ()
%! s = lasterror;
%! myassert (strend('complexNotSupported', s.identifier));

%!test
%! temp = tricond(rand, {packed([])}, 'pos');
%! myassert (temp, Inf);
%! temp = rcond([]);
%! myassert (temp, Inf);

%!test
%! for precision = {'single', 'double'}, precision = precision{:};
%! for matrix_type = {'lehmer', 'minij', 'moler'}, matrix_type = matrix_type{:};
%! for i=1:1
%!     while true
%!         n = round(100*rand);
%!         if (n > 1),  break;  end
%!     end
%!     
%!     A_full = cast(gallery(matrix_type, n), precision);
%!         myassert (issym(A_full));
%!         myassert(isa(A_full, precision));
%!     
%!     A = packed (A_full, 'sym', 'u');
%!         myassert (ispacked(A));
%!         myassert (issym(A));
%!         myassert (isa(A, precision));
%!     
%!     answer_full = rcond(A_full);
%!     answer = tricond (norm(A, 1), {chol(A)}, 'positive-definite');
%!     error = answer - answer_full;
%!     
%!     %disp({precision, matrix_type, answer_full, answer, error, 100*eps(precision), class(answer)});  % DEBUG
%! 
%!     myassert(    ( answer_full >= 0.25 && abs(error) < 1e5*eps(precision) )...
%!             || ( answer_full <  0.25 && abs(error) < 0.1 ) );
%!     % It seems that, when the condition number is small, its estimate
%!     % is not very reliable.
%! end
%! end
%! end

%!test
%! warning('on', 'test:noFuncCall');

