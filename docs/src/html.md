# HTML and CSS conventions

The `GreekSyntax` package includes functions that compose HTML for incorporation in web pages.  The HTML and attached CSS classes produced by these functions are intentionally minimal, to facilitate incorporating the content and adapting its visual styling to its context.


## Passages of Greek text

These functions format passages of Greek in HTML:

- `htmltext` formats a continuous passage of text
- `htmltext_indented` formats the verbal expressions in a passage of text hierarchically indented by level of syntactic subordination

Both functions produce `div` with an attribute `class="passage"`.

Within that `div`, `htmltext_indented` hierarchically wraps verbal expressions in an HTML `blockquote` with attribute `class="subordination"`.






<h4>On <code>span</code></h4>

Class attributes:

	<ul>
<li> <code>connector</code></li>
<li> <code>subject</code></li>
<li> <code>verb</code></li>
<li> <code>object</code></li>
</ul>

	<p>
Also on <code>span</code>: colors from a vector of colors are directly set in <code>style</code> attribute for verbal groups.
	</p>


## Information about verbal expressions

