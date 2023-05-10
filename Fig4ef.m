clear


lim=7 ;  step=50;
newHold1Eon = []; newHold2Eon = [];
newHold1Fon = []; newHold2Fon = [];

unit = load('MSD1-1shifted.mat');
unitdata = unit.Data;   %%%% holizontal style [1 x n ]
unitsample = unit.SampleRate;

stim = load('Stim pulse.mat');
stimdata = stim.Data;   %%%% holizontal style [1 x n ]
stimsample = stim.SampleRate;
StimDR = stim.accessory_data(1,3).Data;
stimdata = stimdata(StimDR==2);

if stimsample > unitsample
    unitdata = unitdata * stimsample/unitsample;
    SR = stimsample;
elseif stimsample < unitsample
    stimdata = stimdata * unitsample/stimsample;
    SR = unitsample;
else
    SR = unitsample;
end  % if TstimSR

if unitdata(end) > stimdata(end)
    n = unitdata(end);
else
    n = stimdata(end);
end
spike = zeros(n,1);
spike(unitdata) = 1;

if unitdata(1) > stimdata(1)  % analysis start
    s = unitdata(1);
else
    s = stimdata(1);
end


 FEtorque = load('FE torque.mat');
    TQsRate = FEtorque.SampleRate;
    TQ = FEtorque.Data;
    TQ = double(TQ);

    [bb,aa] = butter(3,0.01,'low');   %%%% for 1kHz sampling, 10Hz = 0.02
    fTQ = filtfilt(bb,aa,TQ);
    dfTQ = diff(fTQ);
    fdfTQ = filtfilt(bb,aa,dfTQ);
    
    L1 = find(fdfTQ>-0.4);
    L2 = find(fdfTQ<0.4);
    L3 = intersect(L1,L2);
    L4 = L3(diff(L3)==1);
    L5 = L4(diff(L4)==1);
    
    baseTQ = mean(fTQ(L5));
    fTQ = fTQ-baseTQ;  
    
Rest1Eon = load('Rest1 E on.mat');
sampleRate = Rest1Eon.SampleRate;
Rest1Eon = Rest1Eon.Data;
if sampleRate < SR
    Rest1Eon = Rest1Eon * SR/sampleRate;   %%% same SampleRate with unit
end
CueEon = load('Cue E on.mat');
sampleRate = CueEon.SampleRate;
CueEon = CueEon.Data;
if sampleRate < SR
    CueEon = CueEon * SR/sampleRate;;   %%% same SampleRate with unit
end
DelayEon = load('Delay E on.mat');
sampleRate = DelayEon.SampleRate;
DelayEon = DelayEon.Data;
if sampleRate < SR
    DelayEon = DelayEon * SR/sampleRate;;   %%% same SampleRate with unit
end
RTEon = load('RT E on.mat');
sampleRate = RTEon.SampleRate;
RTEon = RTEon.Data;
if sampleRate < SR
    RTEon = RTEon * SR/sampleRate;;   %%% same SampleRate with unit
end
MovOnEon = load('Movement onset-E.mat');
sampleRate = MovOnEon.SampleRate;
MovOnEon = MovOnEon.Data;
if sampleRate < SR
    MovOnEon = MovOnEon * SR/sampleRate;;   %%% same SampleRate with unit
end
Hold1Eon = load('Hold1 E on.mat');
sampleRate = Hold1Eon.SampleRate;
Hold1Eon = Hold1Eon.Data;
if sampleRate < SR
    Hold1Eon = Hold1Eon * SR/sampleRate;;   %%% same SampleRate with unit
end

RT2Eon = load('RT2 E on.mat');
sampleRate = RT2Eon.SampleRate;
RT2Eon = RT2Eon.Data;
if sampleRate < SR
    RT2Eon = RT2Eon * SR/sampleRate;;   %%% same SampleRate with unit
end

MovOffEon = load('Movement offset-E.mat');
sampleRate =MovOffEon.SampleRate;
MovOffEon = MovOffEon.Data;
if sampleRate < SR
    MovOffEon = MovOffEon * SR/sampleRate;;   %%% same SampleRate with unit
