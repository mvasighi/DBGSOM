function TE=tefun(data,net)
% Calculate Topographic Error

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

[data,~]=prefun(data,'rs');

[~,sor_ind]=sort(dist(W',data'));
bmu1_ind=sor_ind(1,:);
bmu2_ind=sor_ind(2,:);

Da=linkdist(net.grd);

for i=1:length(bmu1_ind)
    isadj(i)=Da(bmu1_ind(i),bmu2_ind(i));
end
TE =sum(isadj~=1)/length(isadj);