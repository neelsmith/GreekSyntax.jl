# Delimited-text format

## Structure

- line-oriented plain text
- empty lines and comments (starting with `//`) are ignored
- lines are segmented by block labels
- block labels begin with `#!`
   - `#!sentences`
   - `#!verbal_units`
   - `#!tokens`
- within each type of block, one header line and 1 or more data lnes lines of delimited text with specified columns for each block type


## Examples

### sentence

```
#!sentences
sentence|sequence|connector
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1-1.6.46a|10|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.2
```

### verbal expression

```
#!verbal_units
vuid|syntactic_type|semantic_type|depth|sentence
1.6.1-1.6.46a.1|intransitive|Independent clause|1|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1-1.6.46a
```


### token

```
#!tokens
urn|tokentype|text|verbalunit|node1|node1relation|node2|node2relation
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1|lexical|ἐγὼ|1.6.1-1.6.46a.1|20|subject|nothing|nothing
```