end
Hold2Eon = load('Hold2 E on.mat');
sampleRate = Hold2Eon.SampleRate;
Hold2Eon = Hold2Eon.Data;
if sampleRate < SR
    Hold2Eon = Hold2Eon * SR/sampleRate;;   %%% same SampleRate with unit
end
RwdEon = load('Reward E on.mat');
sampleRate = RwdEon.SampleRate;
RwdEon = RwdEon.Data;
if sampleRate < SR
    RwdEon = RwdEon * SR/sampleRate;;   %%% same SampleRate with unit
end
RwdEoff = load('Reward E off.mat');
sampleRate = RwdEoff.SampleRate;
RwdEoff = RwdEoff.Data;
if sampleRate < SR
    RwdEoff = RwdEoff * SR/sampleRate;;   %%% same SampleRate with unit
end

for nn = 1:2
    if nn==1
        refstamp = ceil(RTEon./(SR/TQsRate));  %%% align to TQ_SR
        period=[-0.8 1.4].*TQsRate; 
    else
        refstamp = ceil(RT2Eon./(SR/TQsRate));  %%% align to TQ_SR
        period=[-0.5 1].*TQsRate; 
    end
    for ii = 1:length(refstamp)
       % ii
%         if ii==75
%            ii 
%         end
        tGO=refstamp(ii) ;
        if tGO < abs(period(1))
            continue
        end
        if length(fdfTQ)<tGO+period(2)
            period(2) = length(fdfTQ)-tGO;
        end
        a=[]; b=[]; jjj=0; jj=0 ;
        while  isempty(b)
            if length(fdfTQ)<tGO+period(2)
                break
            end
            f=fdfTQ(tGO+(period(1):period(2)));
            if nn==1
                [mm,pictim]=min(f) ;% look at maximum around GO signal
                [p,t]=findpeaks(f) ; %t(p<0.01 | p>4)=[] ;
            else
                [mm,pictim]=max(f) ;% look at maximum around GO signal
                [p,t]=findpeaks(-f) ; % look at the local maxima/minima comprised between the high and the normal threshold
                %t(-p<0.01 | -p>4)=[] ;
            end
            pon=t(find(t<pictim, 1,'last'));% take the local extrema the closest to the peak of the acceleration
            poff=t(find(t>pictim, 1));
            % when does the torque differential crosses the threshold, and in which direction ?
            [crossflex, dircrossflex]=tcrossing(f, [],0) ;
            if nn==1
                aa=crossflex(dircrossflex==-1 & crossflex<pictim) ;
                bb=crossflex(dircrossflex==1 & crossflex>pictim) ;
            else
                aa=crossflex(dircrossflex==1 & crossflex<pictim) ;% Pick the threshold crossings the closest to the maximum
                bb=crossflex(dircrossflex==-1 & crossflex>pictim) ;
            end
        
            a=sort([pon aa]) ;% combined threshold crossing and local extrema
            b=sort([poff bb]) ;
        % if the program does not find a threshold crossing, enlarge the
        % search window
%         if isempty(a)
%             period=[period(1)-step period(2)]   ;
%             j=j+1;
%         end
        if isempty(b)
            period=[period(1) period(2)+step]   ;
            jj=jj+1;
        end
        % if window is too large, there is a problem
        if  jj==lim
            warning(['peak detection problem !!! release ext  ',Expname])
            break
        end
        end

        if isempty(b)
            
        elseif jj~=lim && nn==1
            [bv, bi] = sort(abs(b-pictim));
            newHold1Eon = [newHold1Eon,b(bi(1))+tGO+period(1)] ;
        elseif jj~=lim && nn==2
            [bv, bi] = sort(abs(b-pictim));
            newHold2Eon = [newHold2Eon,b(bi(1))+tGO+period(1)] ;
        elseif nn==1
            [bv, bi] = sort(abs(Hold1Eon-tGO));
            if bv(1)<1*SR
             newHold1Eon = [newHold1Eon,Hold1Eon(bi(1))];
            else
                newHold1Eon = [newHold1Eon,NaN];
            end
        else
            [bv, bi] = sort(abs(Hold2Eon-tGO));
            if bv(1)<1*SR
             newHold2Eon = [newHold2Eon,Hold2Eon(bi(1))];
            else
                newHold2Eon = [newHold2Eon,NaN];
            end
        end
        
        
    end % for ii
