# SyncHyObserverSpikingNeurons

This repository contains the Matlab files to simulate an observer for a spiking neuron along the lines of Section 7.2 in 

P. Bernard, R. Sanfelice, *Observer Design for Hybrid Dynamical Systems with Approximately Known Jump Times*, Accepted in Automatica

The neuron model we use is the one presented in 

E. M. Izhikevich, *Simple model of spiking neurons*, IEEE Transactions on Neural Networks, 14(6):1569-1572, 2003

It is a hybrid system with two-dimensional state, an input I and 4 parameters a,b,c,d.
The state models the membrane potential and the recovery variable,
the input represents the (constant) synaptic current or injected DC
current and the model parameters characterize the neuron type and its firing pattern. 

The simulations run on Matlab R2020b and use the Hybrid Systems Simulation Toolbox available at https://hybrid.soe.ucsc.edu/software, as well as Simulink. Optionally, the computation of the observer gain requires the YALMIP and SDPT3 toolboxes.
 
Instructions : 
1) Make sure the Hybrid Systems Simulation Toolbox is on your Matlab path.
2) Choose a simulation folder among
	- HG_vwab : assumes the output is available at all times and implements a high-gain observer during flow to estimate the state and the parameters a,b.
	- Discrete_vwd : assumes the output is available at all times and implements a jump-based hybrid observer to estimate the state and the parameter c.
3) Run main.m.
