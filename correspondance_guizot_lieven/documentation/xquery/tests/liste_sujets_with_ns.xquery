declare default element namespace "http://www.tei-c.org/ns/1.0;
for $seg in //seg
return <tr><td class="{data($seg/@ana/substring-after(.,'#'))}">{data($seg)}</td></tr>