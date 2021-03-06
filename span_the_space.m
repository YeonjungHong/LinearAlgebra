function vec_set = span_the_space(basis, k,r)
% This function outputs a set of vectors which lies in the vector space
% spanned by the given set of basis vectors.
%
% [Input]
% bases: m-by-n matrix in which n basis vectors span the subspace of m-dim row-wise whole space. 
% k: the number of vectors spanning the subspace to be generated.
% r: the range of random number (e.g. if r=3, random number ranging from -3
% to 3 will be generated)
%
% [Output]
% vec_set: m-by-k matrix which contains k vectors that lie in the subspace.
% 
% Yeonjung Hong
% 2017-03-30

range = r;

% reassign k to the variable name not to be confused
vec_num = k; 

% the dimension of the whole space
whole_dim = size(basis,1); 

% the number of basis vectors, which is the dimension of the subspace
sub_dim = size(basis,2); 

% Generate the random number ranging from -1 to 1 to use it as a
% coefficient matrix for linear combination
coeff = range*(-1 + 3*rand([sub_dim, vec_num])); 

% If you want to enjoy the galactic world, use the code below instead <3
% coeff = randn([sub_dim, vec_num]); 

% Finally, span the basis vectors so that you can get the subspace~~
vec_set = basis*coeff;
