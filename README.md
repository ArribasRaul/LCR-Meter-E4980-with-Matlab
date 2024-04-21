# LCR Meter Automation with MATLAB
This project provides automation capabilities for conducting measurements using the Agilent LCR Meter E4980. It leverages MATLAB for instrument control and data processing, allowing users to configure measurement parameters, send commands to the device, and process acquired data.

## Requirements
To run this project, you need the following:

- MATLAB installed on your computer
- Instrument Control Toolbox installed in MATLAB
- Instrument Control Toolbox Support Package for Keysight IO Libraries and VISA Interface installed in MATLAB
- Agilent E4980A Precision LCR Meter IVI and MATLAB Instrument Drivers installed
- (Optional) Keysight Connection Expert for managing instrument connections

## Getting Started
1. **Installation**:
   - Install MATLAB on your computer if not already installed.
   - Install required MATLAB add-ons: Instrument Control Toolbox and Instrument Control Toolbox Support Package for Keysight IO Libraries and VISA Interface.
   - Download and install the Agilent E4980A Precision LCR Meter IVI and MATLAB Instrument Drivers from the Keysight website.
   - (Optional) Install Keysight Connection Expert for managing instrument connections.

2. **Setup**:
   - Connect the Agilent LCR Meter E4980 to your computer via USB, LAN, or GPIB.
   - Ensure the instrument drivers are correctly configured and recognized by MATLAB.

3. **Usage**:
   - Clone this repository to your local machine.
   - Open and run the `Main_LCR.m` script in MATLAB to start the measurement process.
   - Customize measurement parameters and configurations as needed within the script.
   - Review and process the measured data using MATLAB's data analysis capabilities.

## Directory Structure
- `Main_LCR.m`: Main script to control the LCR Meter and perform measurements.
- `AgilentInstr_LCRconf.m`: Function to configure the LCR Meter settings for Ls-Rs measurements.
- `AgilentInstr_SerialObj.m`: Function to create a serial object for communication with Agilent instruments.
- `Functions/`: Directory containing auxiliary functions used by the main script.

## Contributing
Contributions to this project are welcome. If you have any suggestions, improvements, or bug fixes, please feel free to submit a pull request.
