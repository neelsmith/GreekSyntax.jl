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
tokensforgroup
sentenceforgroup
groupfortoken
sentencefortoken
```

## Syntactic metrics


```@docs

distance
displacement
displacedby
cohesion
span
spansize
maxdepth
maxtokendistance
avgtokendistance
maxtokendisplacement
avgtokendisplacement
maxgroupdisplacement
avggroupdisplacement
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
GreekSyntax.originindex
GreekSyntax.sentenceindexfornode
GreekSyntax.syntactictypes
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