function [Shat] = spect_est_ac(x, dt, M)
% Umritun á corspec úr kafla 7-9
fs=1/dt;
[a,b]=size(x);
if a<b % Gera inntak að dálkvigur
    x=x';
    N=b;
else
    N=a;
end
x1=detrend(x,0); % Fjarlægja fastaþátt.
x1(2*N-2)=0;
R1=real(ifft(abs(fft(x1)).^2));
W=triang(2*N-1);
R2=[R1(N:2*N-2);R1(1:N-1)]./((N)*W(1:2*N-2));
R3=R2(N-M:N+M-1);
H=hamming(2*M+1);
R4=R3.*H(1:2*M);
k=2^(ceil(log2(2*M))+2);
S1=abs((1/fs)*fft(R4,k));
Shat = S1;
