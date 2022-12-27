```@setup basic
root = pwd() |> dirname |> dirname
```

# Read a delimited file


The `test/data` directory of this repository has a test file with syntactic annotations for two sentences of Lysias 1.

```@example basic
f = joinpath(root, "test", "data", "lysias1_selection.cex")
```

Read it with the standard Julia function `readlines`, and use the `parsedelimited` function of `GreekSyntax` to parse it.  The result is a tuple with three vectors respectively containing annotations for sentences, verbal units and individual tokens.

```@example basic
using GreekSyntax
(sentences, verbalunits, tokens) = readlines(f) |> parsedelimited
length(sentences)
```

```@example basic
length(verbalunits)
```
```@example basic
length(tokens)
```