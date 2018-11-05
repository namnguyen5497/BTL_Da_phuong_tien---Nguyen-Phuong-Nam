myRecord = audioread('orig_input.wav'); %am thanh ghi am ban dau

fs=44100;% tan so lay mau
t=0:1/fs:0.3;

% chia file thanh cac doan co so phan tu ma tran bang nhau
a1 = myRecord(40000:100000); 
a2 = myRecord(100000:172000); 
a3 = myRecord(172000:256000); 
a4 = myRecord(220000:316000);
a5 = myRecord(316000:424000);


%thay doi chieu dai cua tung doan 
x1 = a1(1:1:length(a1));
x2 = a2(1:1.2:length(a2));
x3 = a3(1:1.4:length(a3));
x4 = a4(1:1.6:length(a4));
x5 = a5(1:1.8:length(a5));


b= [ x1; x2; x3; x4; x5 ];% tin hieu nhip dieu nhanh dan
%tao tan so cac not nhac A B C D E 
fA=440;
fB=493.88;
fC=554.37;
fD=587.33;
fE=659.26;
% cac gia tri bien do
A1=.3;
A2=A1/2;
A3=A1/3;
A4=A1/4;
A5=A1/5;

%tin hieu tone 
A= A1*sin(2 * pi * fA * t);
B= A2*sin(2 * pi * fB * t);
C= A3*sin(2 * pi * fC * t);
D= A4*sin(2 * pi * fD * t);
E= A5*sin(2 * pi * fE * t);

%tao random tones
tone =[ A B C D E D C E C B A A B C D E A B E C B A B D C];
tone_new = tone(1:length(b));% tao ma tran tone cung do dai ma tran giong noi
m = tone_new' + b;% tron hai tin hieu ma tran tone va giong noi

%output file " melody.wav"
audiowrite('melody.wav',m,44100); 

%FFT tin hieu melody
N=fs; % so diem thuc hien FFT
transform = fft(m,N)/N;
magTransform=abs(transform);
f_axis= linspace(-fs/2,fs/2,N);
subplot(2,1,1);
plot(f_axis,fftshift(magTransform));
xlabel('Frequency (Hz)');
title('Fast Fourier Transform');

%Spectrogram tin hieu melody
win = 128; 
hop = win/2;            
nfft = win;
subplot(2,1,2);
spectrogram(m,win,hop,nfft,fs,'yaxis');
title('Spectogram of Melody');
