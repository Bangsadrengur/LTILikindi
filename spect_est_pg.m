function [Shat] = spect_est_pg(x, dt)
Fx = fft(x);
absSquare = ((abs(Fx)).^2)./length(x);
Shat = dt.*absSquare;
