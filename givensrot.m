function G=givensrot(m,i,j,a,b)
G=eye(m);
r=hypot(a,b);
c=a/r;
s=b/r;
G(i,i)=c; G(i,j)=-s; G(j,i)=s; G(j,j)=c;
end

