# HTML and CSS conventions

The `GreekSyntax` package includes functions that compose HTML for incorporation in web pages.  The HTML and attached CSS classes produced by these functions are intentionally minimal, to facilitate incorporating the content and adapting its visual styling to its context.


## Passages of Greek text

These functions format passages of Greek in HTML:

- `htmltext` formats a continuous passage of text
- `htmltext_indented` formats the verbal expressions in a passage of text hierarchically indented by level of syntactic subordination

Both functions produce a single `div` with an attribute `class="passage"`. Within that `div`, `htmltext_indented` hierarchically wraps verbal expressions in an HTML `blockquote` with attribute `class="subordination"`.


Each lexical token is wrapped in a `span`.  If the `sov` parameter is true, a class attribute from the following list be added.  CSS settings can then define visual highlight for these classes.  The class attribute may include any one of the following values:

- `connector`: for tokens indentified as connecting words, joining the sentence to its larger context
- `verb`: for a *unit verb*.  Note that, in addition to finite verb forms, this includes constructions like infinitives in indirect statement, and circumstantial or attributive participles.
- `subject`: for the grammatical *subject* of a unit verb.
- `object`: for the *object* of a unit verb.  Note that the case used will depend on the construction of the lexeme used for the unit verb, and need not be limited to the accusative case.

In addition, if the `vucolor` parameter is true, a `style` element is added to each lexical token assigned to a verbal expresion (or verbal unit).  The style element defines a foreground color drawn from a list of RGB values.


## Information about verbal expressions

TBA