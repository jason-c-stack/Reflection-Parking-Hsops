# Support is relative to ctx.simpleGenerators (the chosen Coxeter word).

NCStandardParabolics := function(ctx)
    local subsets;
    if not IsBound(ctx.standardParabolics) then
        subsets := Combinations(ctx.simpleGenerators);
        ctx.standardParabolics := List(subsets,
            generators -> rec(generators := generators,
                group := Subgroup(ctx.W, generators)));
    fi;
    return ctx.standardParabolics;
end;

NCFullSupport := function(ctx, domain)
    local proper;
    proper := Filtered(NCStandardParabolics(ctx), p -> p.group <> ctx.W);
    return Filtered(Set(domain), x -> ForAll(proper, p -> not x in p.group));
end;

NCFullSupportReflections := function(ctx)
    return NCFullSupport(ctx, ctx.atoms);
end;

# Test W_I intersect W_J = W_(I intersect J), restricted to `domain`.
# Pass ctx.nc for the NC experiment, or Elements(ctx.W) for the group.
NCSupportIntersectionReport := function(ctx, domain)
    local parabolics, witnesses, i, j, p, q, intersection, H, failures;
    parabolics := NCStandardParabolics(ctx);
    witnesses := [];
    for i in [1..Length(parabolics)] do
        p := parabolics[i];
        for j in [i..Length(parabolics)] do
            q := parabolics[j];
            intersection := Intersection(p.generators, q.generators);
            H := Subgroup(ctx.W, intersection);
            failures := Filtered(Set(domain),
                x -> x in p.group and x in q.group and not x in H);
            if Length(failures) > 0 then
                Add(witnesses, rec(left := p.generators,
                    right := q.generators, intersection := intersection,
                    elements := failures));
            fi;
        od;
    od;
    return rec(passed := Length(witnesses) = 0, witnesses := witnesses);
end;
