function AgilentInstr_LCRconf(serialObject, AvgMeasures)
% AgilentLCR_Conf Configure LCR for Ls-Rs measurements
% AvgMeasures: Amount of samples for each valid measure

% Error handling
if nargin < 2
    % if no arguments passed then gives error message
    error('Insufficient parameters')
elseif ~isvalid(serialObject)
    % the serial object must be valid
    error('serialObject must be a valid serial object.')
elseif ((AvgMeasures > 256) || (AvgMeasures < 1))
    error('Avg Measures must be between 1 and 256')
end

fprintf(serialObject,'*RST');
fprintf(serialObject,'*CLS');
fprintf(serialObject,'CORR:LOAD:STAT OFF'); %Turns off LOAD correction
fprintf(serialObject,'CORR:OPEN:STAT OFF'); %Turns off OPEN correction
fprintf(serialObject,'CORR:SHORT:STAT OFF'); %Turns off SHORT correction
fprintf(serialObject,'SYST:BEEP:STAT ON'); %Enables a beep sound
fprintf(serialObject,'AMPlitude:ALC ON'); %Turns on the Automatic level control(ALC)
fprintf(serialObject,'DISP:PAGE MEAS'); %Sets displayed page to <measurement>
fprintf(serialObject,'TRIG:SOUR BUS'); %selects the trigger mode BUS(GPIB/USB/LAN trigger)
fprintf(serialObject,'DISP:LINE "COMUNICACION CORRECTA CON PC"');
fprintf(serialObject,'DISP:PAGE CSET'); %Sets displayed page to <correction>
fprintf(serialObject,'CORR:LENG 1M'); %selects the cable lenght correction setting (1m)
fprintf(serialObject,'DISP:PAGE MEAS');
fprintf(serialObject,'FUNC:IMP LsRs'); %selects the mesurement function (Ls-Rs)
fprintf(serialObject,'DISP:LINE "MEDIDA SELECCIONADA"');
fprintf(serialObject,'APER MED, %d', AvgMeasures); %Measurement time mode MEDIUM, avg measures 5
fprintf(serialObject,'DISP:LINE "INTEGRACION SELECCIONADA"');
fprintf(serialObject,'SYST:BEEP:STATE OFF');%Disables a beep sound
fprintf(serialObject,':FUNC:IMP:RANG:AUTO ON');
    
end