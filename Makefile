all: article.pdf

article.pdf: article.tex
	pdflatex article.tex

