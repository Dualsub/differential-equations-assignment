clc, clear

n = 6;
t = 0.1;

% Beräknar referenslösning
N = 2^11;

kv = -N/2:N/2-1;
xv = (0:N-1) * 1/N;
fv = etafcn(2*abs(xv - 0.5), 0.005);

fkv = 1/N*fftshift(fft(fv)); 
uk = exp(-(2*pi*kv).^2 * t).*fkv;
urefv = real(N*ifft(ifftshift(uk)));

% Beräknar fel
errv = zeros(1, n);
for i=(1:n)
    m = i + 3;
    N = 2^m;
    
    kv = -N/2:N/2-1;
    xv = (0:N-1) * 1/N;
    fv = etafcn(2*abs(xv - 0.5), 0.005);

    fkv = 1/N*fftshift(fft(fv)); 
    uk = exp(-(2*pi*kv).^2 * t).*fkv;
    uv = real(N*ifft(ifftshift(uk)));

    errv(i) = sqrt(1/N * sum(abs(uv-urefv(1:2^(11-m):end)).^2));
end

hold on;
%plot(xv, uv);
%plot(xv, urefv);
plot(log10(2.^(4:n+3)), log10(errv));
hold off;

