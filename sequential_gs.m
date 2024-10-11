function dq=sequential_gs(A,B,niter)
%
[N,M]=size(A);
indx=[1:N];
dq=zeros(1,N);
for n=1:niter
  is=0;
  if (n > 1)
    is=1;
  end
  for i=1+is:N
     neig=indx(abs(A(i,:)) > 0);
     rhs=B(i);
     for j=1:length(neig)
        ineig=neig(j);
        if (ineig!=i)
	  rhs=rhs-A(i,ineig)*dq(ineig);
        end
     end
     dq(i)=rhs/A(i,i);
  end
  for i=N-1:-1:1
     neig=indx(abs(A(i,:)) > 0);
     rhs=B(i);
     for j=1:length(neig)
        ineig=neig(j);
        if (ineig!=i)
	  rhs=rhs-A(i,ineig)*dq(ineig);
        end
     end
     dq(i)=rhs/A(i,i);
  end
  norm(A*dq'-B')
end

