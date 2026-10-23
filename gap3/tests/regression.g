Read("gap3/init.g");

NCTestAssert := function(condition, message)
    if not condition then
        Error(Concatenation("regression failed: ", message));
    fi;
end;

NCTestGroup := function(W, expectedCounts)
    local ctx, identity, k, chains, parking, counts, i, cl, w, direct,
        full, empty, pairs, power, p, q, r, allElements, data, entry;
    ctx := NCContext(W, false);
    identity := W.identity;
    empty := [];
    NCTestAssert(List([1..Length(expectedCounts)],
        k -> NCParkingCount(ctx, k, ctx.nc)) = expectedCounts,
        "known ordinary parking counts");
    for k in [1,2] do
        chains := NCChains(ctx, k, ctx.nc);
        counts := NCChainCounts(ctx, k, ctx.nc);
        NCTestAssert(Sum(counts) = Length(chains), "chain DP/enumeration");
        NCTestAssert(Length(Set(chains)) = Length(chains), "unique chains");
        for i in [1..Length(ctx.nc)] do
            NCTestAssert(counts[i] = Length(NCChainsStarting(ctx, k,
                ctx.nc[i])), "starting chains agree with DP");
        od;
        parking := NCParkingFunctions(ctx, k, ctx.nc);
        NCTestAssert(Length(parking) = expectedCounts[k],
            "parking DP/enumeration");
        for cl in ConjugacyClasses(W) do
            w := Representative(cl);
            direct := Number(parking, p ->
                (w * Representative(p[1])) * NCParabolic(ctx, p[2][1])
                    = p[1]);
            NCTestAssert(NCParkingCharacter(ctx, w, k, ctx.nc) = direct,
                "weighted character/direct enumeration");
        od;
        NCTestAssert(NCParkingCount(ctx, k, empty) = 0, "empty endpoint count");
        NCTestAssert(NCChains(ctx, k, empty) = [], "empty endpoint chains");
        NCTestAssert(NCParkingCount(ctx, k, [ctx.c,ctx.c])
            = NCParkingCount(ctx, k, [ctx.c]), "deduplicate endpoints");
        NCTestAssert(NCCharacterComparison(ctx, k, ctx.nc, 1).passed,
            "ordinary character experiment on regression group");
    od;
    full := NCFullSupport(ctx, ctx.nc);
    NCTestAssert(NCParkingCount(ctx, 2, full)
        = Length(NCParkingFunctions(ctx, 2, full)), "restricted DP/enumeration");
    NCTestAssert(NCCharacterComparison(ctx, 2, full,
        1 - Minimum(ReflectionDegrees(W))).passed,
        "full-support character experiment on regression group");
    NCTestAssert(NCSupportIntersectionReport(ctx, ctx.nc).passed,
        "NC support intersections on regression group");
    allElements := Elements(W);
    NCTestAssert(NCSupportIntersectionReport(ctx, allElements).passed,
        "group support intersections on regression group");
    pairs := NCParkingFunctions(ctx, 1, ctx.nc);
    for power in [0..Order(W, ctx.c)-1] do
        for cl in ConjugacyClasses(W) do
            w := Representative(cl);
            direct := Number(pairs,
                p -> NCCyclicAction(ctx, w, power, p) = p);
            NCTestAssert(NCCyclicFixedCount(ctx, w, power) = direct,
                "cyclic count/direct action");
        od;
    od;
    for p in pairs do
        NCTestAssert(NCCyclicAction(ctx, identity, Order(W,ctx.c),p) = p,
            "cyclic period");
        q := NCCyclicAction(ctx, ctx.c, 1, p);
        r := NCCyclicAction(ctx, ctx.c, 2, q);
        NCTestAssert(r = NCCyclicAction(ctx, ctx.c^2, 3, p),
            "W x C action composition");
    od;
    NCTestAssert(NCCyclicComparison(ctx).passed,
        "cyclic eigenvalue experiment on regression group");
    data := NCCosetPosetData(ctx, true);
    NCTestAssert(not Set(allElements) in data.elements,
        "remove whole group from proper coset poset");
    for entry in data.strictRelations do
        NCTestAssert(IsSubset(data.elements[entry[2]],
            data.elements[entry[1]]), "coset poset relation orientation");
    od;
    Print("PASS ", W, " ordinary counts ", expectedCounts, "\n");
end;

NCTestGroup(CoxeterGroup("A",2), [16,49,100,169]);
NCTestGroup(ComplexReflectionGroup(4), [49,169,361,625]);
NCTestGroup(ComplexReflectionGroup(5), [169,625,1369,2401]);
NCTestGroup(ComplexReflectionGroup(6), [169,625,1369,2401]);
# An explicit Coxeter word and a higher-rank example exercise setup separately.
NCTestAssert(NCParkingCount(NCContext(ComplexReflectionGroup(4),[1,2]),
    2, NCContext(ComplexReflectionGroup(4),[1,2]).nc) = 169,
    "explicit Coxeter word");
NCTestAssert(NCCharacterComparison(NCContext(CoxeterGroup("A",3),false),
    2, NCContext(CoxeterGroup("A",3),false).nc,1).passed,
    "rank-three ordinary character");
Print("ALL GAP3 REGRESSION TESTS PASSED\n");
