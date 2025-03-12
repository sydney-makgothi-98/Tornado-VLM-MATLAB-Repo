function [delta_epsilon_alpha] = delta_eps_alpha(a, AR, x,z)
% a = 5.19;
% AR = 10.017;
K = a/(pi^2 * AR);
% z = 0.1189;
% x = 0.3920;

%Summation array initialization
fi_start = 5;
fi_end = 85;
step = 1;

fi_array = fi_start: step:  fi_end;
delta_alpha_array = [];

for index = 1:length(fi_array)

    %First Quotient
    quotient_1_numerator = 0.5*(cos(pi*fi_array(index)/180))^2;
    quotient_1_denonminator = sqrt(x^2 + (0.5*cos(fi_array(index)*pi/180))^2 +z^2);
    quotient_1 = quotient_1_numerator/quotient_1_denonminator;

    %Second Quotient
    quotient_2_numerator = x + sqrt(x^2 + (0.5*cos(fi_array(index)*pi/180))^2 + z^2);
    quotient_2_denominator = (0.5*cos(fi_array(index)*pi/180))^2 + z^2;
    z_x_ratio = x/(x^2 + z^2);
    quotient_2 = quotient_2_numerator/quotient_2_denominator;
    
    delta_alpha_curr = ((quotient_1) * (quotient_2 + z_x_ratio)) * pi/180;
    delta_alpha_array = [delta_alpha_array, delta_alpha_curr];

end 

delta_epsilon_alpha = K * sum(delta_alpha_array);

end
