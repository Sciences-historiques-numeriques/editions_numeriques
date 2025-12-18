let $doc := <root>{db:get("letters")/teiCorpus//seg}</root>
let $file-path := '/home/francesco/kDrive/python_notebooks/sciences_historiques_numeriques/editions_numeriques/correspondance_guizot_lieven/docs_transformes/test-write.xml'
return file:write($file-path, $doc)