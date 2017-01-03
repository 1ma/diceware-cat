#! /usr/bin/env bash
#
#   Converteix una llista Diceware a format html a 6 columnas i posa els salts
#   necessaris perquè s'imprimeixi correctament a 36 fulles de 36 línies.
#
#   El fitxer resultant també és pot obrir perfectament amb Excel i LibreOffice,
#   tot i que faltaria afegir alguna capçalera per a que LibreOffice l'obri
#   sense preguntar res.
#
function html {
    title="$@"
    cat <<EOF
<!DOCTYPE html>
<html lang="ca">
<head>
  <title>$title</title>
  <meta charset="UTF-8">
  <style type="text/css">
  <!--
th {
    font-family: monospace;
    font-weight: normal;
    color: red;
}
@media print {
    .page {
        page-break-after: always;
    }
}
  -->
  </style>
</head>
<body>
  <table>
    <colgroup span=2>
    <colgroup span=2>
    <colgroup span=2>
    <colgroup span=2>
    <colgroup span=2>
    <colgroup span=2>
    <tbody>
EOF
    awk '
# ignorar línies que no interessen
!/^[1-6][1-6][1-6][1-6][1-6] / { next }

# compta línies i mira si cal partir la pàgina
    { ++n; page = n > 1 && n % (6 * 6 * 6) == 1 }

/^....1/ && page  { print "      <tr class=\"page\">" }
/^....1/ && !page { print "      <tr>" }
    { print "        <th scope=\"colgroup\">" $1 "</th><td>" $2 "</td>" }
/^....6/ { print "      </tr>" }
'
    cat <<EOF
    </tbody>
  </table>
</body>
</html>"
EOF
}

html "Llista Diceware sense accents" < cat-wordlist-ascii.txt > cat-wordlist-ascii.html
html "Llista Diceware"               < cat-wordlist-utf8.txt  > cat-wordlist-utf8.html
