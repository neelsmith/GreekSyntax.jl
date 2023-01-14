using GreekSyntax



vushorts = mdshortcuts(GreekSyntax.vutypes)
verbshorts = mdshortcuts(GreekSyntax.verbsemantics)
syntaxshorts = mdshortcuts(GreekSyntax.syntaxrelations)


function mdlist(slist)
    join(map(s -> "- " * s, slist), "\n")
end

hdgs = [
    "Types of verbal expression",
    "Verbs' semantic types",
    "Syntactic relations"
]
lists = [
    mdlist(vushorts),
    mdlist(verbshorts),
    mdlist(syntaxshorts)
]

guidelines = ["## Shortcuts", ""]
for (i, hdg) in enumerate(hdgs)
    push!(guidelines, "### $hdg")
    push!(guidelines, "")
    push!(guidelines, lists[i])
    push!(guidelines, "")
end

open("shortcuts.md", "w") do io
    write(io, join(guidelines, "\n"))
end

vcat([vushorts, verbshorts, syntaxshorts])

length(vushorts) + length(verbshorts) + length(syntaxshorts)
