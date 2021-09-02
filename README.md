# SyncHyObserverSpikingNeurons

This repository contains the Matlab files to simulate an observer for a spiking neuron along the lines of Section 7.2 in 

*Observer Design for Hybrid Dynamical Systems with Approximately Known Jump Times*, P. Bernard, R. Sanfelice, Accepted in Automatica

The neuron model we used is the one presented in 

E. M. Izhikevich, *Simple model of spiking neurons*, IEEE Transactions on Neural Networks, 14(6):1569-1572, 2003

It is a hybrid system with state $(x_1,x_2) \in \reals^2$ 
and data given by
\begin{align}
\label{eq_neuron}
& f(x)=\big(0.04x_1^2+5x_1+140-x_2+I_{\rm ext} \, , \, a(bx_1-x_2)\big)
\nonumber
\\
&
g(x)=(c,x_2+d)  \qquad , \qquad h_c(x) = h_d(x) = x_1
\nonumber
\\
&C= \{(x_1,x_2)\in \reals^2 \: : \: x_1 \leq v_m \}
\\
& D = \{(x_1,x_2)\in \reals^2 \: : \: x_1 = v_m \}
\nonumber 
\end{align}
where $x_1$ is the membrane potential, $x_2$ is the recovery variable,
and $I_{\rm ext}$ represents the (constant) synaptic current or injected DC
current. The value of the input $I_{\rm ext}$ and the model parameters $a$, $b$, $c$, and $d$, as well as the threshold voltage $v_m$ characterize the neuron type and its firing pattern. 

The simulation run on Matlab R2020b and use the Hybrid Systems Simulation Toolbox available at https://hybrid.soe.ucsc.edu/software, as well as Simulink.
 
Instructions : 
1) Make sure the Hybrid Systems Simulation Toolbox is on your Matlab path.
2) Choose a simulation folder among
	- HG_vwab : assumes the output is available during flow and implements a high-gain observer during flow to estimate $(x_1,x_2,a,b)$
	-  
3) Run main.m.
