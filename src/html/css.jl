
"""Define default CSS values for classes written by HTML
functions to identify syntax.
$(SIGNATURES)
"""
function defaultcss()

    """   
.passage {
  padding-top: 2em;
  padding-bottom: 2em;
}
.ref {
  color: silver;
}
.ref:before {
  content: "[";
}
.ref:after {
  content: "] "
}
.subject {
  text-decoration: underline;
  text-decoration-thickness: 3px;
}
.object {
  text-decoration: underline;
  text-decoration-style: wavy;
}
.verb {
  border: thin solid black;
  padding: 1px 3px; 
}
blockquote.subordination {
  padding: 0em;
}
.connector {
  background: yellow;  
  font-style: bold;
}
.nav {
  text-align: center;
}
.left {
  float: left;
}
.right {
  float: right;
}
footer {
  text-align: right;
  font-style: italic;
} 

 /** Tool tip functionality: */   
span.tooltip{
  position: relative;
  display: inline;
}
span.tooltip:hover:after{ 
  visibility: visible; 
  opacity: 0.8; 
  bottom: 20px; 
}
span.tooltip:hover:before{ 
  visibility: visible; 
  opacity: 0.8; 
  bottom: 14px; 
}   
span.tooltip:after{
  display: block;
  visibility: hidden;
  position: absolute;
  bottom: 0;
  left: 50%;
  opacity: 0.9;
  content: attr(tool-tips);
  height: auto;
  width: auto;
  min-width: 100px;
  padding: 5px 8px;
  z-index: 999;
  color: #fff;
  text-decoration: none;
  text-align: center;
  background: rgba(0,0,0,0.85);
  -webkit-border-radius: 5px;
  -moz-border-radius: 5px;
  border-radius: 5px;
}
span.tooltip:before {
  position: absolute;
  visibility: hidden;
  width: 0;
  height: 0;
  left: 50%;
  bottom: 0px;
  opacity: 0;
  content: "";
  border-style: solid;
  border-width: 6px 6px 0 6px;
  border-color: rgba(0,0,0,0.85) transparent transparent transparent;
}
"""   
end

"""Define default CSS values for formatting a CSS page.
Derived from the MIT-licensed source at https://github.com/susam/spcss.
Original text of that source is left in comments when this version
differs.
$(SIGNATURES)
"""
function pagecss()
  """body {
  color: #333;
  font-family: helvetica, arial, sans-serif;
  line-height: 1.5;
  margin: 0 auto;
  max-width: 40em;
  padding: 0 1em;
}
h1, h2, h3, h4, h5, h6 {
  margin: 1.25em 0 0.5em 0;
  line-height: 1.2;
}
a:link {
  color: #00e;
}
a:visited {
  color: #518;
}
a:focus, a:hover {
  color: #03f;
}
a:active {
  color: #e00;
}
h1 a:empty:before, h2 a:empty:before, h3 a:empty:before,
h4 a:empty:before, h5 a:empty:before, h6 a:empty:before {
  content: "#";
}
h1 a:empty, h2 a:empty, h3 a:empty, h4 a:empty, h5 a:empty, h6 a:empty {
  visibility: hidden;
  padding-left: 0.25em;
}
h1:hover a:empty, h2:hover a:empty, h3:hover a:empty,
h4:hover a:empty, h5:hover a:empty, h6:hover a:empty {
  visibility: visible;
}
img {
  max-width: 100%;
}
figure {
  margin: 1em 0;
  text-align: center;
}
figcaption {
  font-size: small;
}
pre, code, samp, kbd {
  font-family: monospace, monospace;
}
pre, code, kbd {
  color: #050;
}
samp {
  color: #730;
}
pre, blockquote {
  /*background: #eee;
  padding: 0.5em;*/
  padding: 1em;
}
pre {
  overflow: auto;
}
blockquote {
  /*border-left: medium solid #ccc;*/
  /*margin: 1em 0;*/
  margin: 0 0 0 2em;
}
blockquote :first-child {
  margin-top: 0;
}
blockquote :last-child {
  margin-bottom: 0;
}
table {
  border-collapse: collapse;
}
th, td {
  border: thin solid #999;
  padding: 0.3em 0.4em;
  text-align: left;
}
@media (prefers-color-scheme: dark) {
  body {
    background: #111;
    color: #bbb;
  }
  a:link {
    color: #9bf;
  }
  a:visited {
    color: #caf;
  }
  a:focus, a:hover {
    color: #9cf;
  }
  a:active {
    color: #f99;
  }
  pre, code, kbd {
    color: #9c6;
    font-family: monospace, monospace;
  }
  samp {
    color: #db0;
  }
  pre, blockquote {
    background: #000;
  }
  blockquote {
    border-color: #333;
  }
  th, td {
    border-color: #666;
  }
}"""
end