import module namespace local = 'http://local-module.org' at "./local_functions.xq";

let $db := db:get('letters', 'letters')

let $edition-title := $db/teiCorpus/teiHeader/fileDesc/titleStmt/title
let $editeur := $db/teiCorpus/teiHeader/fileDesc/titleStmt/respStmt

let $file-path := '/home/francesco/kDrive/python_notebooks/sciences_historiques_numeriques/editions_numeriques/docs/corresp_guizot_lieven/letters.html'
(: the [1] at the end eliminates the final counter output, 
gets juste the XML :)
let $doc-with-id  := local:copy-with-ids($db/*, 1, false())[1]
let $doc := local:copy-replace($doc-with-id)





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
    <br/>
    <p>Source et édition originale: <a href="https://eman-archives.org/Guizot-Lieven/bienvenue-sur-le-site-guizot-pistolier"
                style="font-style: italic;">François Guizot épistolier</a>.</p>
    <p style="font-size: small;"><a href="../index.html">Retour à l'accueil</a></p>
    <br />

    {      
        for $TEI in $doc/TEI
        
        let $title := $TEI/teiHeader/fileDesc/titleStmt/title
        let $text := $TEI/text
        let $date := $TEI/teiHeader/profileDesc/correspDesc/correspAction[@type = "sent"]/date/@when
        
        order by $date  

        (: letter_date est un attribut non HTML et ad hoc pour conserver la date de la lettre au format ISO :)
        return <div class="root" letter-date="{$date}">
        
        <h2 id="{$TEI/@id}" >{data($title)}</h2>
        {$text}
        </div>
        
      }
         
</body>
</html>


return ( file:write($file-path, $output), db:put('letters', $output, 'letters_html.xml')  )
(: return $output :)