% create banded matrix
N=64;
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
B=rand(1,N);
%
niter=20;
display("--Original method ---")
dq1=sweepsolve_orig(A,B,colors,colormap,cft,niter);
display("--Low fetch method ---")
dq2=sweepsolve_lowfetch(A,B,colors,colormap,cft,niter);
%dq=sequential_gs(A,B,niter);
