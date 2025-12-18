let $doc := db:get("letters_xmlid", "doc_with_xmlid")
return $doc/teiCorpus/TEI/teiHeader/fileDesc/titleStmt/title
