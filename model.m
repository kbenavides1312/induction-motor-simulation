function xdot=model(x, y)
#INDUCTION MOTOR MODEL
#
#SYNTAX:
#   xdot=model(x,y)
#
# returns the states space model for an induction motor
# with states x=[isa, isb, ira, irb,wm]' and inputs as y=[Vuo, Vvo, Vwo, Tl]'
#-------------------------------------------------------
#  States Mapping
#-------------------------------------------------------
isa=x(1);
isb=x(2);
ira=x(3);
irb=x(4);
wm=x(5);
#-------------------------------------------------------
#  Inputs Mapping
#-------------------------------------------------------
Vuo=y(1);
Vvo=y(2);
Vwo=y(3);
TL=y(4);
#-------------------------------------------------------
#  Constants
#-------------------------------------------------------
Rs = 3.47;
Rr = 1.27;
M = 0.42;
Lss = 0.435;
Lrr = 0.435;
p = 1;
Js = 5e-2;
Bf = 1e-2;

Ls1 = (Lss/M)-(M/Lrr);
Lr1 = (M/Lss)-(Lrr/M);
wme=p*wm;

#-------------------------------------------------------
#  Pole to neutral reference
#-------------------------------------------------------
Vun = (2*Vuo-Vvo-Vwo)/3;
Vvn = (-Vuo+2*Vvo-Vwo)/3;
Vwn = (-Vuo-Vvo+2*Vwo)/3;
#-------------------------------------------------------
#  uvw2ab
#-------------------------------------------------------
Vsa = Vun - (Vvn+Vwn)/2;
Vsb = sqrt(3)*(Vvn-Vwn)/2;
#-------------------------------------------------------
#  Dynamic equations
#-------------------------------------------------------
isadot = 1/Ls1 * (-isa * Rs/M      + isb * M*wme/Lrr + ira * Rr/Lrr    + irb * wme       + Vsa/M);
isbdot = 1/Ls1 * (-isa * M*wme/Lrr - isb * Rs/M      - ira * wme       + irb * Rr/Lrr    + Vsb/M);
iradot = 1/Lr1 * (-isa * Rs/Lss    + isb * wme       + ira * Rr/M      + irb * wme*Lrr/M + Vsa/Lss);
irbdot = 1/Lr1 * (-isa * wme       - isb * Rs/Lss    - ira * wme*Lrr/M + irb * Rr/M      + Vsb/Lss);

Td = 2/3 * p*M * (ira*isb - irb*isa);
wmdot = (Td-TL-Bf*wm)/Js;

xdot = [isadot, isbdot, iradot, irbdot, wmdot]';
endfunction
