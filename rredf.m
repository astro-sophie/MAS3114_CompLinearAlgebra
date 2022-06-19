function R=rredf(A)
format
[m,n]=size(A);
rankA=rank(A);
A=sym(A);
R=A;
%Forward Phase
for k=1:m
    X=R(k:m,:);
    i=find(any(X),1);
    [~,j]=max(abs(X(:,i)));
    if j~=1
        X([1 j],:)=X([j 1],:);
    end
    if k<m
        for p=2:m-k+1
            if X(p,i)~=0
                r=-X(p,i)/X(1,i);
                X(p,:)=X(p,:)+(r*X(1,:));
            end
        end
    end
    R(k:m,:)=X;
    R=closetozeroroundoff(R,7);
end
%Backward Phase
for k=rankA:-1:1
    j=find(any(R(k,:),1),1);
    h=1/R(k,j);
    R(k,:)=h*R(k,:);
    if k>1
        for i=1:k-1
            if R(i,j)~=0
                r=R(i,j);
                R(i,:)=R(i,:)-(r*R(k,:));
            end
        end
    end
    R=closetozeroroundoff(R,7);
end
disp('the constructed matrix R is')
disp(double(R))
rf=rref(A)
if closetozeroroundoff(R-rf,7)==0
    disp('R is the reduced echelon form of A')
    R=double(R);
else
    disp('Something went wrong!')
    R=[]
end
end

