# API documentation


## Working with sentences

```@docs
GreekSyntax.tokeninfoforsentence
GreekSyntax.sentencerange
GreekSyntax.groupsforsentence
GreekSyntax.sentenceindexfornode
GreekSyntax.sentencesforurn
```

## Working with verbal expressions and tokens

```@docs
GreekSyntax.tokensforgroup
GreekSyntax.groupfortoken
GreekSyntax.depthfortoken
GreekSyntax.passagefromtoken
GreekSyntax.filterbylevel

```

## Syntactic metrics


```@docs
GreekSyntax.maxdepthforsentence
```

## Writing HTML and mermaid diagrams

```@docs
htmltext
htmltext_indented
htmlgroup
htmlgrouplist
sovkey
mermaiddiagram
```



## Internals (not exported)

```@docs
GreekSyntax.tipsfortoken
GreekSyntax.htmltoken
GreekSyntax.classesfortoken
GreekSyntax.groupcolorforint
GreekSyntax.groupcolorfortoken
GreekSyntax.groupcolor
```