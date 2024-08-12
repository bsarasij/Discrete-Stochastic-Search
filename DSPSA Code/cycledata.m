classdef cycledata % For per cycle data, i.e. the data from each SPSA iteration for each set
% of cycles (est/val sets)
    properties
        w % Feature Selection per iteration
        fititer % Weighted Average of Fit per iteration -- from 'fit'
        valfit % Validation Data fit per iteration -- from 'valfit'
        estfit % Estimation Data fit per iteration -- from 'estfit'
        ovefit % Overall Data fit per iteration -- from 'ovefit'
        na % na per iteration (for ALL features -- combine with w values for plots) -- from allna
        nb % nb per iteration (for ALL features -- combine with w values for plots) -- from allnb
        nk % nk per iteration (for ALL features -- combine with w values for plots) -- from allnk
        avgfits % from finalaverages
        cyclefits % from finalcycles
    end
end
