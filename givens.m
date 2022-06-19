function G=givens(m,i,j,theta)
format
G=[];
if 1 <= i  && i < j && j <= m && m >= 2
    G=eye(m);
    c=cos(theta);
    s=sin(theta);
    G(i,i)=c; G(i,j)=-s; G(j,i)=s; G(j,j)=c;
    disp('the Givens rotation matrix G is')
    disp(G)
else
    disp('a Givens rotation matrix cannot be constructed')
end

