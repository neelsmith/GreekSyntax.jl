# API documentation


## Working with sentences

```@docs
groupsforsentence
tokensforsentence
sentencesforurn
sentencerange
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
GreekSyntax.maxdepth
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

Sentences:

```@docs
GreekSyntax.connectorindexes
GreekSyntax.sentenceindexfornode
```

HTML:

```@docs
GreekSyntax.tipsfortoken
GreekSyntax.htmltoken
GreekSyntax.classesfortoken
GreekSyntax.groupcolorforint
GreekSyntax.groupcolorfortoken
GreekSyntax.groupcolor
```