end % for nn
newHold1Eon = newHold1Eon.*(SR/TQsRate);
newHold2Eon = newHold2Eon.*(SR/TQsRate);


Rest1Fon = load('Rest1 F on.mat');
sampleRate = Rest1Fon.SampleRate;
Rest1Fon = Rest1Fon.Data;
if sampleRate < SR
    Rest1Fon = Rest1Fon * SR/sampleRate;   %%% same SampleRate with unit
end
CueFon = load('Cue f on.mat');
sampleRate = CueFon.SampleRate;
CueFon = CueFon.Data;
if sampleRate < SR
    CueFon = CueFon * SR/sampleRate;;   %%% same SampleRate with unit
end
DelayFon = load('Delay F on.mat');
sampleRate = DelayFon.SampleRate;
DelayFon = DelayFon.Data;
if sampleRate < SR
    DelayFon = DelayFon * SR/sampleRate;;   %%% same SampleRate with unit
end
RTFon = load('RT F on.mat');
sampleRate = RTFon.SampleRate;
RTFon = RTFon.Data;
if sampleRate < SR
    RTFon = RTFon * SR/sampleRate;;   %%% same SampleRate with unit
end
MovOnFon = load('Movement onset-F.mat');
sampleRate = MovOnFon.SampleRate;
MovOnFon = MovOnFon.Data;
if sampleRate < SR
    MovOnFon = MovOnFon * SR/sampleRate;;   %%% same SampleRate with unit
end
Hold1Fon = load('Hold1 F on.mat');
sampleRate = Hold1Fon.SampleRate;
Hold1Fon = Hold1Fon.Data;
if sampleRate < SR
    Hold1Fon = Hold1Fon * SR/sampleRate;;   %%% same SampleRate with unit
end
RT2Fon = load('RT2 F on.mat');
sampleRate = RT2Fon.SampleRate;
RT2Fon = RT2Fon.Data;
if sampleRate < SR
    RT2Fon = RT2Fon * SR/sampleRate;;   %%% same SampleRate with unit
end
MovOffFon = load('Movement offset-F.mat');
sampleRate =MovOffFon.SampleRate;
MovOffFon = MovOffFon.Data;
if sampleRate < SR
    MovOffFon = MovOffFon * SR/sampleRate;;   %%% same SampleRate with unit
end
Hold2Fon = load('Hold2 F on.mat');
sampleRate = Hold2Fon.SampleRate;
Hold2Fon = Hold2Fon.Data;
if sampleRate < SR
    Hold2Fon = Hold2Fon * SR/sampleRate;;   %%% same SampleRate with unit
end
RwdFon = load('Reward F on.mat');
sampleRate = RwdFon.SampleRate;
RwdFon = RwdFon.Data;
if sampleRate < SR
    RwdFon = RwdFon * SR/sampleRate;;   %%% same SampleRate with unit
end
RwdFoff = load('Reward F off.mat');
sampleRate = RwdFoff.SampleRate;
RwdFoff = RwdFoff.Data;
if sampleRate < SR
    RwdFoff = RwdFoff * SR/sampleRate;;   %%% same SampleRate with unit
end

