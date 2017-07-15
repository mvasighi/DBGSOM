function DM=dmfun(data,net)
% Calculate distorsion measure

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

W=net.W;
winlist=net.winlist;
hitcount=net.hitcount;

[data,~]=prefun(data,'rs');

ntds=linkdist(net.grd);
h = exp(-(ntds.^2)/(2*((1)^2)));
hh=h(:,winlist);
dst=dist(data,W);

hitind=hitcount>0;
dm=hh.*(dst.^2)';
dm=dm(hitind,:);
DM=mean(sum(dm./repmat(hitcount(hitind)',1,size(data,1))));
