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
maxdepth
distance
displacement
cohesion
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

## Internal functions (not exported)

Sentences:

```@docs
GreekSyntax.connectorindexes
GreekSyntax.sentenceindexfornode
```

Tokens:

```@docs
GreekSyntax.depthfortoken
GreekSyntax.filterbylevel
GreekSyntax.passagefromtoken
```

Composing HTML:

```@docs
GreekSyntax.tipsfortoken
GreekSyntax.htmltoken
GreekSyntax.classesfortoken
GreekSyntax.groupcolorforint
GreekSyntax.groupcolorfortoken
GreekSyntax.groupcolor
```