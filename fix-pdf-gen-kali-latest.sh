#!/bin/bash

PDF=`find /var/lib/gvm/data-objects -type f -iname '*pdf*.xml' -print | head -1`

grep 'file name="latex.xsl' $PDF | sed  's#<file name="latex.xsl">##' | sed "s#</file>##" | sed 's/^[ \t]*//' |base64 -d| sed 's#\\usepackage\[utf8x\].*##g' |base64 > /tmp/pdf-fixed
sed -i 's/^[ \t]*//' /tmp/pdf-fixed

# fixed contents
sed  '/<file name=\"latex.xsl\">.*<\/file>/d' $PDF > /tmp/removed-entries
sed -i "s#</report_format>##g" /tmp/removed-entries
echo '<file name="latex.xsl">' >> /tmp/removed-entries
cat /tmp/pdf-fixed >> /tmp/removed-entries
echo '</file></report_format>' >> /tmp/removed-entries

#cp /tmp/removed-entries  /var/lib/gvm/data-objects/gvmd/20.08/report_formats/pdf-c402cc3e-b531-11e1-9163-406186ea4fc5.xml
#cp /tmp/removed-entries /var/lib/gvm/data-objects/gvmd/21.04/report_formats/pdf-c402cc3e-b531-11e1-9163-406186ea4fc5.xml
#cp /tmp/removed-entries /var/lib/gvm/data-objects/gvmd/22.04/report-formats/pdf-c402cc3e-b531-11e1-9163-406186ea4fc5.xml

find /var/lib/gvm/data-objects -type f -iname '*pdf*.xml' -print | xargs -n1 printf "cp -v /tmp/removed-entries %s\n"  | bash
