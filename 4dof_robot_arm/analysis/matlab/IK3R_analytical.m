function [theta_up, theta_dn] = IK3R_analytical(x, y, phi, L1, L2, L3)
%% IK3R_ANALYTICAL  Analytical IK for planar 3R arm
% Inputs:
% x, y: desired end-effector position
% phi: desired end-effector orientation
% L1, L2, L3: desired linkage lengths
%
% Outputs
% theta_up : [theta1; theta2; theta3] for elbow-up solution
% theta_dn : [theta1; theta2; theta3] for elbow-down solution
    %% 1. Wrist center
    xw = x - L3*cos(phi);
    yw = y - L3*sin(phi);
    r2  = xw^2 + yw^2;

    %% 2. Joint 2 angle: based on 2R IK
    c2 = (r2 - L1^2 - L2^2) / (2*L1*L2);
    % Reachability check
    if c2 > 1.000001 || c2 < -1.000001
        warning('Target point is outside reachable workspace')

        theta_up = [NaN, NaN, NaN];
        theta_dn = [NaN, NaN, NaN];
        return
    end
    
    if c2 > 1
        c2 = 1;
    elseif c2 < -1
        c2 = -1;
    end   % clamp for numerical safety

    s2_pos =  sqrt(1 - c2^2);   % elbow-down
    s2_neg = -sqrt(1 - c2^2);   % elbow-up

    %% 3. Elbow-down solution
    theta2_dn = atan2(s2_pos, c2);
    theta1_dn = atan2(yw, xw) - atan2(L2*s2_pos, L1 + L2*c2);
    theta3_dn = phi - theta1_dn - theta2_dn;

    %% 4. Elbow-up solution
    theta2_up = atan2(s2_neg, c2);
    theta1_up = atan2(yw, xw) - atan2(L2*s2_neg, L1 + L2*c2);
    theta3_up = phi - theta1_up - theta2_up;

    %% 5. Output as joint vectors
    theta_up = [theta1_up;
                theta2_up;
                theta3_up];

    theta_dn = [theta1_dn;
                theta2_dn;
                theta3_dn];
end