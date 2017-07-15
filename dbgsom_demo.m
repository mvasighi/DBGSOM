% Directed Batch Growing Self Organizing Map (DBGSOM)
% version 1.0 - July 2017
% Mahdi Vasighi
% Institute for Advanced Studies in Basic Sciences, Zanjan, Iran
% Department of Computer Science and Information Technology
% www.iasbs.ac.ir/~vasighi/

% Demo: Iris data analysis

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

close all
clear
clc

load iris                   % load data matrix (samples x variables)

netset=setting('dbgsom');   % initialize setting for dbgsom

netset.epch   = 100;        % number of epochs
netset.sf     = 0.7;        % Spread Factor setting
netset.vis ='n';

net=dbgsom(X,netset);

figure(1);vismap(net,class) %Top-map visulaization
figure(2);vishit(net)       %Hit-map visualization