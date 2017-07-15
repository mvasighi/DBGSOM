function vis_lab(LB,top_id,grd)
% top map visualization function

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


set(gcf,'position',[20 40 640 640],'Color',[1 1 1])
% maxsize=max(max(grd'))-min(min(grd'));
maxsize=max(max(grd')-min(grd'));
gCord=grd;
plot(gCord(1,:),gCord(2,:),'ws','markersize',450/maxsize,'markerfacecolor',[1 1 1],'MarkerEdgeColor',[0 0 0])

axis equal
axis off
text_color = [0 0 0];
while ~isempty(LB)
    ww=find(top_id==top_id(1));
    for i=1:length(ww)
        text(gCord(1,top_id(1))+(0.7*randn/maxsize),gCord(2,top_id(1))+(0.7*randn/maxsize),num2str(LB(ww(i))),'fontsize',150/maxsize,'horizontalalignment','left','color',text_color)
    end
    top_id(ww)=[];
    LB(ww)=[];
end