
function defaultcss()

    """.passage {
    padding-top: 2em;
    padding-bottom: 2em;
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
   
    .unassigned {
    color: silver;
    }
    
   
   span.tooltip{
     position: relative;
     display: inline;
   }
   span.tooltip:hover:after{ visibility: visible; opacity: 0.8; bottom: 20px; }
   span.tooltip:hover:before{ visibility: visible; opacity: 0.8; bottom: 14px; }
   
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