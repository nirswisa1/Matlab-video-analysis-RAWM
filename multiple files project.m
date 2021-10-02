function multiple_files_project(num1,num2,plotfalg)
%This function accepts num1, num2 variables and runs main function on all
%relevent files.
%plotflag accepts 1 or 0.
%   1- will present "live" view of the binary image
%   next to the actual frame. It will also show it's trail.
%num1-starting file
%num2-ending file
    for i=num1:num2
        filename=[num2str(i),'.mpg'];
        main(filename,plotfalg)
    end
end