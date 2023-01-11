


# Working with sentences, verbal expressions and tokens

Many functions let you organize related annotations about sentences, verbal expressions and tokens, to do things like:

- finding verbal expressions belonging to a particular sentence
- finding tokens belonging to a particular sentence or verbal expression
- finding information about the sentence or verbal expression a particular token belongs to
    
The examples on this page will use the set of annotations downloaded like this:

```@example struct
using GreekSyntax, Downloads
url = "https://raw.githubusercontent.com/neelsmith/eagl-texts/main/annotations/Lysias1_annotations.cex"
(sentences, groups, tokens) = Downloads.download(url) |> readlines |> readdelimited
length(sentences)
```


## Organizing material by sentence

Find verbal expressions belonging to a particular sentence with the `groupsforsentences` function:

```@example struct
s1 = sentences[1]
s1groups = groupsforsentence(s1, groups)
```

Find tokens belonging to a particular sentence:



```@example struct
(sentencetokens, connectors, origin) = tokeninfoforsentence(s1, tokens)
```




## Organizing material by verbal expression

- tokensforgroup

## Getting information about an individual token

- groupfortoken(tkn, groups)
- function depthfortoken(tkn::TokenAnnotation, groups::Vector{VerbalUnitAnnotation})


