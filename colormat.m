function color=colormat(A)
  [n,m]=size(A);
  color=zeros(1,n);
  c=1;
  color(1)=c;
  for i=2:n
      palette=[];
      for j=1:m
	 if j!=i && abs(A(i,j))>0 
           palette=[palette color(j)];
	 end
      end
      palette=palette(palette > 0);
      for ic=1:c
        colorfound=0;
        for k=1:length(palette)
          if ic ==palette(k) 
	     colorfound=1;
             break;
          end
	end
        if (colorfound==0)
	    color(i)=ic;
	    break;
        end
      end
      if (colorfound==1)
	    c=c+1;
            color(i)=c;
      end
  end
	   
