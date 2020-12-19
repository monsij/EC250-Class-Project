function probRx = calcProb(particle_state,TxPos,RxPos,RxPosNum,timeInst)
    load('./Psi_r.mat');
    probRx = zeros(size(particle_state,1),1);
    for i=1:length(probRx)
        cos_phi_T = (((TxPos(1,1)-particle_state(i,1))*cos(particle_state(i,3))) ...
            +((TxPos(1,2)-particle_state(i,2))*sin(particle_state(i,3)))) ...
            /sqrt((TxPos(1,1)-particle_state(i,1))^2+(TxPos(1,2)-particle_state(i,2))^2);
        
        cos_phi_r = (((RxPos(RxPosNum,1)-particle_state(i,1))*cos(particle_state(i,3))) ...
            +((RxPos(RxPosNum,2)-particle_state(i,2))*sin(particle_state(i,3)))) ...
            /sqrt((RxPos(RxPosNum,1)-particle_state(i,1))^2+(RxPos(RxPosNum,2)-particle_state(i,2))^2);
        meanVal = abs (cos_phi_T + cos_phi_r);
        sigmaW = 0.1;
        prob = 1/(sqrt(2*pi)*sigmaW)* exp(-0.5 * ((Psi_r(timeInst,RxPosNum)-meanVal)/sigmaW)^2);
        probRx(i,1) = prob;
    end

end