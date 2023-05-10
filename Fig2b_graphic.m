%%%%% make m file including DR, StimPulse, EventTiming
%%%%% ch1,11 stimulated
%%%%% ch2,12 recorded
clear all
%clf

savename2 = ['Y0425132162'];
SR = 44;

for dline = [1:8]
    if dline == 1 %%% Rest
        sname = [savename2,'Rest'];
    elseif dline == 2  %%% AM Extension
        sname = [savename2,'AMExt'];
    elseif dline == 3     %%% AH Extension
        sname = [savename2,'AHExt'];
    elseif dline==4            %% PM Extension
        sname = [savename2,'PMExt'];
    elseif dline == 5  %%% AM Flexion
        sname = [savename2,'AMFlex'];
    elseif dline == 6     %%% AH Flexion
        sname = [savename2,'AHFlex'];
    elseif dline==7            %% PM Flexion
        sname = [savename2,'PMFlex'];
    else
        sname = [savename2,'Allstim']; %%%all
        %sname = [savename,'1'];
    end
    
    load(sname);
    avdata{dline} = avdat_DR; tnum{dline} = size(aldat_DR,2);
end

figure(1)
clf
subplot(4,4,[1 2 3 4 5 6 7 8]),%plot(aldat(:,:,4),'k'),hold on,
plot(avdata{1},'k','LineWidth',0.8), title('spinal stim -> DR cuff rec'), hold on
plot(avdata{2},'r'), plot(avdata{3},'c'),
plot(avdata{4},'g'), plot(avdata{5},'r:'),
plot(avdata{6},'c:'), plot(avdata{7},'g:'),
plot(avdata{8},'b','LineWidth',0.8),
plot([5.1*SR 5.1*SR],[-1 1],'k:'), plot([6.1*SR 6.1*SR],[-1 1],'k:'), 
axis([1 length(avdat_DR) -1 1]), 
legend(['Rest',num2str(tnum{1})],['AME',num2str(tnum{2})],...
    ['AHE',num2str(tnum{3})],['PME',num2str(tnum{4})],...
    ['AMF',num2str(tnum{5})],['AHF',num2str(tnum{6})],...
    ['PMF',num2str(tnum{7})],['all',num2str(tnum{8})])

p=[0,1,2,3,4,5,6,7,8,9,10,11,12];
set(gca,'xtick',p.*SR)
set(gca,'XTickLabel',{'-2','','Stim','','','','' '5','','','','' '10'})


r = [5.2*SR 5.8*SR];
subplot(4,4,9), plot(avdata{8},'k','LineWidth',0.8), title('All stimuli'), axis([5.1*SR 6.1*SR -0.4 0.4])
subplot(4,4,10), plot(avdata{8},'k','LineWidth',0.8), title('AME'), hold on
plot(avdata{2},'c'), axis([r(1) r(2) -0.4 0.4])
subplot(4,4,11), plot(avdata{8},'k','LineWidth',0.8), title('AHE'), hold on
plot(avdata{3},'c'), axis([r(1) r(2) -0.4 0.4])
subplot(4,4,12), plot(avdata{8},'k','LineWidth',0.8), title('PME'), hold on
plot(avdata{4},'c'), axis([r(1) r(2) -0.4 0.4])
subplot(4,4,13), plot(avdata{8},'k','LineWidth',0.8), title('Rest'), hold on
plot(avdata{1},'b'), axis([r(1) r(2) -0.4 0.4])
subplot(4,4,14), plot(avdata{8},'k','LineWidth',0.8), title('AMF'), hold on
plot(avdata{5},'r'), axis([r(1) r(2) -0.4 0.4])
subplot(4,4,15), plot(avdata{8},'k','LineWidth',0.8), title('AHF'), hold on
plot(avdata{6},'r'), axis([r(1) r(2) -0.4 0.4])
subplot(4,4,16), plot(avdata{8},'k','LineWidth',0.8), title('PMF'), hold on
plot(avdata{7},'r'), axis([r(1) r(2) -0.4 0.4])
