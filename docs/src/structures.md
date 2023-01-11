


# Working with sentences, verbal expressions and tokens

- many functions let you organize related material. examples:
    - finding verbal expressions belonging to a particular sentence
    - finding tokens belonging to a particular sentence or verbal expression
    - finding information about the sentence or verbal expression a particular token belongs to
    
## Organizing material by sentence

Pull data from URL, and choose an example sentence to analyze.

```@example struct
using GreekSyntax, Downloads
url = "https://raw.githubusercontent.com/neelsmith/eagl-texts/main/annotations/Lysias1_annotations.cex"
(sentences, groups, tokens) = Downloads.download(url) |> readlines |> readdelimited
sentence1 = sentences[1]
```





- tokeninfoforsentence

```@example struct
(sentencetokens, connectors, origin) = GreekSyntax.tokeninfoforsentence(sentence1, tokens)
```

- groupsforsentence

```@example struct
groups1 = GreekSyntax.groupsforsentence(sentence1, groups)
```


## Organizing material by verbal expression

- tokensforgroup

## Getting information about an individual token

- groupfortoken(tkn, groups)
- function depthfortoken(tkn::TokenAnnotation, groups::Vector{VerbalUnitAnnotation})


