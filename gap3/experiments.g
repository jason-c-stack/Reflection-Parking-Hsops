# Candidate identities from the research scripts: comparisons, not theorems.

# Compare character values with (k*h+shift)^dim(V^w).
# shift=1 is the ordinary experiment; shift=1-Minimum(degrees) is the
# full-support experiment. The caller chooses the endpoint restriction.
NCCharacterComparison := function(ctx, k, terminalElements, shift)
    local rows, cl, w, actual, expected;
    NCValidateK(k);
    rows := [];
    for cl in ConjugacyClasses(ctx.W) do
        w := Representative(cl);
        actual := NCParkingCharacter(ctx, w, k, terminalElements);
        expected := (k * ctx.h + shift) ^ NCFixedSpaceDimension(ctx, w);
        Add(rows, rec(representative := w, actual := actual,
            expected := expected, passed := actual = expected));
    od;
    return rec(passed := ForAll(rows, row -> row.passed), rows := rows);
end;

# Compare k=1 W x C values with (h+1)^dim ker(w-zeta^d I).
# The sign of zeta matches cyclic.g's explicit c^-d convention.
NCCyclicComparison := function(ctx)
    local rows, d, cl, w, dimension, actual, expected, cyclicOrder;
    cyclicOrder := Order(ctx.W, ctx.c);
    rows := [];
    for d in [0..cyclicOrder-1] do
        for cl in ConjugacyClasses(ctx.W) do
            w := Representative(cl);
            dimension := Length(NullspaceMat(MatXPerm(ctx.W, w)
                - E(cyclicOrder)^d * IdentityMat(ctx.rank)));
            actual := NCCyclicFixedCount(ctx, w, d);
            expected := (ctx.h + 1) ^ dimension;
            Add(rows, rec(power := d, representative := w,
                actual := actual, expected := expected,
                passed := actual = expected));
        od;
    od;
    return rec(passed := ForAll(rows, row -> row.passed), rows := rows);
end;

# Retains the codegree products as inspectable numerical experiments.
NCFullSupportProducts := function(ctx)
    local degrees, codegrees, nonzero;
    degrees := ReflectionDegrees(ctx.W);
    codegrees := ReflectionCoDegrees(ctx.W);
    # For the intended irreducible groups there is one zero codegree.
    # Filtering avoids depending on CHEVIE's ordering of that entry.
    nonzero := Filtered(codegrees, x -> x <> 0);
    return rec(actualReflections := Length(NCFullSupportReflections(ctx)),
        candidateReflections := ctx.rank * ctx.h / Size(ctx.W)
            * Product(nonzero),
        codegreeProduct := Product(List([1..Length(degrees)],
            i -> (ctx.h + codegrees[i]) / degrees[i])));
end;
