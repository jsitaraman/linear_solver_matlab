% create banded matrix
N=64;
%format long;
A=bandedmat(N,[0.1,0.1,0.2,-2,0.2,0.1,0.1]);  
% color the columns using a greedy scheme
colors=colormat(A);
% sort to get the colormap index order
[sorted,colormap]=sort(colors);
% create the cumulative frequency table on a color basis
cft=[1];
for i=2:N
  if sorted(i)!=sorted(i-1)
     cft=[cft i];
  end
end
cft=[cft N+1];
% make some RHS
B0=[1:N]*0.1;
dq1=zeros(1,N);
adq1=zeros(1,N);
%
nlinear_iter=5;
nonlinear_iter=10;
q=zeros(1,N);
for it=1:nonlinear_iter
   for k=1:N
     % create a weakly non-linear system
     A(k,k)=-2+0.01*q(k);
   end
   B=B0-q*A;
   dq1=sweepsolve_orig_noinit(A,B,colors,colormap,cft,nlinear_iter,dq1);
   %[dq1,adq1]=sweepsolve_lowfetch_noinit(A,B,colors,colormap,cft,nlinear_iter,dq1,adq1);
   q=q+dq1;
   display(sprintf("nonlinear iter %d=%e\n",it,norm(dq1)));
end
