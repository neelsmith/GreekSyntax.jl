# Values for syntactic annotations

The `VerbalUnit` annotation and the `TokenAnnotation` use string values for some annotation properties, but when you use the functions `verbalunit` and `token` to construct these objects, they enforce a controlled vocabulary.

Both `verbalunit` and `token` allow string values to be abbreviated with a minimum unique starting string. In the lists on this page, the minimum unique string for each value is highlighted in **bold-faced** letters.

## Annotating verbal expressions

Each verbal expression has two string annotations, for its *syntactic* type, and its *semantic* type.
	
*Syntactic type of verbal expression*

- **ind**ependent clause
- **s**ubordinate clause
- **c**ircumstantial participle
- **at**tributive participle
- **inf**initive in indirect statement
- **p**articiple in indirect statement
- **q**uote
- **as**ide

*Semantic type of verbal expression*

- **t**ransitive
- **i**ntransitive
- **l**inking

## Annotating tokens

The syntactic relation between two tokens is annotated one one of the following values:

- **con**junction
- **subo**rdinate conjunction
- **r**elative pronoun
- **u**nit verb
- **pre**dicate
- **subj**ect
- **di**rect address
- **com**plementary infinitive
- **sup**plementary participle
- **m**odal particle
- **ad**verbial
- **at**tributive
- **ar**ticle
- **pro**noun
- **da**tive
- **g**enitive

In addition, the following abbreviations are predefined.

*Other pre-defined abbreviations*

- **o** == object
- **op** == 	object of preposition
- **s** == subject		
- **sc** == subordinate conjunction
	