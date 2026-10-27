clc;
clear;
close all;

disp('==============================================');
disp('  WEATHER-BASED CROP IRRIGATION PLANNING');
disp('==============================================');

% Get weather details from user
temperature = input('Enter temperature (Celsius): ');
humidity = input('Enter humidity (0 to 100 %): ');
rainfall = input('Enter expected rainfall (mm): ');

% Validate inputs
if ~isfinite(temperature) || temperature < -10 || temperature > 60
    error('Enter a valid temperature between -10 and 60 C.');
end

if ~isfinite(humidity) || humidity < 0 || humidity > 100
    error('Humidity must be between 0 and 100.');
end

if ~isfinite(rainfall) || rainfall < 0
    error('Rainfall cannot be negative.');
end

% Crop selection
disp(' ');
disp('Select your crop:');
disp('1. Paddy');
disp('2. Maize');
disp('3. Tomato');
disp('4. Wheat');

cropChoice = input('Enter crop number (1-4): ');

switch cropChoice
    case 1
        crop = 'Paddy';
        cropTemp = 30;
    case 2
        crop = 'Maize';
        cropTemp = 32;
    case 3
        crop = 'Tomato';
        cropTemp = 30;
    case 4
        crop = 'Wheat';
        cropTemp = 25;
    otherwise
        error('Invalid crop choice. Select a number from 1 to 4.');
end

% Irrigation recommendation
if rainfall >= 10
    recommendation = 'Delay irrigation due to expected rainfall.';
    status = 'Rainfall Alert';

elseif rainfall >= 5
    recommendation = 'Check rainfall and soil moisture before irrigation.';
    status = 'Monitor';

elseif temperature >= cropTemp && humidity < 50
    recommendation = 'Irrigation may be needed. Check soil moisture.';
    status = 'Possible Water Need';

else
    recommendation = 'Monitor crop and soil moisture regularly.';
    status = 'Normal Monitoring';
end

% Display report
disp(' ');
disp('========== IRRIGATION REPORT ==========');
fprintf('Selected Crop     : %s\n', crop);
fprintf('Temperature       : %.1f Celsius\n', temperature);
fprintf('Humidity          : %.1f percent\n', humidity);
fprintf('Expected Rainfall : %.1f mm\n', rainfall);
fprintf('Crop Threshold    : %.1f Celsius\n', cropTemp);
fprintf('Status            : %s\n', status);
fprintf('Recommendation    : %s\n', recommendation);
disp('=======================================');

% Display separate graphs to avoid overlapping labels
figure('Name','AgroSense Weather Report');

subplot(1,3,1);
bar(temperature);
title('Temperature');
ylabel('Celsius');
set(gca,'XTick',[]);
grid on;

subplot(1,3,2);
bar(humidity);
title('Humidity');
ylabel('Percentage');
ylim([0 100]);
set(gca,'XTick',[]);
grid on;

subplot(1,3,3);
bar(rainfall);
title('Expected Rainfall');
ylabel('Rainfall (mm)');
set(gca,'XTick',[]);
grid on;

sgtitle('Weather-Based Crop Irrigation Planning');
