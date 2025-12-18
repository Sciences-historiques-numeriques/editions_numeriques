(: Fichier qui expérimente la transformation de TEI vers HTML  :)
<html>
<head>
<title>Page Title</title>
</head>
<body>
<table>
{
let $doc := db:get("letters")
for $tei-doc in $doc/teiCorpus/TEI
let $iso-date := $tei-doc//correspAction[@type="sent"]/date/@when
(:return <tr><td>{data($iso-date)}</td></tr>:)
return 
  for $seg in $tei-doc//seg
  return <tr><td>{data($iso-date)}</td><td class="{data($seg/@ana/substring-after(.,'#'))}">{data($seg)}</td></tr>
}
</table>
</body>
</html>