```@setup basic
root = pwd() |> dirname |> dirname
```

# Reading an annotated text from a delimited-text source

The `readdelimited` function takes a Vector of delimited-text strings and parses them into annotations on sentences, verbal expressions, and individual tokens.  (See the page on delimited-text format for details of its structure.)


The `test/data` directory of this repository has a test file with syntactic annotations on sentences from Lysias 1.

```@example basic
f = joinpath(root, "test", "data", "Lysias1.6ff.cex")
```

You can read it with the standard Julia function `readlines`, and pass this directly to `readdelimited`. The result is a tuple with three vectors respectively containing annotations for sentences, verbal expressions and individual tokens.

```@example basic
using GreekSyntax
(sentences, verbalunits, tokens) = readlines(f) |> readdelimited
length(sentences)
```

```@example basic
length(verbalunits)
```
```@example basic
length(tokens)
```

It is equally easy to retrieve a source from a URL.  Here is a  set of annottions from the `eagl-texts` repository:

```@example basic
url = "https://raw.githubusercontent.com/neelsmith/eagl-texts/main/annotations/Lysias1_annotations.cex"

using Downloads
(remote_sentences, remote_verbalunits, remote_tokens) = Downloads.download(url) |> readlines |> readdelimited
length(remote_sentences)
```

```@example basic
length(remote_verbalunits)
```
```@example basic
length(remote_tokens)
```