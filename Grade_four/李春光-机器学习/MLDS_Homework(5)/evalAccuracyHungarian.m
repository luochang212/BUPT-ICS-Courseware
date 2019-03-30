function accuracy = evalAccuracyHungarian(label, labelTruth)
% Find segmentation accuracy.
% Input:
%   label: label given by algorithm(e.g. SSC).
%   labelTruth: ground truth label.

labelVal = unique(label);% e.g. [0 128 255];
labelTruthVal = unique(labelTruth);% e.g.[1 2 3 4]
n = length(labelVal);% e.g. 3
nTruth = length(labelTruthVal);% e.g. 4

if n > nTruth
    accuracy = evalAccuracyHungarian(labelTruth, label);
    return;
end

minBadLabelCount = +inf;
combMat = nchoosek(labelTruthVal, n);
costMat = zeros(n);
for ii = 1:size(combMat, 1)
    combVal = combMat(ii, :);% e.g. [1 3 4]
    
    for jj = 1:n
        for kk = 1:n
            costMat(jj, kk) = sum( labelTruth( label == labelVal(jj) ) ~= combVal(kk) );
        end
    end
    [~, badLabelCount] = munkres(costMat);
    if badLabelCount < minBadLabelCount
        minBadLabelCount = badLabelCount;
    end
end
accuracy = 1 - minBadLabelCount / length(label);

end

