% This script draws the X complete, X particular and X nullspaces
% space.

clear all; close all; clc;
%% Put A and b here
% row-wise dimension or column-wise dimension of A should range from 1 to 3
% A = [1 2 2 ; 2 4 5];
% b = [1; 4];
A=[1 1];
b=[8];

% obtain the size of the matrix
row_dim = size(A,1);
col_dim = size(A, 2);
%% LU decomposition
[L_concat,U_concat] = lu([A b]);
U = U_concat(:, 1:col_dim);
c = U_concat(:, col_dim+1:end);
%% Row reduced echelon form
[reduced, pivot_idx]  = rref([A b]);
free_idx = setdiff(1:col_dim, pivot_idx);
R = reduced(:, 1:col_dim); % A --> R
d = reduced(:, col_dim+1:end); % b --> d

%%  Compute Nullspace, Rowspace, Xparticular, Xnull, Xcomplete

% get basis of nullspace and vectors spanning the space
N_basis = null(A);
N = span_the_space(N_basis, 5000,8);

% get basis of nullspace and vectors spanning the space
RS_basis = normc(double(colspace(sym(A'))));
RS= span_the_space(RS_basis, 5000,8);

% copy R
R_new = R;

% set free variable to 0 and multiply it to free vectors
R_new(:,free_idx)= 0;

% Solve the equation to get one Xparticular
Xparticular = R_new\d;

% number of Xparticular I want to choose
numXparticular= 2;

% X complete
Xcomplete = N + repmat(Xparticular, [1 size(N,2)]);

% Another Xparticular which is orthogonal to Nullspace, in other words,
% pseudoinverse solution
Xparticular_RS = pinv(A)*b;
%% draw  the nullspace of R and its basis vectors


% Define functions for plotting vectors
drawArrow2 = @(c,v,varargin) quiver(c(1), c(2), v(1), v(2), varargin{:});
drawArrow3 = @(c,v,varargin) quiver3(c(1), c(2), c(3), v(1), v(2), v(3), varargin{:});
% set origin vector for drawArrow
orig = [0 0 0]';

% color scheme list
salmon=[250 128 114]/255;
lightCoral=[240 128 128]/255;
indianRed1=[255 106 106]/255;
maroon=[176 48 96]/255;
aquamarine=[112 219 147]/255;
navyBlue=[0 0 128]/255;
mediumTurquoise=[72;209;204]/255;
gray=[170 170 170]/255;

% plot nullspace ,its basis  and row space
for i=1:numel(free_idx)
    switch col_dim
        case 2
            plot(N(1,:), N(2,:), '.', 'color',aquamarine, 'displayname', 'nullspace(A)');hold on;
            plot(RS(1,:),RS(2,:), '.', 'color',mediumTurquoise,'displayname', 'rowspace(A)');hold on;
            plot(Xcomplete(1,:), Xcomplete(2,:), '.', 'color',navyBlue,'DisplayName', 'Xcomplete');hold on;
            legend show
            
            drawArrow2(orig, N_basis(:,i), 'color', maroon, 'linewidth', 2, 'autoscale','off','MaxHeadSize', 0.2);hold on;grid on;axis equal
            drawArrow2(orig, Xparticular, 'color', indianRed1, 'linewidth', 2 , 'autoscale','off','MaxHeadSize', 0.2);hold on;
            drawArrow2(orig, Xparticular_RS, 'color', 'r', 'linewidth', 2 ,'autoscale','off','MaxHeadSize', 0.2);hold on;
            
            text(N_basis(1,i),N_basis(2,i), 'nullspace basis','horizontalalignment','right')
            text(max(N(1,:)), min(N(2,:)),[num2str(A(1)) '*X1 + ' num2str(A(2)) '*X2 = 0'],'horizontalalignment','left')
            text(max(Xcomplete(1,:)), min(Xcomplete(2,:)), [num2str(A(1)) '*X1 + ' num2str(A(2)) '*X2 = ' num2str(b)],'horizontalalignment','left')
            text(Xparticular(1), Xparticular(2), 'Free variables set to 0','horizontalalignment','left')
            text(Xparticular_RS(1), Xparticular_RS(2), 'Pseudoinverse solution','horizontalalignment','left')
            
            % random indices from Nullspace
            idx = randi(size(N,2), 1, numXparticular);
            
            for k=idx
                % get X particular
                Xparticular_other = Xparticular_RS + N(:, k);
                % plot other Xparticular
                drawArrow2(orig, Xparticular_other, 'color', gray, 'linewidth', 2 ,'marker','p', 'markerfacecolor','k','autoscale','off','MaxHeadSize', 0.2);
            end
            
        case 3
            plot3(N(1,:), N(2,:), N(3,:), '.',  'color',aquamarine,'displayname', 'NullSpace(A)');hold on;legend;
            plot3(RS(1,:), RS(2,:), RS(3,:), '.',  'color',mediumTurquoise,'displayname', 'RowSpace(A)');hold on;
            plot3(Xcomplete(1,:), Xcomplete(2,:), Xcomplete(3,:), '.', 'color',navyBlue,'DisplayName', 'Xcomplete');hold on;grid on;
            legend show
            
            drawArrow3(orig, N_basis(:,i), 'color', maroon,'linewidth', 2,   'autoscale','off','MaxHeadSize', 0.2);hold on;grid on;axis equal
            drawArrow3(orig, Xparticular, 'color', indianRed1, 'linewidth', 2 , 'autoscale','off','MaxHeadSize', 0.2);hold on;
            drawArrow3(orig, Xparticular_RS,'color', 'r', 'linewidth', 2 ,  'autoscale','off','MaxHeadSize', 0.2);hold on;
            
            
            text(N_basis(1,i),N_basis(2,i), N_basis(3,i), 'nullspace basis')
            text(Xparticular(1), Xparticular(2), Xparticular(3), 'Free variables set to 0','horizontalalignment','left')
            text(Xparticular_RS(1), Xparticular_RS(2), Xparticular_RS(3),'Pseudoinverse solution','horizontalalignment','left')
            
           % random indices from Nullspace
            idx = randi(size(N,2), 1, numXparticular);
            
            for k=idx
                % get X particular
                Xparticular_other = Xparticular_RS + N(:, k);
                % Plot other Xparticulars
                drawArrow3(orig, Xparticular_other,'color', gray, 'linewidth', 2 ,'autoscale','off','MaxHeadSize', 0.2);
            end
    end
end



