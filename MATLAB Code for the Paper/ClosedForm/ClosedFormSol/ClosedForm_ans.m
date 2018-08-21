%-------------------------------------------------------------------------%
% Compute closed form analytical solution and corresponding two IRFs and
% longer simulation for Brock-Mirman (1972) infinite horizon model for
% which the closed form solution is known
%-------------------------------------------------------------------------%
% This program calls the following .mat file(s)
%     * ClosedFormParams.mat: loads common parameter values into memory
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% Opening Commands
%-------------------------------------------------------------------------%
clear ;
%cd('/Users/rwe2/Documents/BYU Economics/Paper Ideas/CSL/MatLab/ClosedForm/ClosedFormSol') ;

starttime = clock ; % start timer

%-------------------------------------------------------------------------%
% Read in parameters
%-------------------------------------------------------------------------%
% beta     = per-period discount factor
% alpha    = capital share of income, production function parameter
% L        = individual endowment of inelastically supplied labor
% mu       = unconditional mean of AR(1) process for z
% rho      = per-period persistence in AR(1) process for z
% sigma    = per-period standard deviation of shock in z process
% Tirf     = scalar, number of periods to simulate in IRFs
% Tsim     = scalar, number of periods to simulate in simulation test
% kss      = scalar, certainty-equivalent steady-state capital stock
% zvec     = znodes x 1 vector, discretized support of z
% zTrans   = znodes x znodes matrix, Tauchen-Hussey Markov transition
%            matrix for z
% zirfvec1 = 1 x Tirf vector of productivity levels for IRF1
% zirfvec2 = 1 x Tirf vector of productivity levels for IRF2
% zsimvec3 = 1 x Tsim vector of productivity levels for the simulation
%-------------------------------------------------------------------------%
load '../ParamSet/ClosedFormParams.mat' beta alpha L mu rho sigma Tirf ...
     Tsim kss zvec zTrans zirfvec1 zirfvec2 zsimvec3 ;

