function DB=dbfun(data,net)
% Calculate Davies–Bouldin index

% Directed Batch Growing Self Organizing Map (DBGSOM)
% version 1.0 - July 2017
% Mahdi Vasighi
% Institute for Advanced Studies in Basic Sciences, Zanjan, Iran
% Department of Computer Science and Information Technology
% www.iasbs.ac.ir/~vasighi/

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