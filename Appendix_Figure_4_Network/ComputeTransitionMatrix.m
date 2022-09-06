function TransitionMatrix=ComputeTransitionMatrix(X_final,cutoff)
%  TransitionMatrix=ComputeTransitionMatrix(X_final,cutoff)
% Computes Transition matrix from a sequence of input X_final and given a
% cutoff.
% Arguments: 
%       - X_final is NxT where N is the number of neurons and T the
%       time variable
%       - cutoff is the cutoff used. We can use different cutoffs by giving
%       a vector of cutoffs (vector needs to be exactly of length N,
%       otherwise takes by the default the first value. 

N=size(X_final,1);

X_finalb=X_final(:,2:end);
X_final=X_final(:,1:end-1);
loopind={};
cutoffi=cutoff(1);
for i=1:N
    if length(cutoff)==N
        cutoffi=cutoff(i);
    end
    loopind{i} = find(X_finalb(i,:)>cutoffi & X_final(i,:)<cutoffi);
end


TransitionMatrix=zeros(N);
Next=zeros(1,N);

for j=1:N
    j;
    loopind1=loopind{j};
    for i=1:(length(loopind1)-1)
    current=loopind1(i);
    for k=1:N
        Next(k)=min([loopind{k}(loopind{k}>current),Inf]);
    end
    [a,in]=min(Next);
    TransitionMatrix(j,in)=TransitionMatrix(j,in)+1;
    end
    TransitionMatrix(j,:)=TransitionMatrix(j,:)/sum(TransitionMatrix(j,:));
end
TransitionMatrix
