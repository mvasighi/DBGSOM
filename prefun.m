function [pre_X,pre_param]=prefun(X,option)
% Preprocessing function 
% apply range-scaling or auto-scaling

% Directed Batch Growing Self Organizing Map (DBGSOM)
% version 1.0 - July 2017
% Mahdi Vasighi
% Institute for Advanced Studies in Basic Sciences, Zanjan, Iran
% Department of Computer Science and Information Technology
% www.iasbs.ac.ir/~vasighi/

%     Directed Batch Growing Self Organizing Map (DBGSOM), version 1.0
%     Copyright (C) 2017  Mahdi Vasighi
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

[n1,~]=size(X);

switch option
    case 'rs' % range scaling the columns
        pre_X=(X-repmat(min(X),n1,1))./(repmat(max(X)-min(X),n1,1));
        pre_param.min=min(X);
        pre_param.max=max(X);
    case 'as' % mean centering
        pre_X=(X-repmat(mean(X),n1,1))./(repmat(std(X),n1,1));
        pre_param.cmean=mean(X);
        pre_param.cstd=std(X);
end