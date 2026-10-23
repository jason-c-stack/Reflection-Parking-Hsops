Read("gap3/init.g");
ctx := NCContext(ComplexReflectionGroup(4), false);;
Print("ordinary k=1,2 counts: ",
    List([1,2], k -> NCParkingCount(ctx, k, ctx.nc)), "\n");
full := NCFullSupport(ctx, ctx.nc);;
Print("full-support k=1,2 counts: ",
    List([1,2], k -> NCParkingCount(ctx, k, full)), "\n");
Print("ordinary character comparison: ",
    NCCharacterComparison(ctx, 2, ctx.nc, 1).passed, "\n");
Print("full-support character comparison: ",
    NCCharacterComparison(ctx, 2, full,
        1 - Minimum(ReflectionDegrees(ctx.W))).passed, "\n");
Print("k=1 cyclic comparison: ", NCCyclicComparison(ctx).passed, "\n");
