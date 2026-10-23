# A parking function is [leftCoset, chain], with stabilizer W_(chain[1]).
# Use ctx.nc as terminalElements for ordinary parking functions.

NCParkingFunctions := function(ctx, k, terminalElements)
    local parking, chain, coset;
    parking := [];
    for chain in NCChains(ctx, k, terminalElements) do
        for coset in NCLeftCosets(ctx, chain[1]) do
            Add(parking, [coset, ShallowCopy(chain)]);
        od;
    od;
    return parking;
end;

NCParkingCount := function(ctx, k, terminalElements)
    local counts;
    counts := NCChainCounts(ctx, k, terminalElements);
    return Sum(List([1..Length(ctx.nc)], i -> counts[i]
        * Index(ctx.W, NCParabolic(ctx, ctx.nc[i]))));
end;

NCFixedCosets := function(ctx, w, x)
    local H;
    if not w in ctx.W then
        Error("w must belong to the context's group");
    fi;
    H := NCParabolic(ctx, x);
    return Number(NCLeftCosets(ctx, x),
        coset -> (w * Representative(coset)) * H = coset);
end;

# W acts on the coset label; the noncrossing chain stays fixed.
NCParkingCharacter := function(ctx, w, k, terminalElements)
    local counts;
    counts := NCChainCounts(ctx, k, terminalElements);
    return Sum(List([1..Length(ctx.nc)], i -> counts[i]
        * NCFixedCosets(ctx, w, ctx.nc[i])));
end;

NCCharacterTable := function(ctx, k, terminalElements)
    return List(ConjugacyClasses(ctx.W), cl -> rec(
        representative := Representative(cl),
        value := NCParkingCharacter(ctx, Representative(cl), k,
            terminalElements)));
end;

NCFixedSpaceDimension := function(ctx, w)
    if not w in ctx.W then
        Error("w must belong to the context's group");
    fi;
    return Length(NullspaceMat(MatXPerm(ctx.W, w)
        - IdentityMat(ctx.rank)));
end;
