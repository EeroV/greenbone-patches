#!/bin/bash

grep 'file name="latex.xsl' /var/lib/gvm/data-objects/gvmd/2*/report-formats/pdf-c402cc3e-b531-11e1-9163-406186ea4fc5.xml | sed  's#<file name="latex.xsl">##' | sed "s#</file>##" | sed 's/^[ \t]*//' |base64 -d| sed 's#\\usepackage\[utf8x\].*##g' |base64 > /tmp/pdf-fixed
sed -r 's/\s+//g'  /tmp/pdf-fixed

# fixed contents
sed  '/<file name=\"latex.xsl\">.*<\/file>/d' /var/lib/gvm/data-objects/gvmd/2*/report-formats/pdf-c402cc3e-b531-11e1-9163-406186ea4fc5.xml > /tmp/removed-entries
sed -i "s#</report_format>##g" /tmp/removed-entries
echo '<file name="latex.xsl">' >> /tmp/removed-entries
cat /tmp/pdf-fixed >> /tmp/removed-entries
echo '</file></report_format>' >> /tmp/removed-entries
cp /tmp/removed-entries /var/lib/gvm/data-objects/gvmd/2*/report-formats/pdf-c402cc3e-b531-11e1-9163-406186ea4fc5.xml

#sed -i '' -e '/<meta>/,/<\/meta>/d' my-file.xml
#sed -i '' -e '/<file name="latex.xsl\">/,/<\/file>/d' pdf.xml

#<file name="report_format.xml">
