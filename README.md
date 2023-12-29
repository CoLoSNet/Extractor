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

### Step 2: Some parameters need to be set before running the main code, as shown in Figure 3. The parameters are in “SetEnvironment.m”, “SetTransmission.m”, and “SetAntenna.m”. First, let us set the parameters in “SetEnvironment.m”.
- environment: choose an environment for simulation. The environment name should be the same as the folder name in the Ray-tracing Database. Currently, you can set it as
‣	'Indoor office'
‣	'Indoor shopping mall' 
- PLOT: set for plotting environment and result or not. You can set it as
‣	1: Yes.
‣	0: No.
- TX_index: choose the index of the anchor for simulation. You can set it as
‣	'all': Simulation with all anchors
‣	If you want to use a specific anchor for simulation, you can enter the index of the anchors after you see the map.png in the environment’s folder.
- RX_mode: choose the simulation mode for simulation. You can set it as
‣	'all': Simulation with all agents.
‣	'trajectory': Simulation with agents on randomly generated trajectories.
- traj_num: The number of the trajectory
‣	1: If you set RX_mode = 'all', you must set traj_num = 1.
‣	Otherwise, you can enter any number as the number of the trajectory.
- traj_len: The length (step number) of a trajectory
‣	1: If you set RX_mode = 'all', you must set traj_len = 1.
‣	Otherwise,  you can enter any number as the length of the trajectory.
