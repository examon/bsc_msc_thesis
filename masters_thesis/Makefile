TO_CLEAN=aux log blg bbl bcf bib~ tex~ out toc dvi tfm 514pk 600pk aux snm nav "run.xml"
THESIS_SOURCE=thesis
TEX_ARGS=--shell-escape #-interaction batchmode

SPECIFICATION=local/zadani/01.pdf
DECLARATION=local/zadani/02.pdf


thesis:
	pdflatex ${TEX_ARGS} ${THESIS_SOURCE}; biber ${THESIS_SOURCE}; pdflatex ${TEX_ARGS} ${THESIS_SOURCE}; pdflatex ${TEX_ARGS} ${THESIS_SOURCE};
	for EXT in $(TO_CLEAN); do \
		echo "Deleting *.$$EXT"; \
		for FILE in *.$$EXT; do \
			rm -f "$$FILE"; \
		done \
	done

insert-spec: ${THESIS_SOURCE}.pdf
	pdftk A=${THESIS_SOURCE}.pdf B=${SPECIFICATION} C=${DECLARATION} cat A1-2 B A2 C A2 A3-end output thesis_print.pdf
