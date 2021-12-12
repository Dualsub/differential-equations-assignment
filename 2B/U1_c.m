clc, clear

dom = (4:8);
alpha=400; 
xbar=pi/5;

errprimv = zeros(size(dom));
errbisv = zeros(size(dom));

for m=dom
    N=2^m; 
    xv=(0:N-1)/N;
    fv=exp(-alpha*(xv-xbar).^2); 
    fprimanav=-2*alpha*(xv-xbar).*exp(-alpha*(xv-xbar).^2);
    fbisanav=((-2*alpha*(xv-xbar)).^2-2*alpha).*exp(-alpha*(xv-xbar).^2);
    fk=fftshift(fft(fv)); 
    kvec=-N/2:N/2-1; 
    
    fprimv = real(ifft(ifftshift((i*2*pi*kvec) .*fk)));
    fbisv = real(ifft(ifftshift((i*2*pi*kvec).^2 .* fk)));

    errprimv(m-3) = real(sqrt(1/N * sum(abs(fprimv - fprimanav).^2)));
    errbisv(m-3) = real(sqrt(1/N * sum(abs(fbisv - fbisanav).^2)));
end

X = log10(2.^dom);
hold on;
plot(X, log10(errprimv));
plot(X, log10(errbisv));
hold off;

title("Norm-2 fel av $Df$ samt $D^2f$",'Interpreter','latex');
legend(["$|Df - f'|_2$", "$|D^2 f - f''|_2$"],'Interpreter','latex');
xlabel("$log N$",'Interpreter','latex');
ylabel("$log Fel$",'Interpreter','latex');