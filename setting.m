function netset=setting(method)

% setting initializes a default structure for DBGSOM parameters
% input: method                        type of settings
%                               'dbgsom' for an unsupervised kohonen network.
% output: netset 

% netset.method     method name ('dbgsom')
% netset.epch       number of epochs (default = NaN)
% netset.amax       max. learning rate (default = 0.5)
% netset.amin   	min. learning rate (default = 0.01)
% netset.vis    	training visualization (for 2D datasets) ('y', 'n') (default = 'n')
% netset.pmax   	initial neighborhood function width (a number between 0 and 1) (default = 2)
% netset.pmin   	final neighborhood function width (a number between 0 and pmax)(default = 0.7)
% netset.sf         spread-out factor ( 0 > sf > 1) (default = NaN)

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

netset.method = method;    % method name ('dbgsom')
netset.mod    = 'batch';   % learning mode: 'batch' or 'sequential'
netset.epch   = NaN;       % number of epochs
netset.amax   = 0.5;       % max. learning rate
netset.amin   = 0.01;      % min. learning rate
netset.vis    = 'n';       % training visualization (yes, no)
netset.stnr   =  4;        % number of starting neurons (4: square shape , 5:plus shape)
netset.inw    = 'eg';      % weight of starting neurons (eg: eigenvector, rn: random)
netset.pmax   = 2;
netset.pmin   = 0.7;
netset.sf     = NaN;       % spread-out factor
