function DB=dbfun(data,net)
% Calculate Davies–Bouldin index

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
hitcount=net.hitcount;
winlist=net.winlist;

[data,~]=prefun(data,'rs');

for i=1:size(W,2)
    for j=i+1:size(W,2)
        if hitcount(j)~=0 && hitcount(i)~=0;
        di=mean(dist(data(winlist==i,:),W(:,i)));
        dj=mean(dist(data(winlist==j,:),W(:,j)));
        dij=dist(W(:,i)',W(:,j));
        D2(i,j)=(di+dj)/dij;
        D2(j,i)=(di+dj)/dij;
        end
    end
end
DB=sum(max(D2))/sum(hitcount~=0);
