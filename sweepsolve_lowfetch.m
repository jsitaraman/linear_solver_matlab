% function to show algorithm for low fetch
% colored Gauss-Seidel
function dq=sweepsolve_lowfetch(A,B,colors,colormap,cft,niter)
%A=A1;
%B=B1;
[N,M]=size(A);
ncolors=length(cft)-1;
indx=[1:N];
dq=zeros(1,N);
adq=zeros(1,N);
%niter=20;
% precondition with diagonals once so that 
% we don't have to fetch A(i,i)
% this can be already included in the
% Jacobian calculation
for i=1:N
  B(i)=B(i)/A(i,i);
  A(i,:)=A(i,:)/A(i,i);
end
%
for n=1:niter
 is=1;
 % dont repeat the first color after 1st iteration
 % because we are redoing what we did in the revere sweep
 % unnecessarily
 % so that we do c1,c2,c3,c4,c3,c2,c1,c2,c3,c4,c3,c2,c1
 if (n > 1)
   is=2;
 end	
 for idir=1:-2:-1
  cstart=round((idir+1)/2)*is+round((1-idir)/2)*(ncolors-1);
  cend =round((1-idir)/2)+round((idir+1)/2)*ncolors;	    
  %cstart=round((idir+1)/2)+round((1-idir)/2)*(ncolors);
  %cend =round((1-idir)/2)+round((idir+1)/2)*ncolors;
  for c=cstart:idir:cend
    for ii=cft(c):cft(c+1)-1
	i=colormap(ii);
	rhs=B(i)-adq(i);
        adq(i)=0;
	neig=indx(abs(A(i,:)) > 0);
	for j=1:length(neig)
	  ineig=neig(j);
	  % in forward sweep we only use lower color off diagonals
	  % and in backward sweep we only use upper color off diagonals
	  % may be this can help with fetch
	  % we do have to fetch an extra vector now, but since it is a 
	  % vector, it has smaller overhead
          if (colors(ineig)*idir < c*idir)
	    rhs=rhs-A(i,ineig)*dq(ineig);
	    if (c!=ncolors && c!=1)
  	      adq(i)=adq(i)+A(i,ineig)*dq(ineig);
	    end
	  end
	end
	dq(i)=rhs; %/A(i,i);
     end
  end
  %we have to zero out the the off-diagonal product for 
  %min/max colors even if are not iterating the color
  %if (idir==-1)
  %  for ii=cft(ncolors):cft(ncolors+1)-1
  %     i=colormap(ii);
  %     adq(i)=0;
  %  end
  %else
  %  for ii=cft(1):cft(2)-1
  %     i=colormap(ii);
  %     adq(i)=0;
  %  end
  %end
 end     
 norm(A*dq'-B')
end

