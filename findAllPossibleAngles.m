function angle_set = findAllPossibleAngles(Q,psi_ref, n_cap)
% This function implements Algorithm-1 [1]
M = length(Q);
vps_set_prev = {[psi_ref-Q(1),psi_ref]};
for i=2:M
    vps_set_curr = vps_set_prev;
    for j=1:size(vps_set_prev,1)
        test_set_1 = [vps_set_prev{j,1},psi_ref-Q(i)];
        test_set_2 = [vps_set_prev{j,1},psi_ref-Q(1)+Q(i)];
        
        if check_subset(D_gen(test_set_1),Q)==1
            vps_set_curr(size(vps_set_curr,1)+1,:)={test_set_1};
        end
        
        if check_subset(D_gen(test_set_2),Q)==1
            vps_set_curr(size(vps_set_curr,1)+1,:)={test_set_2};
        end
    end
    vps_set_prev = vps_set_curr;
end
angle_set = vps_set_curr;
end


% Intro to cell arrays
% vps= {[1,2];[1,6,3]};
% a = vps{1,1};
% a(1,2)
% new_set = [8,9,3,11];
% vps(size(vps,1)+1,:) = {new_set};
