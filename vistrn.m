function vistrn(net,data)
% training visualization function

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

[xcord,ycord]=find(triu(linkdist(net.grd))==1);
plot(data(:,1),data(:,2),'.','markersize',14)
hold on
plot(net.W(1,:),net.W(2,:),'.r','markersize',18,'markerfacecolor','r')
for ii=1:length(xcord)
    line([net.W(1,xcord(ii)),net.W(1,ycord(ii))],[net.W(2,xcord(ii)),net.W(2,ycord(ii))],'Color','r');
end
axis equal
% axis off
xlim([-0.5 1.5])
ylim([-0.5 1.5])
hold off
drawnow
