# Linux (default)
EXE = world
CFLAGS = -std=gnu99
LDFLAGS = -lGL -lGLU -lglut -lm

# Windows (cygwin)
ifeq "$(OS)" "Windows_NT"
	EXE = world.exe
	LDFLAGS = -lopengl32 -lglu32 -lglut32
endif

# OS X, OSTYPE not being declared
ifndef OSTYPE
  OSTYPE = $(shell uname -s|awk '{print tolower($$0)}')
  #export OSTYPE
endif
ifeq ($(OSTYPE),darwin)
	LDFLAGS = -framework Carbon -framework OpenGL -framework GLUT  -Wno-deprecated
endif

$(EXE): example_simple.c
	@mkdir -p bin
	gcc -o bin/$@ $< $(CFLAGS) $(LDFLAGS)

shaders: example_shaders.c
	@mkdir -p bin
	gcc -o bin/world_shaders $< $(CFLAGS) $(LDFLAGS)

run:
	./bin/$(EXE) $(ARGS)

run_shaders:
	./bin/world_shaders $(ARGS)
