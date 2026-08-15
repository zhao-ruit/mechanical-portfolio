%% Define linkage lengths
L1 = 170;
L2 = 100;
L3 = 50;

M1 = 150;
M2 = 120;
M3 = 50;

N1 = 140;
N2 = 130;
N3 = 50;

O1 = 150;
O2 = 130;
O3 = 60;
%% Define end-effector's density
theta1 = linspace(deg2rad(-45),deg2rad(90),100);
theta2 = linspace(deg2rad(-90), deg2rad(90), 100);
theta3 = deg2rad(-theta1-theta2);   % fixed tool angle

X1 = [];
Y1 = [];

X2 = [];
Y2 = [];

X3 = [];
Y3 = [];

X4 = [];
Y4 = [];

for t1 = theta1
    for t2 = theta2
        t3 = -(t1 + t2);   % keep end-effector horizontal
        % first linkage set
        X1(end+1) = L1 * cos(t1) + L2 * cos(t1 + t2) + L3 * cos(t1 + t2 + t3);
        Y1(end+1) = L1 * sin(t1) + L2 * sin(t1 + t2) + L3 * sin(t1 + t2 + t3);

        % second linkage set
        % second linkage set
        X2(end+1) = M1 * cos(t1) + M2 * cos(t1 + t2) + M3 * cos(t1 + t2 + t3);
        Y2(end+1) = M1 * sin(t1) + M2 * sin(t1 + t2) + M3 * sin(t1 + t2 + t3);

        % third linkage set
        X3(end+1) = N1 * cos(t1) + N2 * cos(t1 + t2) + N3 * cos(t1 + t2 + t3);
        Y3(end+1) = N1 * sin(t1) + N2 * sin(t1 + t2) + N3 * sin(t1 + t2 + t3);
    
        % fourth linkage set (determined version)
        % fourth linkage set
        X4(end+1) = O1 * cos(t1) + O2 * cos(t1 + t2) + O3 * cos(t1 + t2 + t3);
        Y4(end+1) = O1 * sin(t1) + O2 * sin(t1 + t2) + O3 * sin(t1 + t2 + t3);
    end
end

% Define workspace: pick/place, planar tracing, planar welding
x_min = 200; x_max = 350;
y_min = -200; y_max = 0;
figure;
rectangle('Position',[x_min, y_min, x_max - x_min, y_max - y_min], ...
          'EdgeColor','k','LineWidth',2,'LineStyle','--');
text(x_min+10,y_min+10,'target workspace');
hold on;

scatter(X1, Y1, 8, 'r', 'filled','MarkerFaceAlpha',0.15);
hold on
scatter(X2 ,Y2 ,8 ,'b', 'filled','MarkerFaceAlpha',0.15);
hold on
scatter(X3, Y3, 8, 'g', 'filled', 'MarkerFaceAlpha', 0.15);
hold on
scatter(X4, Y4, 8, 'm', 'filled', 'MarkerFaceAlpha', 0.15);

plot(0,0,'ko','MarkerSize',10,'LineWidth',2)
xline(0,'k--'); yline(0,'k--');

legend('L1=170, L2=100, L3=50','M1=150, M2=120, M3=50', ...
    'N1=140, N2=130, N3=50','O1=150, O2 = 130, O3 = 60', 'Base');
axis equal;
grid on;