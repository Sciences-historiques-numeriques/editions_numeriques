let $doc := db:get("letters")
let $doc-corpus := $doc/teiCorpus
let $interpGroup := $doc-corpus/standOff/interpGrp

let $file-path := '/home/francesco/kDrive/python_notebooks/sciences_historiques_numeriques/editions_numeriques/docs/table_matieres.html'

    

let $output := 
<html xml:lang="en" lang="en">
<link rel="stylesheet" href="corresp_guizot_lieven/mystyle.css"  type="text/css" />
<head>
<title>Guizot-Lieven</title>
</head>
<body>
<h1>
                       Table des mantière de la correspondance de<br />
                       François Guizot et Dorothée de Lieven<br />
                       (1836-1856)
    </h1>
    <br />
    <br />
   <div>
    <h3>Segments annotés</h3>
    {
      for $interp in $interpGroup
      return <h4>{$interp}</h4>

   }
   
     
</div>
</body>
</html>

return file:write($file-path, $output)