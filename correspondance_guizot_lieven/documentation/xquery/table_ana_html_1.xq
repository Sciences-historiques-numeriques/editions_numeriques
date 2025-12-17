let $file-path := '/home/francesco/kDrive/python_notebooks/sciences_historiques_numeriques/editions_numeriques/docs/table_matieres.html'

let $doc := db:get("letters")
let $doc-corpus := $doc/teiCorpus
let $interpGroup := $doc-corpus/standOff/interpGrp


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
    <h2>Segments annotés</h2>    
    {      
        for $interp in $interpGroup/interp    
        let $interp_id := $interp/@id
          
        return <div><h3>{data($interp)}</h3> 
        
        <ul>{
            for $seg in $doc-corpus/TEI//seg        
            let $seg_ana := $seg/@ana
            let $seg_id := $seg/@id
            where $interp_id = substring-after($seg_ana, '#')
          return <li><a href="corresp_guizot_lieven/letters_ed.xml#{data($seg_id)}">{data($seg)}</a></li>
          }</ul>
        </div>
            
    }
              
        
     
</div>
</body>
</html>

return file:write($file-path, $output)