for nn = 1:2
    if nn==1
        refstamp = ceil(RTFon./(SR/TQsRate));  %%% align to TQ_SR
        period=[-0.8 1.4].*TQsRate; 
    else
        refstamp = ceil(RT2Fon./(SR/TQsRate));  %%% align to TQ_SR
        period=[-0.5 1].*TQsRate; 
    end
    for ii = 1:length(refstamp)
       % ii
        tGO=refstamp(ii) ;
        if tGO < abs(period(1))
            continue
        end
        if length(fdfTQ)<tGO+period(2)
            period(2) = length(fdfTQ)-tGO;
        end
        a=[]; b=[]; j=0; jj=0 ;
        while  isempty(b)
            if length(fdfTQ)<tGO+period(2)
                break
            end
            f=fdfTQ(tGO+(period(1):period(2)));
            if nn==1
                [mm,pictim]=max(f) ;% look at maximum around GO signal
                [p,t]=findpeaks(-f) ; %t(-p<0.01 | -p>4)=[] ;
            else
                [mm,pictim]=min(f) ;% look at maximum around GO signal
                [p,t]=findpeaks(f) ; % look at the local maxima/minima comprised between the high and the normal threshold
                %t(p<0.01 | p>4)=[] ;
            end
            pon=t(find(t<pictim, 1,'last'));% take the local extrema the closest to the peak of the acceleration
            poff=t(find(t>pictim, 1));
            % when does the torque differential crosses the threshold, and in which direction ?
            [crossflex, dircrossflex]=tcrossing(f, [],0) ;
            if nn==1
                aa=crossflex(dircrossflex==1 & crossflex<pictim) ;
                bb=crossflex(dircrossflex==-1 & crossflex>pictim) ;
            else
                aa=crossflex(dircrossflex==-1 & crossflex<pictim) ;% Pick the threshold crossings the closest to the maximum
                bb=crossflex(dircrossflex==1 & crossflex>pictim) ;
            end
        
            a=sort([pon aa]) ;% combined threshold crossing and local extrema
            b=sort([poff bb]) ;
        % if the program does not find a threshold crossing, enlarge the
        % search window
%         if isempty(a)
%             period=[period(1)-step period(2)]   ;
%             j=j+1;
%         end
        if isempty(b)
            period=[period(1) period(2)+step]   ;
            jj=jj+1;
        end
        % if window is too large, there is a problem
        if j==lim || jj==lim
            warning(['peak detection problem !!! release flex  ' ,Expname])
            break
        end
        end

        
        if isempty(b)
            
        elseif jj~=lim && nn==1
            [bv, bi] = sort(abs(b-pictim));
            newHold1Fon = [newHold1Fon,b(bi(1))+tGO+period(1)] ;
        elseif jj~=lim && nn==2
            [bv, bi] = sort(abs(b-pictim));
            newHold2Fon = [newHold2Fon,b(bi(1))+tGO+period(1)] ;
        elseif nn==1
            [bv, bi] = sort(abs(Hold1Fon-tGO));
            if bv(1)<1*SR
             newHold1Fon = [newHold1Fon,Hold1Fon(bi(1))];
            else
             newHold1Fon = [newHold1Fon,NaN];   
            end
        else
            [bv, bi] = sort(abs(Hold2Fon-tGO));
            if bv(1)<1*SR
             newHold2Fon = [newHold2Fon,Hold2Fon(bi(1))];
            else
                newHold2Fon = [newHold2Fon,NaN];
            end
        end
        
        
    end % for ii
end % for nn
newHold1Fon = newHold1Fon.*(SR/TQsRate);
newHold2Fon = newHold2Fon.*(SR/TQsRate);

%%%%% calc EMG onset
EMG1 = load('ED23.mat'); EMG2 = load('FDS.mat');  
SR_EMG = EMG1.SampleRate;
EMG1 = EMG1.Data; EMG2 = EMG2.Data; 
[B,A] = butter(3,[50, 200]/(SR_EMG/2));  
EMG1_bp = filtfilt(B, A, double(EMG1));
EMG2_bp = filtfilt(B, A, double(EMG2));
allEMG=[EMG1_bp;EMG2_bp];
for ee = 1:2
      allEMG(ee,:) = allEMG(ee,:) - mean(allEMG(ee,:),2);
end
allEMG = abs(allEMG);
[B,A] = butter(3,5/(SR_EMG/2),'low'); 
for ee = 1:2
    allEMG(ee,:) = filtfilt(B, A, allEMG(ee,:));
end
EMGs = allEMG;

