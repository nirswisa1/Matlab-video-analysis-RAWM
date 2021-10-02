function out=grades(rawhistory)
%This function gets a vector of numbers presenting the history of arms the
%mouse has been in. It returns the grades of each arm:
%0=no entry to arm, 1=one entry to arm, 
%2=one normal entry to arm and another short entry, 3= two long entries,
%4=3 or more entries to the same arm.
    armsHistory=zeros(30,6);
    armsGrade=[0 0 0 0 0 0];
    line=0;
    curarm=0;
    out=0;
    for i=rawhistory'
        if i==0
            continue
        elseif curarm~=i
            line=line+1;
            armsHistory(line,i)=armsHistory(line,i)+1;
        elseif curarm==i
            armsHistory(line,i)=armsHistory(line,i)+1;
        end
        curarm=i;
    end
    for i=1:6
        if nnz(armsHistory(:,i))>2
            % re-entering more than twice
            armsGrade(1,i)=4; 
        elseif nnz(armsHistory(:,i))==2
            a=nonzeros(armsHistory(:,i));
            if a(1,1)/a(2,1)>1.99 || a(1,1)/a(2,1)<0.51
                %entering twice but realizing the arm is familier and leaving quick
                armsGrade(1,i)=2; 
            else
                %entering twice for a long period of time
                armsGrade(1,i)=3; 
            end
        elseif nnz(armsHistory(:,i))==1
            %one entrence
            armsGrade(1,i)=1; 
        end
    end
    out=armsGrade;
end
