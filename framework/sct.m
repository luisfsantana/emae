function [arc,ct,ra]=sct(a,b,c,t);

ax=real(a);
ay=imag(a);
%
bx=real(b);
by=imag(b);
%
cx=real(c);
cy=imag(c);
%
d =2*(ax*(by-cy)+bx*(cy-ay)+cx*(ay-by));
%
ux =((ax^2+ay^2)*(by-cy)+(bx^2+by^2)*(cy-ay)+(cx^2+cy^2)*(ay-by))/d;
uy =((ax^2+ay^2)*(cx-bx)+(bx^2+by^2)*(ax-cx)+(cx^2+cy^2)*(bx-ax))/d;
%
ct =ux+i*uy;
vtr=ax+i*ay-ct;
ra =abs(vtr);
tht=angle(vtr)-angle(cx+i*cy-ct);
arc=ct+vtr*exp(tht*t/i);
