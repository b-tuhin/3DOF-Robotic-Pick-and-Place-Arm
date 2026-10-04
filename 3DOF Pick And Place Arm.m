clc, clearvars; clear;

x = 24;         %xDestination
y = 32;         %yDestination 


r1 = 30;        %1stArmLength
r2 = 15;        %2ndArmLength


theta1i = deg2rad(20);          %InitialAngle1stArmRespty
theta2i = deg2rad(30);          %InitialAngle2stArmRespty

%Calculating Intital Arm Position
a = r1*sin(theta1i);
b = r1*cos(theta1i);
c = a + r2*sin(theta2i);
d = b + r2*cos(theta2i);

T = tiledlayout(2,2);

%Plotting Initial Arm Position
ax1 = nexttile(1);
plot([0 a], [0 b], 'LineWidth', 6, 'Color', 'r');
hold on
axis equal
grid on
plot([a c], [b d], 'LineWidth', 6, 'Color', 'b');
plot([-5 5], [0 0], 'LineWidth', 10, 'Color', 'g');
plot(x, y, 'Marker', 'diamond', 'Color', 'y', 'MarkerFaceColor', 'y');
axis(ax1, [-45 45 0 45]);
axis(ax1, 'manual');


theta1g1 = 0;
theta2g1 = 1;
option = optimoptions('fsolve', 'Display', 'Iter', 'FunctionTolerance', 1e-10);
[theta1, fval, exitflag] = fsolve(@(theta) theta_funtion(theta, x, y, r1, r2, theta1i, theta2i), [theta1g1; theta2g1], option);

norm(fval)
exitflag

theta1g2 = 1;
theta2g2 = -2;
[theta2, fval, exitflag] = fsolve(@(theta) theta_funtion(theta, x, y, r1, r2, theta1i, theta2i), [theta1g2; theta2g2], option);

norm(fval)
exitflag



%Calculating Target Arm Position 1
at1 = r1*sin(theta1(1) + theta1i);
bt1 = r1*cos(theta1(1) + theta1i);
ct1 = at1 + r2*sin(theta1(2) + theta1(1) + theta2i);
dt1 = bt1 + r2*cos(theta1(2) + theta1(1) + theta2i);

%Plotting Target Arm Position 1
ax2 = nexttile(2);
plot([0 at1], [0 bt1], 'LineWidth', 6, 'Color', 'r');
hold on
axis equal
grid on
plot([at1 ct1], [bt1 dt1], 'LineWidth', 6, 'Color', 'b');
plot([-5 5], [0 0], 'LineWidth', 10, 'Color', 'g');
plot(x, y, 'Marker', 'diamond', 'Color', 'y', 'MarkerFaceColor', 'y');
axis(ax2, [-45 45 0 45]);
axis(ax2, 'manual');

%Calculating Target Arm Position 2
at2 = r1*sin(theta2(1) + theta1i);
bt2 = r1*cos(theta2(1) + theta1i);
ct2 = at2 + r2*sin(theta2(2) + theta2(1) + theta2i);
dt2 = bt2 + r2*cos(theta2(2) + theta2(1) + theta2i);

%Plotting Target Arm Position 2
ax3 = nexttile(3);
plot([0 at2], [0 bt2], 'LineWidth', 6, 'Color', 'r');
hold on
axis equal
grid on
plot([at2 ct2], [bt2 dt2], 'LineWidth', 6, 'Color', 'b');
plot([-5 5], [0 0], 'LineWidth', 10, 'Color', 'g');
plot(x, y, 'Marker', 'diamond', 'Color', 'y', 'MarkerFaceColor', 'y');
axis(ax3, [-45 45 0 45]);
axis(ax3, 'manual');



%For Starting Guess 
ax4 = nexttile(4);
f1 = @(X,Y) r1*sin(theta1i + X) + r2*sin(theta2i + X + Y) - x;
f2 = @(X,Y) r1*cos(theta1i + X) + r2*cos(theta2i + X + Y) - y; 

fimplicit(f1, [-10,10], 'Color', 'r'); hold on 
fimplicit(f2, [-10,10], 'Color', 'b'); grid on,axis equal


function F = theta_funtion(theta, x, y, r1, r2, theta1i, theta2i)
F(1) = r1*sin(theta1i + theta(1)) + r2*sin(theta2i + theta(1) + theta(2)) - x;
F(2) = r1*cos(theta1i + theta(1)) + r2*cos(theta2i + theta(1) + theta(2)) - y; 
end