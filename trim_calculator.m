%% SECTION 1 - ALTITUDE INPUTS %%

alt_feet = 6562; % Altitude in feet
ht = alt_feet * 0.3048; % Altitude in meters
m = 6300; % Aircraft mass in kg

gamma_e_deg = 0; %Flight path angle in degrees
gamma_e_rad = gamma_e_deg/57.3;
g = 9.81; % Gravitaional acceleration


%% SECTION 2 - AIR DENSITY INPUTS %%
%Trim is best computed at various velocities for ONE altitude

R = 287.05; % Gas constant
lr = -0.0065; % Lapse rate
Temp = 288.16 + lr*ht; %Temperature in K

rho = 1.225*(Temp/288.16)^-((g/(lr*R))+1);
sigma = rho/1.225;

%% SECTION 3 - VELOCITY VECTOR %%

v_instance = 0;
v_stop = 10;
increment_val = 1;

% Arrays for each velocity set
V_knots_i_array = []; % TAS in knots
V_i_array = []; % TAS in m/s
V_eas_i_array = []; % Equivalent airspeed in knots


while v_instance <=10

    % Velocities at that SPECCIFIC increment
    V_knots_i = 100 + 15*v_instance;
    V_i = V_knots_i * 0.515;
    V_eas_i = V_knots_i * sqrt(sigma);

    %Velocity arrays
    V_knots_i_array = [V_knots_i_array,V_knots_i];
    V_i_array = [V_i_array,V_i];
    V_eas_i_array = [V_eas_i_array, V_eas_i];

    %Velcoity increment
    v_instance = v_instance + increment_val;

end 

%DATA PRESENTATION SECTION BEGIN

contcat_mat_curr = [V_knots_i_array',V_i_array'];
headers = {'Vknots', 'Vi'};
data_matrix = [headers; num2cell(contcat_mat_curr)];

% DATA PRESENTATION SECTION END

%% SECTION 4 - AIRCRAFT GEOMETRY

%Wing Geometry
S = 25.08; %Wing Area  
b = 15.85; % Wing Span
c_w = 1.716; % Wing mean chord
sweep_angle_quater_chord = 0;

z_w = 0.45;
alpha_wr_deg = 1; %Rigging angle
alpha_wr_rad = alpha_wr_deg/57.3;

%Tailplane geometry
S_T = 7.79; % Tailplane area in m^2
b_T = 6.6; % Tailplane span in m
l_t = 6.184; % Aerodynamic Tail length

z_T = -1.435;
n_t_deg = 1.5; %Tail setting angle in deg
n_t_rad = n_t_deg/57.3;

z_tao = 0.312; %Thurst line below +ve body axis
k_deg = 0; %Thrust line angle in deg
k_rad = k_deg/57.3; %Thrust line angle rad





%% SECTION 5 - WING BODY AERODYNAMIC COEFFICENTS %%

a = 5.19; % Cl_aplha in per rad
Cl_max = 1.37;
Cmo = -0.0711; % Zero lift pitching moment
Cdo = 0.03; % Parasite drag
alpha_wo_deg = -2; %Zero lift AOA in degrees
alpha_wo_rad = alpha_wo_deg/57.3; %Zero lift AOA in radians
ho = -0.08; %Aerodynamic Center
h = 0.2902; %CHEESED IT


%% SECTION 6 - TAILPLANE AERODYNAMIC COEFFICIENTS %%

a1 = 3.2; % Tailpane Cl_alpha in per radian
a2 = 2.414; % Elevator Cl-tailset in per rad
epsilon_zero_deg = 2 % Zero lift downwash angle in deg
epsilon_zero_rad = epsilon_zero_deg/57.3; % Zero lift downwash angle in rad


%% SECTION 7 - WING AND TAILPALNE INPUTS
AR = b^2/S;% Aspect Ratio
s = b/2; % Wing semi/half span
l_T = l_t-(c_w)*(h-0.25);
V_T = (S_T*l_T)/(S*c_w);


%% SECTION 8 - DOWNWASH AT TAIL %%

x = l_t/b; % Tail position relative to wing
z = (z_w -z_T)/b;

%% SECTION 8.1 - DELTA EPSILON APLHA CALC SPACE %%
detla_e_alpha = delta_eps_alpha(a,AR,x,z) % Calculated using created utility function



%%
