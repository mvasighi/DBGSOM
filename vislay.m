function vislay(net,laynum)
% weight map (weight layer) visualization function

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

set(gcf,'position',[50 50 640 640],'Color',[1 1 1])
set(gcf, 'name', ['Weight layer',num2str(laynum)])
set(gcf, 'NumberTitle', 'off')

% maxsize=max(max(grd'))-min(min(grd'));
maxsize=max(max(net.grd')-min(net.grd'));
gCord=net.grd;

maxbox=430/maxsize;
maxval=max(net.W(laynum,:));
hold on
% plot(gCord(1,:),gCord(2,:),'ws','markersize',maxbox,'markerfacecolor',[1 1 1],'MarkerEdgeColor',[0 0 0],'LineWidth',1.5)

for i=1:size(net.grd,2)
plot(gCord(1,i),gCord(2,i),'ws','markersize',maxbox,'markerfacecolor',(net.W(laynum,i)/maxval).*[1 1 1],'MarkerEdgeColor',[0 0 0],'LineWidth',1.5)
% text(gCord(1,i),gCord(2,i),num2str(net.hitcount(i)))
end
axis equal
axis off
hold off