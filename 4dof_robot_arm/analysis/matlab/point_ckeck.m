%% Define sample points
% P1 = left-bottom;
% P2 = right-bottom;
% P3 = left-top;
% P4 = right-top;
% P5 = center;
% P6 = mid-left;
% P7 = mid-right;
%% Convert to xlsx
Config = strings(0,1);
Point  = strings(0,1);
Branch = strings(0,1);
X = [];
Y = [];
L1_col = [];
L2_col = [];
L3_col = [];
Alpha1 = [];
Alpha2 = [];
Alpha3 = [];

%% Points check
P = [
    80  -190
    240 -190
    80   -60
    240  -60
    160 -125
    240 -125
    80  -125
];

%% Feasible linkage sets
phi = deg2rad(0);   % keep the end-effector horizontal

LinkSets = [
    170 100 50;   % L
    150 120 50;   % M
    140 130 50;   % N
];

names = ["L", "M", "N"];
desc  = ["L: 170/100/50", "M: 150/120/50", "N: 140/130/50"];

for s = 1:size(LinkSets,1)
    L1 = LinkSets(s,1);
    L2 = LinkSets(s,2);
    L3 = LinkSets(s,3);

    fprintf('\n%s\n', desc(s));

    for i = 1:size(P,1)
        x = P(i,1);
        y = P(i,2);

        [theta_up, theta_dn] = IK3R_analytical(x, y, phi, L1, L2, L3);

        alpha_up = [
            theta_up(1);
            theta_up(1) + theta_up(2);
            theta_up(1) + theta_up(2) + theta_up(3)
        ];

        alpha_dn = [
            theta_dn(1);
            theta_dn(1) + theta_dn(2);
            theta_dn(1) + theta_dn(2) + theta_dn(3)
        ];

        alpha_up_deg = mod(rad2deg(alpha_up), 360);
        alpha_dn_deg = mod(rad2deg(alpha_dn), 360);

        fprintf('\nP%d  (x=%.0f, y=%.0f)\n', i, x, y);

        fprintf('up theta   : [%.1f, %.1f, %.1f] deg\n', ...
            rad2deg(theta_up));
        fprintf('up alpha   : [%.1f, %.1f, %.1f] deg\n', ...
            alpha_up_deg);

        fprintf('down theta : [%.1f, %.1f, %.1f] deg\n', ...
            rad2deg(theta_dn));
        fprintf('down alpha : [%.1f, %.1f, %.1f] deg\n', ...
            alpha_dn_deg);

        % save elbow-up result for SolidWorks
        Config(end+1,1) = names(s);
        Point(end+1,1)  = "P" + i;
        Branch(end+1,1) = "up";
        X(end+1,1) = x;
        Y(end+1,1) = y;
        L1_col(end+1,1) = L1;
        L2_col(end+1,1) = L2;
        L3_col(end+1,1) = L3;
        Alpha1(end+1,1) = alpha_up_deg(1);
        Alpha2(end+1,1) = alpha_up_deg(2);
        Alpha3(end+1,1) = alpha_up_deg(3);
    end
end

%% Export to Excel
T = table(Config, Point, Branch, X, Y, L1_col, L2_col, L3_col, ...
          Alpha1, Alpha2, Alpha3, ...
    'VariableNames', {'Config','Point','Branch','X','Y','L1','L2','L3', ...
                      'Alpha1','Alpha2','Alpha3'});

writetable(T, 'IK_SW_alpha_results.xlsx');

fprintf('\nExcel file exported: IK_SW_alpha_results.xlsx\n');