# Weakly increasing chains x_1 <= ... <= x_k in the chosen interval.
# Endpoint lists are sets: duplicates do not multiply chain counts.

NCChains := function(ctx, k, terminalElements)
    local chains, next, step, chain, j, indices, i, newchain;
    NCValidateK(k);
    indices := Set(List(terminalElements, x -> NCIndex(ctx, x)));
    chains := List(indices, i -> [ctx.nc[i]]);
    step := 1;
    while step < k do
        next := [];
        for chain in chains do
            i := NCIndex(ctx, chain[1]);
            for j in NCPredecessors(ctx, i) do
                newchain := [ctx.nc[j]];
                Append(newchain, chain);
                Add(next, newchain);
            od;
        od;
        chains := next;
        step := step + 1;
    od;
    return chains;
end;

NCChainsStarting := function(ctx, k, firstElement)
    local chains, next, step, chain, i, j, newchain;
    NCValidateK(k);
    NCIndex(ctx, firstElement);
    chains := [[firstElement]];
    step := 1;
    while step < k do
        next := [];
        for chain in chains do
            i := NCIndex(ctx, chain[Length(chain)]);
            for j in NCSuccessors(ctx, i) do
                newchain := ShallowCopy(chain);
                Add(newchain, ctx.nc[j]);
                Add(next, newchain);
            od;
        od;
        chains := next;
        step := step + 1;
    od;
    return chains;
end;

# Number of allowed k-chains starting at ctx.nc[i], without listing chains.
NCChainCounts := function(ctx, k, terminalElements)
    local counts, next, indices, i, step;
    NCValidateK(k);
    indices := Set(List(terminalElements, x -> NCIndex(ctx, x)));
    counts := List(ctx.nc, x -> 0);
    for i in indices do
        counts[i] := 1;
    od;
    step := 1;
    while step < k do
        next := List([1..Length(ctx.nc)],
            i -> Sum(List(NCSuccessors(ctx, i), j -> counts[j])));
        counts := next;
        step := step + 1;
    od;
    return counts;
end;
