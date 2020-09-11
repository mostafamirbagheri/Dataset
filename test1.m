clc;
clear;
close all;
%%
fname = 'Dataset/1.edf';
[hdr, record] = edfread(fname);
%%
Fs = 256;
t = 0:1/Fs:(length(record)-1)/Fs;
%%
d = designfilt('bandpassfir','FilterOrder',900, ...
         'CutoffFrequency1',0.1,'CutoffFrequency2',40, ...
         'SampleRate',Fs);
%%
filterd_y = filtfilt(d,record')';
%%
subplot(2,1,1); plot(t,record(1,:)); axis tight; title('EEG');
subplot(2,1,2); plot(t,filterd_y(1,:)); axis tight; title('filterd EEG');
%%
waveletName='db5';
level=5;
%%
figure();
[C,L]=wavedec(filterd_y(1,:),level,waveletName);
cD1 = detcoef(C,L,1);                   %NOISY
cD2 = detcoef(C,L,2);                  %Gamma
cD3 = detcoef(C,L,3);                   %Beta
cD4 = detcoef(C,L,4);                   %Alpha
cD5 = detcoef(C,L,5);                   %Delta
cA5 = appcoef(C,L,waveletName,5);   %Theta


subplot(6,1,1)
plot(cA5)
title('Approximation Coefficients Theta')
subplot(6,1,2)
plot(cD5)
title('Level 5 Detail Coefficients Delta')
subplot(6,1,3)
plot(cD4)
title('Level 4 Detail Coefficients Alpha')
subplot(6,1,4)
plot(cD3)
title('Level 3 Detail Coefficients Beta')
subplot(6,1,5)
plot(cD2)
title('Level 2 Detail Coefficients Gamma')
subplot(6,1,6)
plot(cD1)
title('Level 1 Detail Coefficients Noise')

%%
figure();
cw1 = cwt(record(1,:),1:32,'sym2','plot'); 
title('Continuous Transform, absolute coefficients.') 
ylabel('Scale')
%%
figure();
[cw1,sc] = cwt(record(1,:),1:32,'sym2','scal');
title('Scalogram') 
ylabel('Scale')


