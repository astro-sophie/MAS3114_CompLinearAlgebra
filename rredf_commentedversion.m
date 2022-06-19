function R=rredf(A)
format
[m,n]=size(A);
rankA=rank(A);
A=sym(A);
R=A;
%Forward Phase
for k=1:m %iterates through rows of A, creating submatrices out of the rows k and below
    X=R(k:m,:); %cuts off the top rows of A as k increases
    i=find(any(X),1); %Finds the column containing nonzero values
    [~,j]=max(abs(X(:,i))); %Finds the row with the highest value in the pivot column
    if j~=1
        X([1 j],:)=X([j 1],:); %causes the row with the greatest value in the pivot column to become the top row in the submatrix
    end
    if k<m %if the row is not the last row
        for p=2:m-k+1 % goes through rows 2 through m-k+1
            if X(p,i)~=0 
                r=-X(p,i)/X(1,i); % finds the scaling factor for row reduction
                X(p,:)=X(p,:)+(r*X(1,:)); %performs the row reduction
            end
        end
    end
    R(k:m,:)=X; % this inserts the submatrix we've been working on into the actual matrix
    R=closetozeroroundoff(R,7);
end
%Backward Phase
for k=rankA:-1:1 % goes though the rows from last to first
    j=find(any(R(k,:),1),1); % finds the pivot column
    h=1/R(k,j); % finds the factor that we use to make the pivot 1
    R(k,:)=h*R(k,:); % performs the scaling
    if k>1
        for i=1:k-1 % goes down the column until right before the pivot
            if R(i,j)~=0 % only row reduces if it's not already 0
                r=R(i,j); % finds the scaling factor (since the pivot is already 1)
                R(i,:)=R(i,:)-(r*R(k,:)); % performs the row reduction using the pivot
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



