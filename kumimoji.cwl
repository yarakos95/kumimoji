# kumimoji package
#

#include:expl3
#include:bxghost

#keyvals:\usepackage/kumimoji#c
uplatex
font
bxghost
#endkeyvals

\kumimoji{組文字}
\kumimoji*{組文字}
#keyvals:\kumimoji,\kumimoji*/kumimoji#c
font
color
width
scale-top
scale-bottom
scale
top=#center,left,right
bottom=#center,left,right
#endkeyvals
