# Shared GAP3/CHEVIE context. Load init.g from the package directory.

NCValidateK := function(k)
    if not IsInt(k) or k < 1 then
        Error("k must be a positive integer");
    fi;
end;

# Pass false for CHEVIE's default Coxeter word, or a list such as [1,2].
NCContext := function(W, coxeterWord)
    local B, D, levels, nc, ranks, level, x, simpleGenerators, word;
    if not IsFinite(W) or Length(ReflectionType(W)) <> 1 then
        Error("W must be a finite irreducible reflection group");
    fi;
    if coxeterWord = false then
        B := DualBraidMonoid(W);
        D := DualBraid(W);
    else
        if not IsList(coxeterWord) or Length(coxeterWord) = 0 then
            Error("coxeterWord must be false or a nonempty generator list");
        fi;
        B := DualBraidMonoid(W, coxeterWord);
        D := DualBraid(W, coxeterWord);
    fi;
    word := AsWord(D(B.delta));
    simpleGenerators := Set(List(word, i -> EltBraid(D(i))));
    if Length(word) <> Rank(W)
        or Order(W, B.delta) <> Maximum(ReflectionDegrees(W)) then
        Error("choose a reduced rank-length Coxeter word of order h");
    fi;
    if Subgroup(W, simpleGenerators) <> W then
        Error("the chosen Coxeter word does not generate W");
    fi;
    levels := LeftDivisorsSimple(B, B.delta);
    nc := [];
    ranks := [];
    for level in [1..Length(levels)] do
        for x in levels[level] do
            Add(nc, x);
            Add(ranks, level - 1);
        od;
    od;
    return rec(W := W, monoid := B, braid := D, c := B.delta,
        h := Maximum(ReflectionDegrees(W)), rank := Rank(W),
        levels := levels, nc := nc, ranks := ranks, atoms := B.atoms,
        simpleGenerators := simpleGenerators, lower := [], upper := [],
        parabolics := [], cosets := []);
end;

NCIndex := function(ctx, x)
    local i;
    i := Position(ctx.nc, x);
    if i = false then
        Error("element is outside the chosen noncrossing interval");
    fi;
    return i;
end;

NCBelow := function(ctx, x, y)
    return LeftGcd(ctx.braid(x), ctx.braid(y))[1] = ctx.braid(x);
end;

NCPredecessors := function(ctx, i)
    if not IsBound(ctx.lower[i]) then
        ctx.lower[i] := Filtered([1..Length(ctx.nc)],
            j -> ctx.ranks[j] <= ctx.ranks[i]
                and NCBelow(ctx, ctx.nc[j], ctx.nc[i]));
    fi;
    return ctx.lower[i];
end;

NCSuccessors := function(ctx, i)
    if not IsBound(ctx.upper[i]) then
        ctx.upper[i] := Filtered([1..Length(ctx.nc)],
            j -> ctx.ranks[j] >= ctx.ranks[i]
                and NCBelow(ctx, ctx.nc[i], ctx.nc[j]));
    fi;
    return ctx.upper[i];
end;

NCParabolic := function(ctx, x)
    local i, reflections;
    i := NCIndex(ctx, x);
    if not IsBound(ctx.parabolics[i]) then
        reflections := Filtered(ctx.atoms, t -> NCBelow(ctx, t, x));
        ctx.parabolics[i] := Subgroup(ctx.W, reflections);
    fi;
    return ctx.parabolics[i];
end;

NCLeftCosets := function(ctx, x)
    local i;
    i := NCIndex(ctx, x);
    if not IsBound(ctx.cosets[i]) then
        ctx.cosets[i] := LeftCosets(ctx.W, NCParabolic(ctx, x));
    fi;
    return ctx.cosets[i];
end;
