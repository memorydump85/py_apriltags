CC = gcc
LD = gcc

CFLAGS = -std=gnu99 -g -O3 -pthread \
         -fPIC -fwrapv -fno-strict-aliasing \
         -Wall -Wno-unused-parameter -Wno-unused-function
CFLAGS_APRILTAGS = -Icommon
CFLAGS_PYTHON = `pkg-config --cflags python3`
CFLAGS_NUMPY = -I`python3 -c "import numpy; print(numpy.get_include())"`

LDFLAGS = -lpthread -lm
LDFLAGS_PYTHON = `pkg-config --libs python3`
OBJFILES = tag36h11.o apriltag.o tag25h9.o apriltag_quad_thresh.o common/time_util.o \
           common/pnm.o common/matd.o common/unionfind.o common/svd22.o common/zhash.o \
           common/getopt.o common/string_util.o common/workerpool.o common/zmaxheap.o \
           common/image_u32.o common/homography.o common/image_f32.o common/image_u8.o \
           common/zarray.o tag25h7.o tag16h5.o tag36h10.o tag36artoolkit.o \
           g2d.o


all: apriltag_wrap.so

apriltag_wrap.so: apriltag_wrap.o $(OBJFILES)
	@echo "   $@"
	@$(LD) -shared -o $@ *.o common/*.o

apriltag_wrap.c: apriltag_wrap.pyx
	@echo "   $@"
	@cython3 -3 -o $@ -a apriltag_wrap.pyx

%.o: %.c
	@echo "   $@"
	@$(CC) -o $@ -c $< $(CFLAGS) $(CFLAGS_NUMPY) $(CFLAGS_PYTHON) $(CFLAGS_APRILTAGS)

.PHONY: clean
clean:
	@rm -rf *.html *.o common/*.o *.so apriltag_wrap.c apriltag_demo
