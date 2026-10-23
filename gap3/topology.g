# Data for a separate topology calculation: distinct cosets ordered by inclusion.
# No homology library is assumed, and no homology result is claimed.

NCCosetPosetData := function(ctx, omitWholeGroup)
    local cosets, x, coset, elements, relations, i, j;
    if not IsBool(omitWholeGroup) then
        Error("omitWholeGroup must be true or false");
    fi;
    cosets := [];
    for x in ctx.nc do
        for coset in NCLeftCosets(ctx, x) do
            AddSet(cosets, Set(Elements(coset)));
        od;
    od;
    if omitWholeGroup then
        RemoveSet(cosets, Set(Elements(ctx.W)));
    fi;
    elements := cosets;
    relations := [];
    for i in [1..Length(elements)] do
        for j in [1..Length(elements)] do
            if i <> j and IsSubset(elements[j], elements[i]) then
                Add(relations, [i, j]);
            fi;
        od;
    od;
    return rec(elements := elements, strictRelations := relations);
end;

# Export only integer vertex labels and relations; original group labels stay
# available in NCCosetPosetData. The generated .sage file is optional.
NCWriteSagePoset := function(ctx, omitWholeGroup, path)
    local data;
    data := NCCosetPosetData(ctx, omitWholeGroup);
    PrintTo(path, "# Generated from the GAP3 coset-inclusion poset.\n",
        "relations = ", data.strictRelations, "\n",
        "P = Poset((list(range(1, ", Length(data.elements) + 1,
        ")), relations))\n",
        "C = P.order_complex()\n",
        "print(C.homology())\n");
end;
