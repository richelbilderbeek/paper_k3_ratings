all: article.pdf

article.pdf: article.tex stats.latex figure_1.png
	pdflatex article.tex

stats.csv: stats.Rmd
	Rscript -e 'rmarkdown::render("stats.Rmd")'

figure_1.png: stats.Rmd
	Rscript -e 'rmarkdown::render("stats.Rmd")'

stats.latex: stats.csv
	csv2latex stats.csv --nohead > stats.latex

stats.Rmd: K3Reviews/README.md

K3Reviews/README.md:
	git clone https://github.com/richelbilderbeek/K3Reviews

