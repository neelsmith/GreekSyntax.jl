

```@setup struct
using GreekSyntax, Downloads
url = "https://raw.githubusercontent.com/neelsmith/eagl-texts/main/annotations/Lysias1_annotations.cex"
(sentences, groups, tokens) = Downloads.download(url) |> readlines |> readdelimited
length(sentences)
```



# Working with sentences, verbal expressions and tokens

The `GreekSyntax` package includes many functions documented in the API page on this site.  This page highlights a few functions relating annotations in the hierarchy of sentences, verbal expressions, and tokens, to each other.

## Sentence

Find verbal expressions belonging to a particular sentence:

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

Find lexical tokens belonging to a particular sentence:

```@example struct
s1tokens = lexicalforsentence(s1, tokens)
typeof(s1tokens)
```


## Verbal expression

Find tokens belonging to a particular verbal expression:

```@example struct
g1 = groups[1]
g1tokens = tokensforgroup(g1, tokens)
typeof(g1tokens)
```

Find the sentence a verbal expression belongs to:

```@example struct
g1sentence = sentenceforgroup(g1, sentences)
```



## Token

Find the group a token belongs to:

```@example struct
t1 = tokens[1]
groupfortoken(t1, groups)
```

Find the sentence a token belongs to:


```@example struct
sentencefortoken(t1, groups, sentences)
```