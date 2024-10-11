function A=bandedmat(N,v)
 A=zeros(N,N);
 m=length(v);
 mby2=floor(m/2);
 for i=1:N
  for j=1:m
    c=(i+(j-mby2-1));
    if (c > 0 && c < N+1) 
      A(i,c)=v(j);
    end
  end
 end 
      
