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
figure(1);
plot(t,n1);
xlabel('t'); ylabel('X(t)');
%% c)
n=n1(33:1999);
a1=126.28; a2=-62.83; a3=622; a4=-5.76*2*pi/180;
t1=0:dt:0.08;
h=a1*exp(a2*t1).*cos(a3*t1+a4*ones(size(t1)));
y1=dt*conv(h,n);
t=0:dt:(size(y1)(2)-1)*dt;
figure(2);
plot(t,y1);
xlabel('t'); ylabel('Y(t)');
