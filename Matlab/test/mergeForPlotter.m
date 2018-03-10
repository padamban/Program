function merge=mergeForPlotter(arrayA, arrayB, fill)

    [rA, cA] = size(arrayA);
    [rB, cB] = size(arrayB);
    
    if cA>cB
       arrayB(rB,(cB+1):cA) = fill;
    elseif cA<cB
       arrayA(rA,(cA+1):cB) = fill;
    end 
    
    merge = [arrayA;arrayB];
end