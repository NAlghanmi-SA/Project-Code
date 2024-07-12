
% Define parameters for the forecasting model
w = rand(1, timePeriod); % Random weights for price model
theta = rand(1, timePeriod); % Random weights for additional factors
d_m = randi([10 50], 1, timePeriod); % Random demand model
m_pv = randi([5 30], 1, timePeriod); % Random PV generation model
g_m = randi([1 10], 1, timePeriod); % Random grid generation model
g_n = randi([15 40], 1, timePeriod); % Random grid normalization factor

% Calculate market price estimation
Y = zeros(1, timePeriod);
R = zeros(1, timePeriod);
T = zeros(1, timePeriod);

for t = 1:timePeriod
    R(t) = w(t) * (PD(t))^2 + theta(t) * d_m(t);
    b = (d_m(t) + m_pv(t) + g_m(t)) / g_n(t);
    T(t) = R(t) + b;
    Y(t) = R(t) + T(t);
end

% Plot market price estimation
figure;
plot(1:timePeriod, Y, '-c');
xlabel('Time (hours)');
ylabel('Market Price');
title('Forecasted Market Price');

