function serialObject = AgilentInstr_SerialObj(Type)
% AgilentLCR_SerialObj Returns the serial object for Agilent LCR measurements

% Find LCR Hw info.
LCR_info = visadevlist;

% if no Agilent devices connected returns error
if (isempty(LCR_info) == 0)
    
    if (strcmp(('REG'), Type))
         serialObject = eval(LCR_info.ObjectConstructorName{2});
         %serialObject = visadev("USB0::2391::8199::MY59003566::0::INSTR");

    elseif (strcmp(('LCR'), Type))
         %serialObject = eval(LCR_info.ObjectConstructorName{1});
         serialObject = visadev("USB0::2391::2313::MY46312070::0::INSTR"); % LCR USB
         
    else
        error('Instr type no valido')
    end
else
    error('Error de conexión - No se ha encontrado ningún instrumento Agilent')
end

end