(: Ce fichier crée la table des segments mentionnés, 
tout en les regroupant par type:)

let $file-path := '/home/francesco/kDrive/python_notebooks/sciences_historiques_numeriques/editions_numeriques/docs/corresp_guizot_lieven/table_matieres.html'

let $doc-corpus := db:get('letters',"letters")/teiCorpus
let $doc-html := db:get('letters', 'letters_html.xml')
let $interpGroup := $doc-corpus/standOff/interpGrp


let $output := 
<html xml:lang="en" lang="en">
<link rel="stylesheet" href="edition.css"  type="text/css" />
<head>
<title>Guizot-Lieven</title>
</head>
<body>
<h1>
    Table des matières de la correspondance de<br />
    François Guizot et Dorothée de Lieven<br />
    (1836-1856)
    </h1>
    <br />
    <br />
     <p style="font-size: small;"><a href="../index.html">Retour à l'accueil</a></p>
    <div>
    <h2>Segments annotés</h2>    
    {      
        for $interp in $interpGroup/interp    
        let $interp_id := $interp/@id
          
        return <div><h3>{data($interp)}</h3> 
        
        <ul>{
            for $seg in $doc-html//seg        
            let $seg_ana := $seg/@ana
            let $seg_id := $seg/@id
            (: récupère la date de chaque segment en remontant dans l'arbre:)
            let $root-div := $seg/ancestor::div[@class='root']
            let $seg-date := $root-div/@letter-date
            
            order by $seg-date
            
                             
            where $interp_id = substring-after($seg_ana, '#')
          return <li><a href="letters.html#{data($seg_id)}">{data($seg)}</a> ({data($seg-date)})</li>
          }</ul>
        </div>
            
    }
              
        
     
</div>
</body>
</html>

return file:write($file-path, $output)