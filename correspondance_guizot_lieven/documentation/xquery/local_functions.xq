(:
Documentation
https://docs.basex.org/main/Repository#accessing_modules
:)

module namespace local = 'http://local-module.org';

declare function local:copy-replace($element as element()) as element() {
  if ($element/self::name)
  (: On ajoute des attributs du texte original, non admis en HTML mais utiles:)
  then <a class="name" id="{$element/@id}" type="{$element/@type}" ref="{$element/@ref}" href="table_noms.html{data($element/@ref)}">{data($element)}</a>
  else element {node-name($element)}
               {$element/@*,
                for $child in $element/node()
                return if ($child instance of element())
                       then local:copy-replace($child)
                       else $child
               }
};

declare function local:copy-with-ids($node as node(), $counter as xs:integer, $in-standOff as xs:boolean) as item()+ {
  typeswitch ($node)
    case element() return
      let $is-standOff := local-name($node) = 'standOff'
      let $new-in-standOff := $is-standOff or $in-standOff
      let $atts := for $att in $node/@* return $att
      let $children-results := 
        fold-left($node/node(), ($counter + 1, ()), 
          function($acc, $child) {
            let $current-counter := $acc[1]
            let $copied-siblings := $acc[position() > 1]
            let $child-result := local:copy-with-ids($child, $current-counter, $new-in-standOff)
            let $copied-child := $child-result[1]
            let $next-counter := $child-result[2]
            return ($next-counter, $copied-siblings, $copied-child)
          })
      let $final-counter := $children-results[1]
      let $copied-children := $children-results[position() > 1]
      let $element-with-id := 
        if ($new-in-standOff) then
          element { node-name($node) } { $atts, $copied-children }
        else
          element { node-name($node) } { attribute id { $counter }, $atts, $copied-children }
      return ($element-with-id, $final-counter)
    default return ($node, $counter)
};

