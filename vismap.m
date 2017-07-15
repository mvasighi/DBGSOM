
% -------------------------------------------------------------------------
function vismap(net,LB)
% Top-map visualization function for SOM

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
set(gcf, 'name', 'Top map')
set(gcf, 'NumberTitle', 'off')
% maxsize=max(max(grd'))-min(min(grd'));
maxsize=max(max(net.grd,[],2)-min(net.grd,[],2));
gCord=net.grd;
plot(gCord(1,:),gCord(2,:),'ws','markersize',450/maxsize,'markerfacecolor',[1 1 1],'MarkerEdgeColor',[0 0 0],'LineWidth',1.5)

axis equal
axis off
text_color = [0 0 0];
while ~isempty(LB)
    ww=find(net.winlist==net.winlist(1));
    for i=1:length(ww)
%         text(gCord(1,net.winlist(1))+(0.7*randn/maxsize),gCord(2,net.winlist(1))+(0.7*randn/maxsize),num2str(LB(ww(i))),'fontsize',150/maxsize,'horizontalalignment','left','color',text_color)
        text(gCord(1,net.winlist(1))+(0.6*randn/maxsize),gCord(2,net.winlist(1))+(0.6*randn/maxsize),num2str(LB(ww(i))),'horizontalalignment','left','color',text_color)
    end
    net.winlist(ww)=[];
    LB(ww)=[];
end

