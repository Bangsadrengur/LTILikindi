%wtype=input('Window type(boxcar-1, hamming-2, hanning-3)=');
%stype=input ('Spectrum type(peaked-1,smooth-2)=');
function [Shat] = spect_est_x(x, dt, wtype, stype)
% Útdráttur úr perspec.m úr bók (bls. 459).

Ls=16; % Fixed value from example from book.
N=8; % Fixed value from example from book.
fs = 1/dt;
%wtype=input('Window type(boxcar-1, hamming-2, hanning-3)=');
if wtype == 1
    w1=boxcar(Ls);
end
if wtype==2
    w1=hamming(Ls);
end
if wtype==3
    w1=hanning(Ls);
end
%stype=input ('Spectrum type(peaked-1,smooth-2)=');
if stype==1
    w=w1/(sum(w1)/sqrt(fs*Ls));
end
if stype==2
    w=w1/sqrt(sum(w1.^2)/Ls);
end

Lx=length(x);
x=x(:);
n1=fix((Lx-N)/(Ls-N));
n2=2^(2+round(log2(Ls)));
a=1:Ls;
SX=zeros(n2,1);
SXX=zeros(n2,1);

for k=1:n1;
    xw=w.*detrend(x(a),0);
    XW=abs(fft(xw,n2)).^2;
    SX=SX+XW;
    SXX=SXX+abs(XW).^2;
    a=a+(Ls-N);;
end

S2=(1/(n1*fs*Ls))*SX;

if n1==1
    SXX2=(1/((n1)*(fs*Ls)^2))*SXX;
end
if n1 >= 2
    SXX2=(1/((n1-1)*(fs*Ls)^2))*SXX;
end

%% Skipping confidence levels
Shat=S2;
