FILENAME = surviving_large_unfamiliar_codebases
all:
	pandoc -t dzslides -s $(FILENAME).md -o $(FILENAME).html
ss:
	pandoc -t s5 -s $(FILENAME).md -o $(FILENAME).html
reveal:
	pandoc -t revealjs -s $(FILENAME).md -o $(FILENAME).html
watch:
	watch-exec $(FILENAME).md make reveal

