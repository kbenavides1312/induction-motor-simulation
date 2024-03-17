function [Vuo, Vvo, Vwo] = v3ph(Vm,fs,t)

ws = 2*pi*fs;
Vuo = Vm*sin(ws*t);
Vvo = Vm*sin(ws*t-2/3*pi);
Vwo = Vm*sin(ws*t+2/3*pi);

endfunction