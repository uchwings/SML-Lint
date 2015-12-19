SMLNJHOME := $(shell sh ./smlnj-home)
SUFFIX := $(shell ${SMLNJHOME}/bin/.arch-n-opsys | sed 's/.*HEAP_SUFFIX=//')
SRC := $(shell find * -name '*.sml' -o -name '*.sig')

build: lint.V test ltest

clean:
	$(RM) lint.${SUFFIX}

test:
	echo 'CM.make "lint.cm"; Lint.parse "top.sml";' | sml

ltest:
	echo 'CM.make "lint.cm"; Lint.parse "lint.sml";' | sml

lint.V: lint.${SUFFIX}

lint.${SUFFIX}: ${SRC}
	ml-build lint.cm Lint.run lint

install: ${LIB}/lint.${SUFFIX}
${LIB}/lint.${SUFFIX}: lint.${SUFFIX}
	cp -av $^ $@
