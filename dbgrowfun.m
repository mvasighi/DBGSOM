function net=dbgrowfun(net,netset,ds,bo_id)
% Growing phase function in batch mode learning

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
Err=net.Err;
grd=net.grd;


[sorted_Err,x1id]=sort(Err(bo_id),'descend');
bo_id=bo_id(x1id);
bo_id=bo_id(Err(bo_id)>=netset.GT); % Run growing phase only for b-node (Err>=GT)

%Growing phase
for i=1:length(bo_id)
    new_grd=[];
    W_new_grd=[];
    new_Err=[];
    
    notallowed_pos=[ismember([grd(:,bo_id(i))+[0;1]]',grd','rows') ismember([grd(:,bo_id(i))+[0;-1]]',grd','rows'),...
        [ismember([grd(:,bo_id(i))+[1;0]]',grd','rows') ismember([grd(:,bo_id(i))+[-1;0]]',grd','rows')]];
    
    direct_opr=[0 0 1 -1;1 -1 0 0];%[N S E W] directions
    direct_opr(:,notallowed_pos)=[];
    allowed_grd=repmat(grd(:,bo_id(i)),1,size(direct_opr,2))+direct_opr;
    
    
    if ~isempty(allowed_grd)

        nbr1_id=find(ds(bo_id(i),:)==1);
        nbr2_id=find(ds(bo_id(i),:)==2);
    
        %sorting neighbirs of boundary nodes
                [sorted_Err1,x1id]=sort(Err(nbr1_id),'descend');%
                nbr1_id=nbr1_id(x1id);
                [sorted_Err2,x2id]=sort(Err(nbr2_id),'descend');%
                nbr2_id=nbr2_id(x2id);
    
    
    if size(allowed_grd,2)==3 && length(nbr1_id)==1 %three possible postion to grow
        sel_nbr2_id = nbr2_id(min(dist(allowed_grd',grd(:,nbr2_id)))==1);
        nbr1_dist = dist(grd(:,nbr1_id)',allowed_grd);
        new_Err=0;
        if isempty(sel_nbr2_id) % if there is no allowed nbr2
            temp_id=find(nbr1_dist~=2);
            new_grd = allowed_grd(:,temp_id(1));
            W_new_grd = 2.*W(:,bo_id(i))-W(:,nbr1_id);
            
        else % there is nbr2
            [mval,max_id]=max(Err(sel_nbr2_id));
            nbr2_dist = dist(allowed_grd',grd(:,sel_nbr2_id(max_id)));
            new_grd = allowed_grd(:,nbr2_dist==1);
            
            W_new_grd = (W(:,bo_id(i))+W(:,sel_nbr2_id(max_id)))/2;
        end
        
    
    elseif size(allowed_grd,2)==2 && length(nbr1_id)==2%two possible positions to grow
        [~,max_id]=max(Err(nbr1_id));
        [~,min_id]=min(Err(nbr1_id));
        [~,ind]=min(dist(grd(:,nbr1_id(max_id))',allowed_grd));
        
        sel_nbr2_id = nbr2_id(min(dist(allowed_grd',grd(:,nbr2_id)))==1);
        [~,max2_id]=max(Err(sel_nbr2_id));
        
        new_grd=allowed_grd(:,ind(1));
        new_Err=0;
        
        if isempty(sel_nbr2_id) % if there is no adj nbr2
            W_new_grd = 2.*W(:,bo_id(i))-W(:,nbr1_id(min_id)); % can be change (mean with bo)
        else
            if dist(grd(nbr1_id(max_id))',grd(:,sel_nbr2_id(max2_id)))==1 % nbr2 is adj to selected allowed grd
                W_new_grd = (2.*W(:,bo_id(i))-W(:,nbr1_id(min_id))+W(:,sel_nbr2_id(max2_id)))/2;
            else
                W_new_grd = 2.*W(:,bo_id(i))-W(:,nbr1_id(min_id));
            end
        end
        
   
    
    else
        if length(nbr1_id)==3 %one possible position to grow
            new_grd=allowed_grd;
            new_Err=0;
            nbr1_dist = dist(allowed_grd',grd(:,nbr1_id));
            sel_nbr2_id = nbr2_id(min(dist(allowed_grd',grd(:,nbr2_id)))==1);
            
            if isempty(sel_nbr2_id) % if there is no adj nbr2
                W_new_grd = 2.*W(:,bo_id(i))-W(:,nbr1_id(nbr1_dist==2));
            else
                [~,max2_id]=max(Err(sel_nbr2_id));
                W_new_grd = (2.*W(:,bo_id(i))-W(:,nbr1_id(nbr1_dist==2))+W(:,sel_nbr2_id(max2_id)))/2;
            end
            
        end
    end
    grd=[grd,new_grd];
    W=[W,W_new_grd];
    Err=[Err,new_Err];
    
    end
end
net.grd=grd;
net.W=W;
