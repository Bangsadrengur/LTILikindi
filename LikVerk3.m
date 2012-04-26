% Útdráttur úr sysxmp5.m úr bók
%% b)
fs=2000;
dt=1/fs;
t2=0:dt:0.016; % 0.016 / dt + 1 = 33 punktar 
hn=exp(-600*t2);
hn(1)=0.5*hn(1); % Helmingsvægi endapunkta
randn('seed',500);
x=sqrt(6000*2000)*randn(1,2000);
n1=dt*conv(hn,x); % Sýni úr inntaki
t=0:dt:(size(n1)(2)-1)*dt;
figure(1, 'visible', 'off');
plot(t,n1);
xlabel('t'); ylabel('X(t)');
print -deps fig1.eps
%% c)
n=n1(33:1999);
a1=126.28; a2=-62.83; a3=622; a4=-5.76*2*pi/180;
t1=0:dt:0.08;
h=a1*exp(a2*t1).*cos(a3*t1+a4*ones(size(t1)));
y1=dt*conv(h,n);
t=0:dt:(size(y1)(2)-1)*dt;
figure(2, 'visible', 'off');
plot(t,y1);
xlabel('t'); ylabel('Y(t)');
print -deps fig2.eps
%% d) 1. 
S1=spect_est_pg(y1,dt);
tau1=(length(S1)-1)/2;
figure(3, 'visible', 'off');
plot([-tau1:tau1]./10,S1);
xlabel('f'); ylabel('S_y(f)');
print -deps fig3.eps
%% d) 2.
% M sett á gildi 16 þar sem slíkt gildi
% er notað í dæmi í námsbók.
S2=spect_est_ac(y1,dt, 16);
tau2=(length(S2)-1)/2;
figure(4, 'visible', 'off');
plot([-tau2:tau2].*1.75,S2);
xlabel('f'); ylabel('S_y(f)');
print -deps fig4.eps
%% d) 3. Hamming
S3=spect_est_x(y1,dt, 2, 1);
tau3=(length(S3)-1)/2;
figure(5, 'visible', 'off');
plot([-tau3:tau3].*3.7,S3);
xlabel('f'); ylabel('S_y(f)');
print -deps fig5.eps
%% d) 3. Hanning
S4=spect_est_x(y1,dt, 3, 1);
tau4=(length(S4)-1)/2;
figure(6, 'visible', 'off');
plot([-tau4:tau4].*3.7,S4);
xlabel('f'); ylabel('S_y(f)');
print -deps fig6.eps
%% Samanburður Hamming og hanning.S3 er Hamming, S4 er Hanning.
figure(7, 'visible', 'off');
plot([-tau4:tau4].*3.7,S4-S3);
xlabel('f'); ylabel('Hanning Sy - Hamming Sy');
print -deps fig7.eps
%% Fræðilegt S_y við nyquistgilda söfnunartíðni.
fN=2*(2*pi*fs);
Sy=(6.0792*10^4).*fN.^2./(fN.^6-1.01811.*10.^4.*fN.^4 ...
+7.88969.*10.^2.*fN.^2+8.93744.*10.^4);
bias1=(Sy-mean(S1)).^2
var1=var(S1)
mse1=bias1.^2+var1;
mse1=mean(mse1)
bias2=(Sy-mean(S2)).^2
var2=var(S2)
mse2=bias2.^2+var2;
mse2=mean(mse2)
bias3=(Sy-mean(S3)).^2
var3=var(S3)
mse3=bias3.^2+var3;
mse3=mean(mse3)
bias4=(Sy-mean(S4)).^2
var4=var(S4)
mse4=bias4.^2+var4;
mse4=mean(mse4)
