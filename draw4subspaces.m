% Plot null space and row space
% 2017-03-30 
% EMCS

clear; clc; close;

% Create a matrix.
A = sym([1 2 3; 2 4 6; 1 1 1]);
% A = sym([1 1 1; 2 2 2; 3 3 3]); 

row_dim = size(A,1);
col_dim = size(A,2);

%% Compute the basis for the four fundamental subspaces

% Compute the basis for null space of A.
N_basis = normc(double(null(A)));

% Compute the basis for row space of A. 
% (The column space of A transposed is computed instead.)
R_basis =normc(double(colspace(A')));

% Compute the basis for column space of A. 
C_basis =normc(double(colspace(A)));

% Compute the basis for left null space of A.
leftN_basis = normc(double(null(A')));

%% Span each subspace

N = span_the_space(N_basis, 5000);
R = span_the_space(R_basis, 5000);
R_whole = span_the_space([N_basis R_basis], 5000);

C = span_the_space(C_basis, 5000);
leftN = span_the_space(leftN_basis, 5000);
C_whole = span_the_space([C_basis leftN_basis], 5000);

%% Draw each space
f = gcf;
f.Position = [100 50 1200 900];
f.NumberTitle = 'off';
f.Name = 'The four fundamental subspaces';

subplot(1,2,1); 
plot3(R(1,:), R(2,:), R(3,:), 'bo', 'DisplayName', 'RowSpace(A)'); hold on;
plot3(N(1,:), N(2,:), N(3,:), 'ro', 'DisplayName', 'NullSpace(A)'); hold on;
plot3(R_whole(1,:), R_whole(2,:), R_whole(3,:), 'c.');
title(['Row space vs Null space in ' num2str(row_dim) '-D whole space']);
l1 = legend('RowSpace(A)','NullSpace(A)','Orientation','horizontal','Location','southoutside');
set(l1, 'FontSize', 14); grid on; axis equal

subplot(1,2,2);
plot3(C(1,:), C(2,:), C(3,:), 'ko'); hold on;
plot3(leftN(1,:), leftN(2,:), leftN(3,:), 'mo');hold on;
plot3(C_whole(1,:), C_whole(2,:), C_whole(3,:), 'g.');
title(['Column space vs Left Null space in ' num2str(col_dim) '-D whole space']);
l2 = legend('ColSpace(A)','LeftNullSpace(A)','Orientation','horizontal','Location','southoutside');
set(l2, 'FontSize', 14); grid on; axis equal



