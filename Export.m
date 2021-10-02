function Export(expData1,expData2,expData3)
%This function exports the data results into an excel sheet named 'Project'.
%It uses a variable named 'where_to_insert' in order to keep track of the
%last line used in excel so it won't overwrite it.
%expData1 - trail name
%expData2 - duration (in seconds)
%expData3 - a vector of 6 digits that present 6 arms of the maze's grades:
%0=no entry to arm, 1=one entry to arm, 
%2=one normal entry to arm and another short entry, 3= two long entries,
%4=3 or more entries to the same arm.
    load 'where_to_insert.mat';
    a=where_to_insert;
    ins=['A',num2str(a)];
    xlswrite('Project',expData1,'Sheet1',ins);
    a=a+1;
    ins1=['A',num2str(a)];
    xlswrite('Project',expData2,'Sheet1',ins1);
    a=a+1;
    ins2=['A',num2str(a)];
    xlswrite('Project',expData3,'Sheet1',ins2);
    
    where_to_insert=where_to_insert+3;
    save('where_to_insert','where_to_insert')
end