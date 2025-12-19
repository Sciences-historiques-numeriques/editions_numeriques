let $file-path := '/home/francesco/kDrive/python_notebooks/sciences_historiques_numeriques/editions_numeriques/docs/corresp_guizot_lieven/letters.html'

let $doc := db:get("letters")
let $doc-corpus := $doc/teiCorpus
let $edition-title := $doc-corpus/teiHeader/fileDesc/titleStmt/title
let $editeur := $doc-corpus/teiHeader/fileDesc/titleStmt/respStmt

let $output := 
<html xml:lang="en" lang="en">
<link rel="stylesheet" href="edition.css"  type="text/css" />
<head>
      <title>Lettres Guizot-Lieven</title>
</head>
<body>
<h1> {data($edition-title)}
    </h1>    
    <br />
    <p class="editeur">Éditorialisation par <a href="{$editeur/name/@ref}" target="_blank">{data($editeur/name)}</a></p>
    <p>Source et édition originale: <a href="https://eman-archives.org/Guizot-Lieven/bienvenue-sur-le-site-guizot-pistolier"
                style="font-style: italic;">François Guizot épistolier</a>.</p>
    <br />

    {      
        for $TEI in $doc-corpus/TEI
        
        let $title := $TEI/teiHeader/fileDesc/titleStmt/title
        let $text := $TEI/text
        let $date := $TEI/teiHeader/profileDesc/correspDesc/correspAction[@type = "sent"]/date/@when
        
        order by $date  
        return <div>
        
        <h2 id="{$TEI/@id}">{data($title)}</h2>
        {$text}
        </div>
        
      }
         
</body>
</html>

return file:write($file-path, $output)