TITLEFILE=titleidx.sbx
AUTHORFILE=authidx.sbx
SONGDIR=pisnicky

all: clean zpevnik.pdf danovo.pdf zluty.pdf

danovo: clean danovo.pdf

danovo.pdf: danovo.tex
	latex $<
	latex $<
	pdflatex $<
danovo.tex:
	make clean
	python3 ./akordy/maketoc.py danovo ${TITLEFILE} ${AUTHORFILE}
	python3 ./akordy/merge.py danovo $@

zluty: clean zluty.pdf

zluty.pdf: zluty.tex
	latex $<
	latex $<
	pdflatex $<
zluty.tex:
	make clean
	python3 ./akordy/maketoc.py zluty ${TITLEFILE} ${AUTHORFILE}
	python3 ./akordy/merge.py zluty $@

zpevnik.pdf: zpevnik.tex $(TITLEFILE) $(AUTHORFILE)
	latex $<
	latex $<
	pdflatex $<

$(TITLEFILE) $(AUTHORFILE)&:${SONGDIR}
	python3 ./akordy/maketoc.py ${SONGDIR} $(TITLEFILE) $(AUTHORFILE)

zpevnik.tex: pisnicky
	rm -f allSongs.tmp
	cat ${SONGDIR}/* > allSongs.tmp
	python3 ./akordy/merge.py pisnicky $@

clean:
	rm -f *.pdf *.out *aux *bbl *blg *log *toc *.ptb *.tod *.fls *.fdb_latexmk *.lof *.sbx *.dvi *.tmp *.sxc *.sxd *.tex
