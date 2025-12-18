declare function local:copy($node as node(), $counter as xs:integer) as item()+ {
  typeswitch ($node)
    case element() return
      let $atts := for $att in $node/@* return $att
      let $children-results := 
        fold-left($node/node(), ($counter + 1, ()), 
          function($acc, $child) {
            let $current-counter := $acc[1]
            let $copied-siblings := $acc[position() > 1]
            let $child-result := local:copy($child, $current-counter)
            let $copied-child := $child-result[1]
            let $next-counter := $child-result[2]
            return ($next-counter, $copied-siblings, $copied-child)
          })
      let $final-counter := $children-results[1]
      let $copied-children := $children-results[position() > 1]
      return (element { node-name($node) } { attribute xml:id { $counter }, $atts, $copied-children }, $final-counter)
    default return ($node, $counter)
};

let $doc := db:get("letters")
let $result := local:copy($doc/teiCorpus, 1)
return $result[1]