let $doc := db:get("letters")
let $doc-corpus := $doc/teiCorpus
(:let $file-path := '/home/francesco/kDrive/python_notebooks/sciences_historiques_numeriques/editions_numeriques/correspondance_guizot_lieven/docs_transformes/index.html':)

let $file-path := '/home/francesco/kDrive/python_notebooks/sciences_historiques_numeriques/editions_numeriques/docs/index.html'


let $output := <html>
<link rel="stylesheet" href="corresp_guizot_lieven/edition.css"/>
<head>
<title>Guizot-Lieven</title>
</head>
<body>
<h1>Correspondance entre
        <br />
        François Guizot et Dorothée de
        Lieven
        <br />
        (1836-1856)
    </h1>
    <br />
    <br />

    <div>
        <h4>Présentation</h4>
        <p>
            Cette édition présente une sélection parmi les 2900 lettres échangées entre l'homme d'État français
            François Guizot (1787-1874) et la princesse de Lieven, Dorothée van Benckendorff (1785-1857), une
            personnalité éminente du monde diplomatique européen au cours de la première moitié du XIXe siècle.
        </p>
        <p>
            L'<a href="https://eman-archives.org/Guizot-Lieven/collections/show/99">édition des 2900 lettres</a> fait
            partie du site <a href="https://eman-archives.org/Guizot-Lieven/bienvenue-sur-le-site-guizot-pistolier"
                style="font-style: italic;">François Guizot épistolier</a>.</p>
    </div>
    <br/>
    <br/>
    <div>
    <h3>Documents de l'édition</h3>
    <ul> {
      for $doc-tei in $doc-corpus/TEI
      let $id := $doc-tei/@id
      let $doc-date := $doc-tei/teiHeader/profileDesc/correspDesc/correspAction[@type = "sent"]/date
      let $letter-title := $doc-tei/teiHeader/fileDesc/titleStmt/title/text()
      (: tri par ordre de edate même si les lettres étaient dans un autre ordre:)
      order by $doc-date/@when
      
      return <li><a href='corresp_guizot_lieven/letters.html#{data($id)}'>{$letter-title}</a></li>
     }
    </ul>
</div>
<div>
<h3>Index
</h3>
<ul>
<li>Table des noms</li>
<li><a href="table_matieres.html">Table des matières</a></li></ul></div>
</body>
</html>

return file:write($file-path, $output)