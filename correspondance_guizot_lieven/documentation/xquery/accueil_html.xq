let $doc := db:get("letters")
let $doc-corpus := $doc/teiCorpus
let $general-title := $doc-corpus/teiHeader/fileDesc/titleStmt/title/text()
let $file-path := '/home/francesco/kDrive/python_notebooks/sciences_historiques_numeriques/editions_numeriques/correspondance_guizot_lieven/docs_transformes/accueil.html'

let $output := <html>
<link rel="stylesheet" href="mystyle.css"/>
<head>
<title>Guizot-Lieven</title>
</head>
<body>
<h2>{$general-title}</h2>
<br/>
<h3>Documents de l'édition</h3>
<ul> {
  for $doc-tei in $doc-corpus/TEI
  let $id := $doc-tei/@id
  let $letter-title := $doc-tei/teiHeader/fileDesc/titleStmt/title/text()
  
  return <li><a href='letters.xml#{data($id)}'>{$letter-title}</a></li>
 }
</ul>
</body>
</html>

return file:write($file-path, $output)