function [pos_new,R] = rotate_pos(pos_org, rot)

Rx = [      1               0              0       ;
            0          cosd(rot(1))   sind(rot(1)) ;
            0         -sind(rot(1))   cosd(rot(1)) ];
       
Ry = [ cosd(rot(2))         0         sind(rot(2)) ;
            0               1              0       ;
      -sind(rot(2))         0         cosd(rot(2)) ];

Rz = [  cosd(rot(3))   sind(rot(3))        0       ;
       -sind(rot(3))   cosd(rot(3))        0       ;
            0               0              1       ];

pos_new = pos_org * (Rx * Ry * Rz)';
R = (Rx * Ry * Rz);

end