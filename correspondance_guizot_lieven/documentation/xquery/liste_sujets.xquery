for $seg in //seg
return <tr><td class="{data($seg/@ana/substring-after(.,'#'))}">{data($seg)}</td></tr>