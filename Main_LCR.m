% Program for testing the LCR
clear
clc
addpath('.\Funtions');

%% LCR parameters
FreqSweep = [1e3 16e3 33e3 50e3 66e3 83e3 100e3 116e3 133e3 150e3 166e3];
VoltageSweep = [];
CurrentSweep = [10e-3];
LCRmeasAVG = 3;

%% COMM
% Open LCR serial port
LCRcomm = AgilentInstr_SerialObj('LCR');
fopen(LCRcomm);

% Display LCR info
fprintf('LCR info: %s', query(LCRcomm, '*IDN?'));

% Configure LCR (Ls-Rs meas)
AgilentInstr_LCRconf(LCRcomm, LCRmeasAVG);

%% Get Measures
fprintf('\n--- Start Measures ---\n');
for freqCounter = 1:length(FreqSweep)
    % Set LCR frequency
    fprintf(LCRcomm,['FREQ ' num2str(FreqSweep(freqCounter))]);
    fprintf(LCRcomm,'AMPlitude:ALC ON');

    for SweepCounter = 1:(length(CurrentSweep) + length(VoltageSweep))
        if (SweepCounter < (length(CurrentSweep) + 1))
            % Set LCR Current
            fprintf(LCRcomm,['CURR:LEV ' num2str(CurrentSweep(SweepCounter))]);
            CCA_Ls_100_0.CurrentMeasSignal(SweepCounter,freqCounter) = CurrentSweep(SweepCounter);
            CCA_Ls_100_0.VoltMeasSignal(SweepCounter,freqCounter) = 0;
        else % if current sweep has finnished --> start voltage sweep
            %Set LCR voltage
            fprintf(LCRcomm,['VOLT:LEV ' num2str(VoltageSweep(SweepCounter - length(CurrentSweep)))]);
            CCA_Ls_100_0.CurrentMeasSignal(SweepCounter,freqCounter) = 0;
            CCA_Ls_100_0.VoltMeasSignal(SweepCounter,freqCounter) = VoltageSweep(SweepCounter - length(CurrentSweep));
        end
        fprintf(LCRcomm,'TRIGGER:IMM');

        % Read LsRs measurement
        MeasuredData = query(LCRcomm,'FETC?');

        % Process data. Raw data is an array of char values separated by a comma. 
        % The characters before the comma are the Ls values and the others are Rs.
        SeparateComma = regexp(MeasuredData,',');
        CCA_Ls_100_0.Ls(SweepCounter,freqCounter) = str2double(MeasuredData(1:SeparateComma(1)-1));
        CCA_Ls_100_0.Rs(SweepCounter,freqCounter) = str2double(MeasuredData(SeparateComma(1)+1:SeparateComma(2)-1));
        clear('MeasuredData','SeparateComma');

        % Read Iac
        CCA_Ls_100_0.iac(SweepCounter,freqCounter) = str2double(query(LCRcomm,'FETC:SMON:IAC?'));
        CCA_Ls_100_0.freq(SweepCounter,freqCounter) = FreqSweep(freqCounter);
    end
    clear('SweepCounter');
    pause(0.1);
end
clear('freqCounter');
fprintf('\n--- End ---\n');
save('CCA_Ls_100_0','CCA_Ls_100_0')
load('CCA_Ls_100_0','CCA_Ls_100_0')