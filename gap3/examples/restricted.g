Read("gap3/init.g");
ctx := NCContext(ComplexReflectionGroup(4), [1,2]);;
full := NCFullSupport(ctx, ctx.nc);;
# The old rank-filter explorations used 1-based bucket numbers.
# Here rank means the mathematical rank, starting with rank(identity)=0.
minimumRank := 2;;
ends := Filtered(full, x -> ctx.ranks[NCIndex(ctx,x)] >= minimumRank);;
Print("selected endpoints: ", Length(ends), "\n");
Print("restricted counts: ",
    List([1..4], k -> NCParkingCount(ctx, k, ends)), "\n");
Print("full-support reflection/codegree experiment: ",
    NCFullSupportProducts(ctx), "\n");
Print("support intersections in NC: ",
    NCSupportIntersectionReport(ctx, ctx.nc), "\n");
Print("support intersections in W: ",
    NCSupportIntersectionReport(ctx, Elements(ctx.W)), "\n");
# For homology in a separate system, use these distinct cosets and inclusions.
properCosetPoset := NCCosetPosetData(ctx, true);;
Print("proper coset-poset vertices: ",
    Length(properCosetPoset.elements), "\n");
