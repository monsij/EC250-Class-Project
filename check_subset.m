function res=check_subset(arr1, arr2)
% The first argument is checked if it is a subset of second.
% In other words, size(arr_1) <= size(arr_2)
l = length(arr1);
m = length(arr2);
cnt = 0;
for i=1:l
    for j=1:m
        if(round(arr1(1,i),3)==round(arr2(1,j),3))
            cnt = cnt + 1;
            %break;
        end
    end
end

if cnt < l
    res = false;
else
    res = true;
end
            

end