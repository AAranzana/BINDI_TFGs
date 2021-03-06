%This file is part of TEAP.
%
%TEAP is free software: you can redistribute it and/or modify
%it under the terms of the GNU General Public License as published by
%the Free Software Foundation, either version 3 of the License, or
%(at your option) any later version.
%
%TEAP is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
%
%You should have received a copy of the GNU General Public License
%along with TEAP.  If not, see <http://www.gnu.org/licenses/>.
% 
%> @file Signal__set_signame.m
%> @brief Sets the name of a signal (ex: 'GSR', 'ECG', etc…) you should NOT use this function,
%> only TEAP uses-it
% 
%> @param  Signal: the signal you want to set the name
%> @param nameStr: the name string
% 
%> @retval  Signal: the modified signal
% 
%> @author Copyright Frank Villaro-Dixon, 2014
function Signal = Signal__set_signame(Signal, nameStr)

if(nargin ~= 2)
	error('Usage: Signal = Signal__set_signame(Signal, nameStr)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end

Signal__assert_mine(Signal);


Signal.name = nameStr;

%!error(Signal__set_signame())
%!error(Signal__set_signame(42))
%!error(Signal__set_signame(42, 43))
%!error(Signal__set_signame(Signal__new_empty(), 'hallo')) %no result retreived
%!assert(Signal__get_signame(Signal__set_signame(Signal__new_empty(), 'gcr')), 'gcr')

