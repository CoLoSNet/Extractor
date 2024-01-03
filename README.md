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

### Step 1: Download the codes and folders, as shown in Figure 1
<p align="center">
  <img src="https://github.com/CoLoSNet/Extractor/assets/155145488/6e67b2d4-53bd-4ca8-ae1d-e1549b06dd75"/>
</p>
<p align="center">
  Figure 1. Contents of the Extractor Simulation
</p>

### Step 2: Download the database. 
The “Ray-tracing Database” is a folder that contains ray-tracing databases of different environments. As shown in Figure 2, in one of the environment’s folders, there is a folder that includes the Remcom ray-tracing results named “Results_for_Mat,” some Matlab codes that have the positions of the agents and anchors, and a map.png which shows the map of the environment. The databases in the “Results_for_Mat” are needed to be download from the following link:
-	Indoor NSYSU: 
-	Indoor office: 
-	Indoor shopping mall:
<p align="center">
  <img src="https://github.com/CoLoSNet/Extractor/assets/155145488/07ca2ae9-9c81-4512-aef1-55d2b82bace1"/>
</p>
<p align="center">
  Figure 2. Contents of one environment’s folder
</p>

### Step 3: Open the main code with MATLAB.
Some parameters need to be set before running the main code, as shown in Figure 3. The parameters are in “SetEnvironment.m”, “SetTransmission.m”, and “SetAntenna.m”. 
<p align="center">
  <img src="https://github.com/CoLoSNet/Extractor/assets/155145488/98528702-4cd7-475a-9fae-83ef95ab6cd3"/>
</p>
<p align="center">
  Figure 3. The main code
</p>

### Step 4: Set the parameters in “SetEnvironment.m”.
- environment: choose an environment for simulation. The environment name should be the same as the folder name in the Ray-tracing Database. Currently, you can set it as
  * <color #4BACC6> <_'Indoor office'_> </color>
  * 'Indoor shopping mall'
  * 'Indoor NSYSU'
- PLOT: set for plotting environment and result or not. You can set it as
  * 1: Yes.
  * 0: No.
- TX_index: choose the index of the anchor for simulation. You can set it as
  * 'all': Simulation with all anchors
  * If you want to use a specific anchor for simulation, you can enter the index of the anchors after you see the map.png in the environment’s folder.
- RX_mode: choose the simulation mode for simulation. You can set it as
  * 'all': Simulation with all agents.
  * 'trajectory': Simulation with agents on randomly generated trajectories.
- traj_num: The number of the trajectory
  * 1: If you set RX_mode = 'all', you must set traj_num = 1.
  * Otherwise, you can enter any number as the number of the trajectory.
- traj_len: The length (step number) of a trajectory
  * 1: If you set RX_mode = 'all', you must set traj_len = 1.
  * Otherwise,  you can enter any number as the length of the trajectory.

### Step 5: Set the parameters in “SetTransmission.m”.
- noise_level: The noise variance.
- fft_num: The FFT point.
- sub_num: The number of the subcarrier.
- f_subcar: The subcarrier spacing (Hz).

### Step 6: Set the parameters in “SetAntenna.m”.
- ant_pos: The antennas’ position relative to the first antenna. Each row contains the x, y, and z coordinates of each antenna, and the unit is half-wavelength.
  * For example, if you want to estimate the AoA of the signals with the array shown in Figure 4, you can set ant_pos = [[0 0 0];[1 0 0];[1 1 0];[0 1 0]];
- ele_table: The estimation range of the elevation, which is 𝜙 in Figure 4.
- azi_table: The estimation range of the azimuth, which is θ in Figure 4.
<p align="center">
  <img src="https://github.com/CoLoSNet/Extractor/assets/155145488/d0da6a35-fa5b-4090-b3c3-281b5c4619d1"/>
</p>
<p align="center">
  Figure 4. An x-y planar array with four antennas
</p>

### Step 7: Run the main code. 
You will see the estimation results of the parameters between an anchor and an agent, as shown in Figure 5. In particular, the elevation ranges from -90˚ to 90˚, while -90˚ to -1˚ marked as 270˚ to 359˚ on the plot.
<p align="center">
  <img src="https://github.com/CoLoSNet/Extractor/assets/155145488/36d6f2b8-9d49-4632-9c75-ee842da4faf6"/>
</p>
<p align="center">
  Figure 5. The estimation results of delay, elevation, and azimuth
</p>


