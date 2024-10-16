% standard Gauss-Seidel algorithm
function dq1=sweepsolve_orig_noinit(A,B,colors,colormap,cft,niter,dq)
[N,M]=size(A);
ncolors=length(cft)-1;
indx=[1:N];
%dq=zeros(1,N);
%dq=dq*0;
%niter=20;
%
for n=1:niter
 is=1;
 % dont repeat the first color after 1st iteration
 % so that we do c1,c2,c3,c4,c3,c2,c1,c2,c3,c4,c3,c2,c1
 % I don't think we are doing this right now in rapidus
 % or mini-app
 if (n > 1)
   is=2;
 end
 for idir=1:-2:-1
  cstart=round((idir+1)/2)*is+round((1-idir)/2)*(ncolors-1);
  cend =round((1-idir)/2)+round((idir+1)/2)*ncolors;
  for c=cstart:idir:cend
    for ii=cft(c):cft(c+1)-1
	i=colormap(ii);
        rhs=B(i);
	neig=indx(abs(A(i,:)) > 0);
	for j=1:length(neig)
	  ineig=neig(j);
          if (ineig!=i)
	    rhs=rhs-A(i,ineig)*dq(ineig);
	  end
	end
	dq(i)=rhs/A(i,i);
     end
   end
  end
  norm(A*dq'-B')   
end
dq1=dq;
