function net=dbgsom(data,netset)

% Training function for DBGSOM

% Directed Batch Growing Self Organizing Map (DBGSOM)
% version 1.0 - July 2017
% Mahdi Vasighi
% Institute for Advanced Studies in Basic Sciences, Zanjan, Iran
% Department of Computer Science and Information Technology
% www.iasbs.ac.ir/~vasighi/

[n1,m1]=size(data);
[data,pre_param]=prefun(data,'rs'); %data pre-processing
data_tmp=data;

net=dbgsom_init(data); %gsom initialization

ds=linkdist(net.grd);

epvec=1:netset.epch;

netset.pvec=(netset.pmax-netset.pmin)*((netset.epch-epvec)/(netset.epch-1))+netset.pmin;

netset.lrvec=(netset.amax-netset.amin)*((netset.epch-epvec)/(netset.epch-1))+netset.amin; % Learning rate
netset.GT=-m1*log(netset.sf);

fprintf('Data matrix (Samples=%i Variables=%i)\n',n1,m1)
fprintf('DBGSOM (SF=%3.2f)\n',netset.sf)

for ep=1:netset.epch
    if ~rem(ep,10)
       fprintf('Training epoch %i\n',ep)
    end
        
    h=nbrfun(netset,ds,ep);
    [~,net.win_list]=winfun(data,net.W);
    
    hh=h(:,net.win_list);
    h1=data'*hh';
    h2= true(size(data'))*hh';
    pos = find(h2 > 0);
    net.W(pos)=h1(pos)./h2(pos);
    
    if ep<netset.epch && ep>1
    
    %calulcating error of each neuron
    [win_err,win_id]=winfun(data,net.W);
    net.Err=errcalc(win_err,win_id,net.grd);
    
    % check to find boundary and non-boundary nodes.
    [nb_id,bo_id]=findbound(ds);
    
    % distibute the error of non-boundary nodes which has a higher error
    % than GT (batch mode)
    for jj=1:length(nb_id)
        if net.Err(nb_id(jj))>=netset.GT
            intersect_id=intersect(find(ds(nb_id(jj),:)==1),bo_id);
            if ~isempty(intersect_id)
                net.Err(intersect_id)=net.Err(intersect_id)+net.Err(nb_id(jj))/8; % error of a nb node is distributed equally between neighbors and itself
                net.Err(nb_id(jj))=net.Err(nb_id(jj))/2;
            end
        end
    end
    
    net=dbgrowfun(net,netset,ds,bo_id);
    
    ds=linkdist(net.grd);
    
    end
    % ploting neurons in data sapce
    if strcmp(netset.vis,'y')
        vistrn(net,data)
    end    
    
end
fprintf('[Done]\n')

[~,winlist]=winfun(data_tmp,net.W);
[hitcount,~]=hist(winlist,size(net.W,2));
net.winlist=winlist;
net.hitcount=hitcount;
net.pre_param=pre_param;
net=net_eval(data,net);

