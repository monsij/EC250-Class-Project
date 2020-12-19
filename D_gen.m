function arr1 = D_gen(arr)
% This function generates the set of absolute pairwise differences.
l = length(arr);
arr1 = zeros(1,l*(l-1)/2);
arr1 = arr1 - 1;
cnt = 1;
for i=1:l
     for j=i+1:l
         x = abs(arr(i)-arr(j));
         arr1(cnt)=x;
         cnt = cnt + 1;
     end
end

end


% S = [1 -0.481 0.3900];
% l = length(S);
% D = zeros(1,l*(l-1)/2);
% D = D - 1;
% cnt=1;
% for i=1:l
%     for j=i+1:l
%         x = abs(S(i)-S(j));
%         D(cnt)=x;
%         cnt = cnt + 1;
%     end
% end
