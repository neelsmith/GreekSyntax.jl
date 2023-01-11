

```@setup struct
using GreekSyntax, Downloads
url = "https://raw.githubusercontent.com/neelsmith/eagl-texts/main/annotations/Lysias1_annotations.cex"
(sentences, groups, tokens) = Downloads.download(url) |> readlines |> readdelimited
length(sentences)
```



# Working with sentences, verbal expressions and tokens

The `GreekSyntax` package includes many functions documented in the API listing on this site for working with annotations about sentences, verbal expressions and tokens.  This page highlights a few functions to relate annotations to each other, such as:

- finding verbal expressions belonging to a particular sentence
- finding tokens belonging to a particular sentence or verbal expression
- finding information about the sentence or verbal expression a particular token belongs to
    


## Organizing material by sentence

Find verbal expressions belonging to a particular sentence with the `groupsforsentences` function:

```@example struct
s1 = sentences[1]
s1groups = groupsforsentence(s1, groups)
typeof(s1groups)
```

Find tokens belonging to a particular sentence:

```@example struct
s1tokens = tokensforsentence(s1, tokens)
typeof(s1tokens)
```


## Organizing material by verbal expression

Find tokens belonging to a particular verbal expression:

```@example struct
g1 = groups[1]
g1tokens = tokensforgroup(g1, tokens)
typeof(g1tokens)
```


## Getting information about an individual token

- groupfortoken(tkn, groups)
- function depthfortoken(tkn::TokenAnnotation, groups::Vector{VerbalUnitAnnotation})


