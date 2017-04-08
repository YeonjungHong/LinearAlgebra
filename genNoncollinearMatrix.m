function [output]=genNoncollinearMatrix(dim, numSquare, threshold)

output = {};

while numel(output) < numSquare
    randMat=rand(dim,dim);
    if det(randMat) > threshold
        output = [output; randMat];
    end
end
