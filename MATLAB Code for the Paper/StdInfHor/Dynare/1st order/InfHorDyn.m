%
% Status : main Dynare file 
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

tic;
global M_ oo_ options_ ys0_ ex0_ estimation_info
options_ = [];
M_.fname = 'InfHorDyn';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('InfHorDyn.log');
M_.exo_names = 'eps';
M_.exo_names_tex = 'eps';
M_.exo_names_long = 'eps';
M_.endo_names = 'w';
M_.endo_names_tex = 'w';
M_.endo_names_long = 'w';
M_.endo_names = char(M_.endo_names, 'Y');
M_.endo_names_tex = char(M_.endo_names_tex, 'Y');
M_.endo_names_long = char(M_.endo_names_long, 'Y');
M_.endo_names = char(M_.endo_names, 'K');
M_.endo_names_tex = char(M_.endo_names_tex, 'K');
M_.endo_names_long = char(M_.endo_names_long, 'K');
M_.endo_names = char(M_.endo_names, 'z');
M_.endo_names_tex = char(M_.endo_names_tex, 'z');
M_.endo_names_long = char(M_.endo_names_long, 'z');
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names_long = char(M_.endo_names_long, 'c');
M_.endo_names = char(M_.endo_names, 'r');
M_.endo_names_tex = char(M_.endo_names_tex, 'r');
M_.endo_names_long = char(M_.endo_names_long, 'r');
M_.param_names = 'calpha';
M_.param_names_tex = 'calpha';
M_.param_names_long = 'calpha';
M_.param_names = char(M_.param_names, 'cbeta');
M_.param_names_tex = char(M_.param_names_tex, 'cbeta');
M_.param_names_long = char(M_.param_names_long, 'cbeta');
M_.param_names = char(M_.param_names, 'cdelta');
M_.param_names_tex = char(M_.param_names_tex, 'cdelta');
M_.param_names_long = char(M_.param_names_long, 'cdelta');
M_.param_names = char(M_.param_names, 'cgamma');
M_.param_names_tex = char(M_.param_names_tex, 'cgamma');
M_.param_names_long = char(M_.param_names_long, 'cgamma');
M_.param_names = char(M_.param_names, 'lbar');
M_.param_names_tex = char(M_.param_names_tex, 'lbar');
M_.param_names_long = char(M_.param_names_long, 'lbar');
M_.param_names = char(M_.param_names, 'cmu');
M_.param_names_tex = char(M_.param_names_tex, 'cmu');
M_.param_names_long = char(M_.param_names_long, 'cmu');
M_.param_names = char(M_.param_names, 'crho');
M_.param_names_tex = char(M_.param_names_tex, 'crho');
M_.param_names_long = char(M_.param_names_long, 'crho');
M_.param_names = char(M_.param_names, 'csigma');
M_.param_names_tex = char(M_.param_names_tex, 'csigma');
M_.param_names_long = char(M_.param_names_long, 'csigma');
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 6;
M_.param_nbr = 8;
M_.orig_endo_nbr = 6;
M_.aux_vars = [];
M_.predetermined_variables = [ 3 ];
M_.Sigma_e = zeros(1, 1);
M_.Correlation_matrix = eye(1, 1);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('InfHorDyn_static');
erase_compiled_function('InfHorDyn_dynamic');
M_.lead_lag_incidence = [
 0 3 0;
 0 4 0;
 1 5 0;
 2 6 0;
 0 7 9;
 0 8 10;]';
M_.nstatic = 2;
M_.nfwrd   = 2;
M_.npred   = 2;
M_.nboth   = 0;
M_.nsfwrd   = 2;
M_.nspred   = 2;
M_.ndynamic   = 4;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(6, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(8, 1);
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 20;
M_.NNZDerivatives(2) = -1;
M_.NNZDerivatives(3) = -1;
M_.params( 1 ) = .35;
calpha = M_.params( 1 );
M_.params( 2 ) = .96;
cbeta = M_.params( 2 );
M_.params( 3 ) = .05;
cdelta = M_.params( 3 );
M_.params( 4 ) = 2;
cgamma = M_.params( 4 );
M_.params( 5 ) = 1;
lbar = M_.params( 5 );
M_.params( 6 ) = 0;
cmu = M_.params( 6 );
M_.params( 7 ) = 0.8145062499999999;
crho = M_.params( 7 );
M_.params( 8 ) = 0.0130058759370760;
csigma = M_.params( 8 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 5 ) = .75;
oo_.steady_state( 6 ) = .12;
oo_.steady_state( 1 ) = 1.32;
oo_.steady_state( 3 ) = 8.04;
oo_.steady_state( 4 ) = 0;
oo_.steady_state( 2 ) = 2;
if M_.exo_nbr > 0;
	oo_.exo_simul = [ones(M_.maximum_lag,1)*oo_.exo_steady_state'];
end;
if M_.exo_det_nbr > 0;
	oo_.exo_det_simul = [ones(M_.maximum_lag,1)*oo_.exo_det_steady_state'];
end;
steady;
%
% SHOCKS instructions
%
make_ex_;
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (M_.params(8))^2;
M_.sigma_e_is_diagonal = 1;
options_.irf = 150;
options_.nodisplay = 1;
options_.order = 1;
var_list_=[];
info = stoch_simul(var_list_);
save('InfHorDyn_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('InfHorDyn_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('InfHorDyn_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('InfHorDyn_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('InfHorDyn_results.mat', 'estimation_info', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