%-------------------------------------------------------------------------%
% Generate two IRFs using known closed-form policy function k' = psi(k,z)
%-------------------------------------------------------------------------%
% kirfvec_ans1 = 1 x (Tirf+1) vector, IRF1 path for capital K using state
%                at t=0 of (k_0,z_0) = (kss,mu)
% kirfvec_ans2 = 1 x (Tirf+1) vector, IRF2 path for capital K using state
%                at t=0 of (k_0,z_0) = (1.2*kss,mu). Note: we have to force
%                k_1 = 1.1*kss
% eulvec_ans1  = 1 x Tirf vector of Euler errors from IRF1
% eulvec_ans2  = 1 x Tirf vector of Euler errors from IRF2
% tind         = scalar index of time period
% zt_1         = scalar, current period z value for IRF1
% zt_2         = scalar, current period z value for IRF2
% kt_1         = scalar, current period k value for IRF1
% kt_2         = scalar, current period k value for IRF2
% ktp1_1       = scalar, next period capital stock value for IRF1
% ktp1_2       = scalar, next period capital stock value for IRF2
% wt_1         = scalar, current period w value for IRF1
% wt_2         = scalar, current period w value for IRF2
% rt_1         = scalar, current period r value for IRF1
% rt_2         = scalar, current period r value for IRF2
% ct_1         = scalar, current period c value for IRF1
% ct_2         = scalar, current period c value for IRF2
% mut_1        = scalar, current period marginal utility for IRF1
% mut_2        = scalar, current period marginal utility for IRF2
% zminind_1    = integer, index of value in discretized support of z to
%                which zt_1 is closest
% zminind_2    = integer, index of value in discretized support of z to
%                which zt_2 is closest
% zprobs_1     = 1 x znodes vector, probability weights for ztp1_1 tomorrow
%                which are a linear interpolation of the transition matrix
%                row for which zt_1 is closest
% zprobs_2     = 1 x znodes vector, probability weights for ztp1_2 tomorrow
%                which are a linear interpolation of the transition matrix
%                row for which zt_2 is closest
% zuw_1        = scalar, weight on upper node of zvec for convex
%                combination of transition matrix rows for IRF1
% zuw_2        = scalar, weight on upper node of zvec for convex
%                combination of transition matrix rows for IRF2
% zlw_1        = scalar, weight on lower node of zvec for convex
%                combination of transition matrix rows for IRF1
% zlw_2        = scalar, weight on lower node of zvec for convex
%                combination of transition matrix rows for IRF2
% rtp1v_1      = 1 x znodes vector of potential values for rtp1 next period
%                for IRF1
% rtp1v_2      = 1 x znodes vector of potential values for rtp1 next period
%                for IRF2
% wtp1v_1      = 1 x znodes vector of potential values for wtp1 next period
%                for IRF1
% wtp1v_2      = 1 x znodes vector of potential values for wtp1 next period
%                for IRF2
% ktp2v_1      = 1 x znodes vector of potential values for ktp2 next period
%                for IRF1
% ktp2v_2      = 1 x znodes vector of potential values for ktp2 next period
%                for IRF2
% Emutp1_1     = scalar, discounted expected marginal utility next period
%                for IRF1
% Emutp1_2     = scalar, discounted expected marginal utility next period
%                for IRF2
%-------------------------------------------------------------------------%
kirfvec_ans1 = [kss,zeros(1,Tirf)] ;
kirfvec_ans2 = [1.1*kss,zeros(1,Tirf)] ;
%kirfvec_ans4 = [kss,zeros(1,Tirf)] ;
eulvec_ans1  = zeros(1,Tirf) ;
eulvec_ans2  = zeros(1,Tirf) ;
%eulvec_ans4  = zeros(1,Tirf) ;
for tind = 1:Tirf
    zt_1 = zirfvec1(tind) ;
    zt_2 = zirfvec2(tind) ;
    %zt_4 = zirfvec4(tind) ;
    kt_1 = kirfvec_ans1(tind) ;
    kt_2 = kirfvec_ans2(tind) ;
    %kt_4 = kirfvec_ans4(tind) ;
    ktp1_1 = alpha*beta*exp(zt_1)*(kt_1^alpha) ;
    ktp1_2 = alpha*beta*exp(zt_2)*(kt_2^alpha) ;
    %ktp1_4 = alpha*beta*exp(zt_4)*(kt_4^alpha) ;
    kirfvec_ans1(tind+1) = ktp1_1 ;
    kirfvec_ans2(tind+1) = ktp1_2 ;
    %kirfvec_ans4(tind+1) = ktp1_4 ;
    wt_1 = (1-alpha)*exp(zt_1)*(kt_1^alpha) ;
    wt_2 = (1-alpha)*exp(zt_2)*(kt_2^alpha) ;
    rt_1 = alpha*exp(zt_1)*(kt_1^(alpha-1)) ;
    rt_2 = alpha*exp(zt_2)*(kt_2^(alpha-1)) ;
    ct_1 = wt_1 + rt_1*kt_1 - ktp1_1 ;
    ct_2 = wt_2 + rt_2*kt_2 - ktp1_2 ;
    mut_1 = 1/ct_1 ;
    mut_2 = 1/ct_2 ;

    [~,zminind_1] = min((repmat(zt_1,[length(zvec),1]) - zvec).^2,[],1) ;
    if zt_1 <= zvec(1)
        zprobs_1 = zTrans(1,:) ;
    elseif zt_1 <= zvec(zminind_1)
        zuw_1    = (zt_1 - zvec(zminind_1-1))/...
                   (zvec(zminind_1) - zvec(zminind_1-1)) ;
        zlw_1    = 1 - zuw_1 ;
        zprobs_1 = zlw_1*zTrans(zminind_1-1,:) + ...
                   zuw_1*zTrans(zminind_1,:) ;
    elseif zt_1 > zvec(zminind_1) && zt_1 < zvec(length(zvec))
        zlw_1    = (zvec(zminind_1+1) - zt_1)/(zvec(zminind_1+1) - ...
                   zvec(zminind_1)) ;
        zuw_1    = 1 - zlw_1 ;
        zprobs_1 = zlw_1*zTrans(zminind_1,:) + ...
                   zuw_1*zTrans(zminind_1+1,:) ;
    elseif zt_1 >= zvec(length(zvec))
        zprobs_1 = zTrans(length(zvec),:) ;
    end
    rtp1v_1 = (alpha*ktp1_1^(alpha-1)).*exp(zvec') ;
    wtp1v_1 = ((1-alpha)*(ktp1_1^alpha)).*exp(zvec') ;
    ktp2v_1 = (alpha*beta*(ktp1_1^alpha)).*exp(zvec') ;
    Emutp1_1 = sum(zprobs_1.*rtp1v_1./...
               (wtp1v_1 + ktp1_1*rtp1v_1 - ktp2v_1)) ;
    eulvec_ans1(tind) = beta*Emutp1_1/mut_1 - 1 ;

    [~,zminind_2] = min((repmat(zt_2,[length(zvec),1]) - zvec).^2,[],1) ;
    if zt_2 <= zvec(1)
        zprobs_2 = zTrans(1,:) ;
    elseif zt_2 <= zvec(zminind_2)
        zuw_2    = (zt_2 - zvec(zminind_2-1))/...
                   (zvec(zminind_2) - zvec(zminind_2-1)) ;
        zlw_2    = 1 - zuw_2 ;
        zprobs_2 = zlw_2*zTrans(zminind_2-1,:) + ...
                   zuw_2*zTrans(zminind_2,:) ;
    elseif zt_2 > zvec(zminind_2) && zt_2 < zvec(length(zvec))
        zlw_2    = (zvec(zminind_2+1) - zt_2)/(zvec(zminind_2+1) - ...
                   zvec(zminind_2)) ;
        zuw_2    = 1 - zlw_2 ;
        zprobs_2 = zlw_2*zTrans(zminind_2,:) + ...
                   zuw_2*zTrans(zminind_2+1,:) ;
    elseif zt_2 >= zvec(length(zvec))
        zprobs_2 = zTrans(length(zvec),:) ;
    end
    rtp1v_2 = (alpha*ktp1_2^(alpha-1)).*exp(zvec') ;
    wtp1v_2 = ((1-alpha)*(ktp1_2^alpha)).*exp(zvec') ;
    ktp2v_2 = (alpha*beta*(ktp1_2^alpha)).*exp(zvec') ;
    Emutp1_2 = sum(zprobs_2.*rtp1v_2./...
               (wtp1v_2 + ktp1_2*rtp1v_2 - ktp2v_2)) ;
    eulvec_ans2(tind) = beta*Emutp1_2/mut_2 - 1 ;
end

%-------------------------------------------------------------------------%
% Generate simulated time path for K using known closed-form policy
% function k' = psi(k,z)
%-------------------------------------------------------------------------%
% ksimvec_ans3 = 1 x Tsim+1 vector, simulated path of capital K starting at
%                state (k_0,z_0) = (kss,mu)
% eulvec_ans3  = 1 x Tsim vector of Euler errors from longer simulation
% zt_3         = scalar, current period z value for simulation
% kt_3         = scalar, current period k value for simulation
% ktp1_3       = scalar, next period capital stock value for simulation
% wt_3         = scalar, current period w value for simulation
% rt_3         = scalar, current period r value for simulation
% ct_3         = scalar, current period c value for simulation
% mut_3        = scalar, current period marginal utility for simulation
% zminind_3    = integer, index of value in discretized support of z to
%                which zt_3 is closest
% zprobs_3     = 1 x znodes vector, probability weights for ztp1_3 tomorrow
%                which are a linear interpolation of the transition matrix
%                row for which zt_3 is closest
% zuw_3        = scalar, weight on upper node of zvec for convex
%                combination of transition matrix rows for simulation
% zlw_3        = scalar, weight on lower node of zvec for convex
%                combination of transition matrix rows for simulation
% rtp1v_3      = 1 x znodes vector of potential values for rtp1 next period
%                for simulation
% wtp1v_3      = 1 x znodes vector of potential values for wtp1 next period
%                for simulation
% ktp2v_3      = 1 x znodes vector of potential values for ktp2 next period
%                for simulation
% Emutp1_3     = scalar, discounted expected marginal utility next period
%                for simulation
%-------------------------------------------------------------------------%
ksimvec_ans3 = [kss,zeros(1,Tsim)] ;
eulvec_ans3  = zeros(1,Tsim) ;
for tind = 1:Tsim
    zt_3 = zsimvec3(tind) ;
    kt_3 = ksimvec_ans3(tind) ;
    ktp1_3 = alpha*beta*exp(zt_3)*(kt_3^alpha) ;
    ksimvec_ans3(tind+1) = ktp1_3 ;
    wt_3 = (1-alpha)*exp(zt_3)*(kt_3^alpha) ;
    rt_3 = alpha*exp(zt_3)*(kt_3^(alpha-1)) ;
    ct_3 = wt_3 + rt_3*kt_3 - ktp1_3 ;
    mut_3 = 1/ct_3 ;

    [~,zminind_3] = min((repmat(zt_3,[length(zvec),1]) - zvec).^2,[],1) ;
    if zt_3 <= zvec(1)
        zprobs_3 = zTrans(1,:) ;
    elseif zt_3 <= zvec(zminind_3)
        zuw_3    = (zt_3 - zvec(zminind_3-1))/...
                   (zvec(zminind_3) - zvec(zminind_3-1)) ;
        zlw_3    = 1 - zuw_3 ;
        zprobs_3 = zlw_3*zTrans(zminind_3-1,:) + ...
                   zuw_3*zTrans(zminind_3,:) ;
    elseif zt_3 > zvec(zminind_3) && zt_3 < zvec(length(zvec))
        zlw_3    = (zvec(zminind_3+1) - zt_3)/(zvec(zminind_3+1) - ...
                   zvec(zminind_3)) ;
        zuw_3    = 1 - zlw_3 ;
        zprobs_3 = zlw_3*zTrans(zminind_3,:) + ...
                   zuw_3*zTrans(zminind_3+1,:) ;
    elseif zt_3 >= zvec(length(zvec))
        zprobs_3 = zTrans(length(zvec),:) ;
    end
    rtp1v_3 = (alpha*ktp1_3^(alpha-1)).*exp(zvec') ;
    wtp1v_3 = ((1-alpha)*(ktp1_3^alpha)).*exp(zvec') ;
    ktp2v_3 = (alpha*beta*(ktp1_3^alpha)).*exp(zvec') ;
    Emutp1_3 = sum(zprobs_3.*rtp1v_3./...
               (wtp1v_3 + ktp1_3*rtp1v_3 - ktp2v_3)) ;
    eulvec_ans3(tind) = beta*Emutp1_3/mut_3 - 1 ;
end


%-------------------------------------------------------------------------%
% Calculate two Euler error distance measures for the two IRFs and the one
% simulation
%-------------------------------------------------------------------------%
% eulerr_rms_ans1 = scalar, root mean squared Euler error from IRF1
% eulerr_mab_ans1 = scalar, maximum absolute Euler error from IRF1
% eulerr_rms_ans2 = scalar, root mean squared Euler error from IRF2
% eulerr_mab_ans2 = scalar, maximum absolute Euler error from IRF1
% eulerr_rms_ans3 = scalar, root mean squared Euler error from simulation
% eulerr_mab_ans3 = scalar, maximum absolute Euler error from simulation
%-------------------------------------------------------------------------%
eulerr_rms_ans1 = sqrt(sum(eulvec_ans1.^2)/Tirf) ;
eulerr_mab_ans1 = max(abs(eulvec_ans1)) ;
eulerr_rms_ans2 = sqrt(sum(eulvec_ans2.^2)/Tirf) ;
eulerr_mab_ans2 = max(abs(eulvec_ans2)) ;
eulerr_rms_ans3 = sqrt(sum(eulvec_ans3.^2)/Tsim) ;
eulerr_mab_ans3 = max(abs(eulvec_ans3)) ;

display([eulerr_rms_ans1,eulerr_mab_ans1;...
    eulerr_rms_ans2,eulerr_mab_ans2;...
    eulerr_rms_ans3,eulerr_mab_ans3]) ;

%-------------------------------------------------------------------------%
% Plot IRFs and simulation
%-------------------------------------------------------------------------%
figure(1)
plot((0:1:Tirf),kirfvec_ans1,(0:1:Tirf),kirfvec_ans2) ;
xlabel('Period (t)','FontSize', 12) ;
ylabel('Aggregate Capital (K)','FontSize', 12) ;

figure(2)
plot((0:1:Tsim),ksimvec_ans3) ;
xlabel('Period (t)','FontSize', 12) ;
ylabel('Aggregate Capital (K)','FontSize', 12) ;

%-------------------------------------------------------------------------%
runtime = etime(clock,starttime) ; % end timer
save ClosedForm_ans.mat ;
