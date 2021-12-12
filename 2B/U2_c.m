clc, clear

N = 16;
t = 0.1;

xv = (0:N-1) * 1/N;
fv = sin(2*pi*xv);
uanav = sin(2*pi*xv) * exp(-(2*pi).^2 * t);
kv = -N/2:N/2-1;

fkv = 1/N*fftshift(fft(fv)); 
uk = exp(-(2*pi*kv).^2 * t).*fkv;
uv = real(N*ifft(ifftshift(uk)));

err = abs(uv-uanav);

hold on;
% plot(xv, uv);
% plot(xv, uanav);
plot(xv, err);
hold off;

