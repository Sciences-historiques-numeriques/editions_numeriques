(:
Documentation
https://docs.basex.org/main/Repository#accessing_modules
:)

module namespace loc = 'http://local-module.org';

declare function loc:copy-replace($element as element()) as element() {
  if ($element/self::name)
  then <a class="name" href="{$element/@ref}">{data($element)}</a>
  else element {node-name($element)}
               {$element/@*,
                for $child in $element/node()
                return if ($child instance of element())
                       then loc:copy-replace($child)
                       else $child
               }
};
