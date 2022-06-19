function R = uppertrian(A)
format
[m,n]=size(A);
R=A;
k=min(m,n)
for i=1:k
    for j=m:-1:i+1
       if R(j,i)~=0
           b=R(j,i);
           a=R(i,i);
           G=givensrot(m,i,j,a,b);
           R=G'*R;
       end
    end
end  
R=closetozeroroundoff(R,12);
disp('the output matrix R is')
disp(R)
test1=1;
test2=1;
if ~istriu(R)==1
    test1=0;
end
for i=1:n
    if closetozeroroundoff(norm(A(:,i))-norm(R(:,i)),7)~=0
        test2=0;
        break
    end
end
if test1 & test2
    disp('A has been reduced correctly to an uppertriangular matrix R')
else
    disp('the output matrix R is not what was expected?!')
end
end