%%%% detection of EMG onset 
    %calc baseline on 
    eRest1Fon = Rest1Fon * SR_EMG/SR; eRest1Eon = Rest1Eon * SR_EMG/SR; 
    Restonset = [eRest1Eon,eRest1Fon];
    Restonset = round(Restonset);
    eMovOnFon = MovOnFon * SR_EMG/SR; eMovOnEon = MovOnEon * SR_EMG/SR; 
    
    restEMG = [];
    for rr = 1:size(Restonset,2)
       restEMG = [restEMG,EMGs(:,Restonset(rr):Restonset(rr)+0.5*SR_EMG)];  
    end 
    baseline = mean(restEMG,2);
    sdEMG = std(restEMG,0,2);
    
    EMGonsetE = [];
    %calc onset
    if ~isempty(eMovOnEon)  %%% extension
            dEMG = EMGs(1,:); onset = [];
            for mo = 1:size(eMovOnEon,2)
                stime = round(eMovOnEon(1,mo));
                flag = 0;  
                for j = [stime:-1:stime-1*SR_EMG]
                    if dEMG(j)<baseline(1)+sdEMG(1)*2
                        flag = flag+1;
                    else
                        flag = 0;
                    end
                    if flag == 0.05*SR_EMG
                        onset = [onset, j+0.05*SR_EMG];
                        break
                    end
                    
                end % for j
            end % for mo
            EMGonsetE = [EMGonsetE,onset];
    end

 EMGonsetF = [];
    %calc onset
    if ~isempty(eMovOnFon)  %%% extension
            dEMG = EMGs(2,:); onset = [];
            for mo = 1:size(eMovOnFon,2)
                stime = round(eMovOnFon(1,mo));
                flag = 0;  
                for j = [stime:-1:stime-1*SR_EMG]
                    if dEMG(j)<baseline(2)+sdEMG(2)*2
                        flag = flag+1;
                    else
                        flag = 0;
                    end
                    if flag == 0.05*SR_EMG
                        onset = [onset, j+0.05*SR_EMG];
                        break
                    end
                    
                end % for j
            end % for mo
            EMGonsetF = [EMGonsetF,onset];
    end

EMGonsetE = EMGonsetE.*(SR/SR_EMG);
EMGonsetF = EMGonsetF.*(SR/SR_EMG);
probrow = [];

figure(1), clf
probrow_tr = cell(12,1);
probrow_stim = cell(12,1);
for dir = 1:2
if dir == 1
%%%%%%%% prepare interval
Rest1Eon = Rest1Eon(Rest1Eon>s);
Rest1Eon = Rest1Eon(Rest1Eon<n);
CueEon = CueEon(CueEon>s);
CueEon = CueEon(CueEon<n);
[intv1] = calcinterval(Rest1Eon,CueEon,SR,1);

DelayEon = DelayEon(DelayEon>s);
DelayEon = DelayEon(DelayEon<n);
EMGonsetE = EMGonsetE(EMGonsetE>s);
EMGonsetE = EMGonsetE(EMGonsetE<n);
[intv2] = calcinterval(CueEon,EMGonsetE,SR,1.5);

Hold1Eon = Hold1Eon(Hold1Eon>s);
Hold1Eon = Hold1Eon(Hold1Eon<n);
[intv3] = calcinterval(EMGonsetE,Hold1Eon,SR,0.6);

MovOffEon = MovOffEon(MovOffEon>s);
MovOffEon = MovOffEon(MovOffEon<n);
[intv4] = calcinterval(Hold1Eon,MovOffEon,SR,2);

newHold2Eon = newHold2Eon(newHold2Eon>s);
newHold2Eon = newHold2Eon(newHold2Eon<n);
[intv5] = calcinterval(MovOffEon,newHold2Eon,SR,0.6);

RwdEon = RwdEon(RwdEon>s);
RwdEon =RwdEon(RwdEon<n);
[intv6] = calcinterval(newHold2Eon,RwdEon,SR,1.5);

elseif dir == 2
%%%%%%%% prepare interval
Rest1Fon = Rest1Fon(Rest1Fon>s);
Rest1Fon = Rest1Fon(Rest1Fon<n);
CueFon = CueFon(CueFon>s);
CueFon = CueFon(CueFon<n);
[intv1] = calcinterval(Rest1Fon,CueFon,SR,1);

DelayFon = DelayFon(DelayFon>s);
DelayFon = DelayFon(DelayFon<n);
EMGonsetF = EMGonsetF(EMGonsetF>s);
EMGonsetF = EMGonsetF(EMGonsetF<n);
[intv2] = calcinterval(CueFon,EMGonsetF,SR,1.5);

