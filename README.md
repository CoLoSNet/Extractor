# Extractor
MATLAB code for CSI extract simulation

## What is Extractor Simulation?
Extractor Simulation is a tool that 
- provides the database from Remcom 3D ray-tracing.
- generates the channel frequency response (CFR) for different bandwidths and antenna arrays.
- estimates the location-bearing parameters, such as received signal strength (RSS), time of arrival (TOA), or angle of arrival (AOA), of the propagation paths from the CFR.

## Why use Extractor Simulation?
When finding the agent’s position with the estimated location-bearing parameters, the factors that affect the parameters’ estimation should be considered. For example, 
- when the LoS path is blocked, the parameters of the LoS cannot be estimated.
- when the bandwidth is small, it has a worse time-domain resolution. Thus, the dense multipath cannot be extracted accurately.
- the AOA estimation is affected by the number and arrangement of the antennas on the agent’s array.
Extractor Simulation can help us reveal the factors that affect the localization.

## How to use Extractor Simulation?
### Step 1. Download the “Extractor Simulation” and “Ray-tracing Database” folders.
- Extractor Simulation: As shown in Figure 1, this folder contains the main code “ExtractorSimulation.m” and a folder with sub-functions named “functions.”
  ![image](https://github.com/CoLoSNet/Extractor/assets/155145488/6d31a9a9-7472-44d9-9daf-a0e475204bea)
  Figure 1. Contents of the Extractor Simulation

- Ray-tracing Database: this folder contains ray-tracing databases of different environments. As shown in Figure 2, in one of the environment’s folders, there is a folder that includes the Remcom ray-tracing results named “Results_for_Mat,” some Matlab codes that have the positions of the agents and anchors, and a map.png which shows the map of the environment.
