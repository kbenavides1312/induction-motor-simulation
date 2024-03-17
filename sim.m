#-------------------------------------------------------
#  Simulation of Induction Motor
#-------------------------------------------------------

# ----Time Sampling----------
tstep=100e-6; #100us step
tfinal=5; # 5s
t = (0:tstep:tfinal);



# ----Input Variables----------
TL = 10*((t>3)&(t<4)); #10Nm pulse between 3s and 4s.
Vm = 325; # 325V
fs = 50; # 50Hz

[Vuo, Vvo, Vwo] = v3ph(Vm,fs,t); # pure sine signals

# ---- State variables---------
x=zeros(5,length(t));
y=[Vuo; Vvo; Vwo; TL];

# ----Simulation----------
for i=1:(length(t)-1)

xdot = model(x(:,i),y(:,i));
x(:,i+1) = x(:,i) + xdot * tstep;

if mod(t(i), 0.1)==0
printf ("Simulated %ds of %ds.\n",t(i), tfinal);
endif

endfor

p=1;
M = 0.42;
Td = 2/3 * p*M * (x(3,:).*x(2,:) - x(4,:).*x(1,:));

plot(t, [x(1,:);x(2,:); x(5,:); y(4,:); Td]')
