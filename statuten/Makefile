SHELL=bash
TARGET=statuten.pdf
LL=latexmk -pdf
CLEAN=latexmk -C

all: $(TARGET)

pdf: $(TARGET)

.PHONY : clean $(TARGET)

$(TARGET): $(TARGET:%.pdf=%.tex) $(SRC)
	$(LL) $<

clean:
	$(CLEAN)

mupdf:
	mupdf $(TARGET) &

zathura:
	zathura $(TARGET) &

# vim: set tabstop=4 shiftwidth=4 noexpandtab:
