% Add salt and pepper noise to image I.
% p - % of noise. range: 0,1,...,100.
function nI = addSnpNoise(I,p)
	p=100-p;
	[m,n]=size(I);
	ind = randi([-100 100],[m n]);
	nI = I;
	nI(ind>p)=255;
	nI(ind<-p)=0;
end