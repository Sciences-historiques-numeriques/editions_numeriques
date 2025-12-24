(: Ce fichier crée la table des segments mentionnés, 
tout en les regroupant par type:)

let $file-path := '/home/francesco/kDrive/python_notebooks/sciences_historiques_numeriques/editions_numeriques/docs/corresp_guizot_lieven/table_noms.html'

let $doc-corpus := db:get('letters',"letters")/teiCorpus
let $doc-html := db:get('letters', 'letters_html.xml')
let $listPerson := $doc-corpus/standOff/listPerson
let $listPlace := $doc-corpus/standOff/listPlace


let $output := 
<html xml:lang="en" lang="en">
<link rel="stylesheet" href="edition.css"  type="text/css" />
<head>
<title>Guizot-Lieven</title>
</head>
<body>
<h1>
    Table des noms de la correspondance de<br />
    François Guizot et Dorothée de Lieven<br />
    (1836-1856)
    </h1>
    <br />
    <br />
   <div>
    <h2>Personnes</h2>    
    {      
        for $person in $listPerson/person    
        let $person_id := $person/@id
          
        return <div><h3>{data($person/p/name)}</h3> 
        
        <ul>{
            for $person in $doc-html//name[@type='person']        
            let $person_ref := $person/@ref
            let $seg_id := $person/@id
            (: récupère la date de chaque segment en remontant dans l'arbre:)
            let $root-div := $person/ancestor::div[@class='root']
            let $seg-date := $root-div/@letter-date
            
            order by $seg-date
            
                             
            where $person_id = substring-after($person_ref, '#')
          return <li><a href="letters.html#{data($seg_id)}">{data($person), data($person_ref)}</a> ({data($seg-date)})</li>
          }</ul>
        </div>
            
    }
              
        
     
</div>
</body>
</html>

return ($output, file:write($file-path, $output))