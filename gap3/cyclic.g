# W x C action for k=1 only; C has generator c=ctx.c.
# (w,c^d): [g*W_x,x] -> [w*g*c^-d*W_y,y], y=c^d*x*c^-d.
# This is NOT the order-k*h Fuss rotation when k>1.

NCCyclicAction := function(ctx, w, d, parking)
    local x, y, power, coset;
    if not IsInt(d) then
        Error("d must be an integer");
    fi;
    if not w in ctx.W then
        Error("w must belong to the context's group");
    fi;
    if Length(parking[2]) <> 1 then
        Error("NCCyclicAction is defined here only for k=1");
    fi;
    x := parking[2][1];
    power := ctx.c ^ d;
    y := power * x * power^-1;
    coset := (w * Representative(parking[1]) * power^-1)
        * NCParabolic(ctx, y);
    return [coset, [y]];
end;

NCCyclicFixedCount := function(ctx, w, d)
    local power, total, x, H, coset;
    if not IsInt(d) then
        Error("d must be an integer");
    fi;
    if not w in ctx.W then
        Error("w must belong to the context's group");
    fi;
    power := ctx.c ^ d;
    total := 0;
    for x in ctx.nc do
        if power * x * power^-1 = x then
            H := NCParabolic(ctx, x);
            for coset in NCLeftCosets(ctx, x) do
                if (w * Representative(coset) * power^-1) * H = coset then
                    total := total + 1;
                fi;
            od;
        fi;
    od;
    return total;
end;

# Tests every residue d, including 0, rather than only divisors of h.
NCCyclicCharacterTable := function(ctx)
    return List([0..Order(ctx.W, ctx.c)-1], d -> rec(power := d,
        values := List(ConjugacyClasses(ctx.W),
            cl -> NCCyclicFixedCount(ctx, Representative(cl), d))));
end;