Hold1Fon = Hold1Fon(Hold1Fon>s);
Hold1Fon = Hold1Fon(Hold1Fon<n);
[intv3] = calcinterval(EMGonsetF,Hold1Fon,SR,0.6);

MovOffFon = MovOffFon(MovOffFon>s);
MovOffFon = MovOffFon(MovOffFon<n);
[intv4] = calcinterval(Hold1Fon,MovOffFon,SR,2);

newHold2Fon = newHold2Fon(newHold2Fon>s);
newHold2Fon = newHold2Fon(newHold2Fon<n);
[intv5] = calcinterval(MovOffFon,newHold2Fon,SR,0.6);

RwdFon = RwdFon(RwdFon>s);
RwdFon =RwdFon(RwdFon<n);
[intv6] = calcinterval(newHold2Fon,RwdFon,SR,1.5);
end

for interval = 1:6
subplot(14,2,dir+(interval-1)*4+4), hold on
datrow = []; position = 0;
if interval == 1
    intv = intv1;
    str=strsplit(pwd,{'\'});
    title(['Rest trials = ',num2str(size(intv,1))])
elseif interval == 2
    intv = intv2;
    title(['Cue-EMGon trials = ',num2str(size(intv,1))])
elseif interval == 3
    intv = intv3;
    title(['EMGon-AH trials = ',num2str(size(intv,1))])
elseif interval == 4
    intv = intv4;
    title(['AH trials = ',num2str(size(intv,1))])
elseif interval == 5
    intv = intv5;
    title(['PM trials = ',num2str(size(intv,1))])
elseif interval == 6
    intv = intv6;
    title(['Rest2 trials = ',num2str(size(intv,1))])
end
counts = 0;
for i = 1:size(intv,1)
    sts = stimdata(stimdata<intv(i,2));
    sts = sts(sts>intv(i,1));
    datrow_tr = [];
    if ~isempty(sts)
        counts = counts+length(sts);
    for stimn = 1:length(sts)
        st = sts(stimn) - 0.05*SR;
        et = sts(stimn) + 0.05*SR;
        dat = spike(st:et,1);
    
    sp = find(dat==1); %counts{i,1} = sp;
    if ~isempty(sp) && length(sp)>2
        position = position+1;datrow = [datrow;sp];
        datrow_tr = [datrow_tr;sp];
        plot([sp sp],[position,position+0.8],'k')
        
    elseif ~isempty(sp) 
        position = position+1;datrow = [datrow;sp];
        datrow_tr = [datrow_tr;sp];
        sp2 = [sp',0,0];
        plot([sp2' sp2'],[position,position+0.8],'k')
%         counts = counts+1;
    end
    bin = 0.0005;
    [hh,tt] = histcounts(datrow_tr,[0:bin*SR:0.1*SR]);
    [prob] = calcprob_nofig(hh,1/bin);
    probrow_stim{interval+6*(dir-1),1} = [probrow_stim{interval+6*(dir-1),1};prob];
    end
    bin = 0.0005;
    [hh,tt] = histcounts(datrow_tr,[0:bin*SR:0.1*SR]);
    [prob] = calcprob_nofig(hh./length(sts),1/bin);
    probrow_tr{interval+6*(dir-1),1} = [probrow_tr{interval+6*(dir-1),1};prob];
    end
end
    axis([0 length(dat) 0 position+1])
    anum = [0:0.02:0.1].*SR;
    set(gca,'XTick',anum)

subplot(14,2,dir+(interval-1)*4+6)
bin = 0.0005;
[hh,tt] = histcounts(datrow,[0:bin*SR:0.1*SR]);
bar(tt(1:end-1),hh./counts,'b'), hold on

title(['stim num = ', num2str(counts)])

end

end

probrow = [];
for pp = 1:12
    probrow(pp) = mean(probrow_tr{pp,1});

end

subplot(14,2,[1,3]),plot(probrow(1:5),'-ob'),title('Extension')
xticks([1 2 3 4 5])
xticklabels({'Rest','Delay','AM','AH','PM'})
subplot(14,2,[2,4]),plot(probrow(7:11),'-or'),title('Flexion')
xticks([1 2 3 4 5])
xticklabels({'Rest','Delay','AM','AH','PM'})

tempr = 1;
for iint = 1:1
    if tempr < length(probrow_stim{iint,1})
        tempr = length(probrow_stim{iint,1});
    end
end
srow=nan(tempr,12);
for iint = 1:12
    srow(1:length(probrow_stim{iint,1}),iint) = probrow_stim{iint,1};
end
% save('resprob_stim.txt','srow','-ascii')

figure(2),clf
subplot(2,1,1), hold on
counts = 0;
datrow = [];
for ss = 2:length(stimdata)-1
    st = stimdata(ss) - 0.05*SR;
    et = stimdata(ss) + 0.05*SR;
    dat = spike(st:et,1);
    sp = find(dat==1);
    datrow = [datrow;sp];
    if ~isempty(sp) && length(sp)>2
        position = position+1;
        plot(sp,position*ones(size(sp)),'k.')
%         plot([sp sp],[position,position+0.8],'k')
        
    elseif ~isempty(sp) 
        position = position+1;
        sp2 = [sp',0,0];
        plot(sp,position*ones(size(sp)),'k.')
%         plot([sp2' sp2'],[position,position+0.8],'k')
%         counts = counts+1;
    end  
end

[hh,tt] = histcounts(datrow,[0:0.0005*SR:0.1*SR]);
subplot(2,1,2)
bar(tt(1:end-1),hh./(ss-2),'k'), hold on
plot([0.05*SR 0.05*SR],[0 max(hh./(ss-2))],'r:')
title(str(end))

[prob] = calcprob(hh./(ss-2),1/bin);


    
    function [intv] = calcinterval(stamp1,stamp2,SR,th)
    intv=[];
    for st = 1:length(stamp1)
        for st2 = 1:length(stamp2)
            int = stamp2(st2)-stamp1(st);
            if int>0 && int<th*SR
                intv = [intv;[stamp1(st), stamp2(st2)]];
                break
            end
        end
    end
    end
    
    function [prob] = calcprob(data,SR) %%%% SR is related bin size
    base = mean(data(1:0.05*SR));
    plot([0 2500],[base base],'r')
    sd = std(data(1:0.05*SR));
    plot([0 2500],[base+2*sd base+2*sd],'r:')
    flag = zeros(0.005*SR,1);
    for t = 1:0.005*SR
       if data(round((0.05+0.0025)*SR+t))> base+2*sd %%%% CDP latency of monkeyO = 2.55ms
          flag(t) = 1;     
       end
    end
    st = 0;  flag=[0;flag];
    if isempty(find(flag==1))
        prob = 0;
    else
        flag2 = diff(flag);
        for t = 1:0.005*SR
            if st==0 && flag2(t)>0
               st = t;
            end
            if st>0 && flag2(t)<0
               et = t+1; break 
            elseif st>0 && t==0.005*SR
                et = st+1;
            end
        end
        prob = sum(data((0.05+0.0025)*SR+st:(0.05+0.0025)*SR+et))-base*(et-st+1);
    end
    end
    
   function [prob] = calcprob_nofig(data,SR) %%%% SR is related bin size
    base = mean(data(1:0.05*SR));
    sd = std(data(1:0.05*SR));
    flag = zeros(0.005*SR,1);
    for t = 1:0.005*SR
       if data(round((0.05+0.0025)*SR+t))> base+2*sd %%%% CDP latency of monkeyO = 2.55ms
          flag(t) = 1;     
       end
    end
    st = 0;  flag=[0;flag];
    if isempty(find(flag==1))
        prob = 0;
    else
        flag2 = diff(flag);
        for t = 1:0.005*SR
            if st==0 && flag2(t)>0
               st = t;
            end
            if st>0 && flag2(t)<0
               et = t+1; break 
            elseif st>0 && t==0.005*SR
                et = st+1;
            end
        end
        prob = sum(data((0.05+0.0025)*SR+st:(0.05+0.0025)*SR+et))-base*(et-st+1);
    end
    end