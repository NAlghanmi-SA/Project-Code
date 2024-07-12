% Define the period and initial conditions
timePeriod = 24; % 24 hours
energyDemand = randi([10 50], 1, timePeriod); % Random energy demand in kWh
energySupply = randi([20 70], 1, time-period); % Random energy supply in kWh

% Initialize variables for energy traded, stored, and balance
energyTraded = zeros(1, timePeriod);
energyStored = zeros(1, timePeriod);
energyBalance = zeros(1, timePeriod);

% Energy Pool Unit parameters
initialStorage = 100; % Initial energy storage in kWh
maxStorageCapacity = 200; % Max energy storage capacity in kWh

% Simulation loop for P2P trading
for t = 1:timePeriod
    energyBalance(t) = energySupply(t) - energyDemand(t);
    if energyBalance(t) > 0
        % Store excess energy if storage capacity is not exceeded
        if sum(energyStored) + energyBalance(t) <= maxStorageCapacity
            energyStored(t) = energyBalance(t);
        else
            energyStored(t) = maxStorageCapacity - sum(energyStored);
        end
    else
        % Trade energy to meet demand
        energyTraded(t) = min(initialStorage + sum(energyStored), -energyBalance(t));
        energyStored(t) = energyStored(t) - energyTraded(t);
    end
end

% Plot results
figure;
subplot(3,1,1);
plot(1:timePeriod, energySupply, '-g', 1:timePeriod, energyDemand, '-r');
xlabel('Time (hours)');
ylabel('Energy (kWh)');
title('Energy Supply and Demand');
legend('Supply', 'Demand');

subplot(3,1,2);
plot(1:timePeriod, energyTraded, '-b');
xlabel('Time (hours)');
ylabel('Energy (kWh)');
title('Energy Traded');

subplot(3,1,3);
plot(1:timePeriod, energyStored, '-m');
xlabel('Time (hours)');
ylabel('Energy (kWh)');
title('Energy Stored');

