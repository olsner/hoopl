<./latex.mk
<./spell.mk
<./bbl.$USER.mk

#LASTPAGE=12  # used this for submission
LASTPAGE=   

TGT=dfopt

all:V: $TGT.pdf $TGT.ps supplement.pdf
bib:V: $TGT.bbl
dvi:V: $TGT.dvi
bbl:V: bib

tag:VQ: $TGT.tex
	tag=`$HOME/bin/md5words $prereq | tr -d "'" | tr -cs a-zA-Z0-9 - | sed s/-*$//`
	echo git tag $tag
	git tag $tag

dfopt.dvi: dfopt.bbl code.sty timestamp.tex

$TGT.pdf: $TGT.dvi
	dvips -Ppdf -o"|ps2pdf - $target" -pp 1-$LASTPAGE $prereq

supplement.pdf: $TGT.dvi
	dvips -Ppdf -o "|ps2pdf - $target" -pp 13- $prereq

timestamp.tex: $TGT.tex
	date=`stat -c "%y" $prereq`
	signature=""
	if [ -x $HOME/bin/md5words ]; then
          signature=" [MD5: \\mbox{`md5words $prereq`}]"
	fi
	date -d "$date" "+\def\mdfivestamp{\\rlap{\\textbf{\\uppercase{%A} %l:%M %p$signature}}}" > $target


