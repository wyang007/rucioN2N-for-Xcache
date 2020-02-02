all: XrdName2NameDCP4RUCIO.so

# make sure xrootd-devel, xrootd-server-devel and xrootd-client-devel rpms are installed for
# the needed xrootd header files.

ifeq ($(strip $(XRD_INC)),)
    XRD_INC=/usr/include/xrootd
endif

ifeq ($(strip $(XRD_LIB)),)
    XRD_LIB=/usr/lib64
endif

FLAGS=-D_REENTRANT -D_THREAD_SAFE -Wno-deprecated -std=c++0x 

HEADERS=rucioGetMetaLink.hh pfn2cache.hh cacheQuery.hh
SOURCES=XrdOucName2NameDCP4RUCIO.cc XrdOssStatInfoDCP.cc rucioGetMetaLink.cc pfn2cache.cc cacheQuery.cc
OBJECTS=XrdOucName2NameDCP4RUCIO.o XrdOssStatInfoDCP.o rucioGetMetaLink.o pfn2cache.o cacheQuery.o

DEBUG=-g

XrdName2NameDCP4RUCIO.so: $(OBJECTS) Makefile
	g++ ${DEBUG} -shared -fPIC -o $@ $(OBJECTS) -L${XRD_LIB} -L${XRD_LIB}/XrdCl -ldl -lssl -lcurl -lXrdCl -lXrdPfc-5 -lXrdPosix -lstdc++

XrdOucName2NameDCP4RUCIO.o: XrdOucName2NameDCP4RUCIO.cc ${HEADERS} Makefile
	g++ ${DEBUG} ${FLAGS} -fPIC -I ${XRD_INC} -I ${XRD_LIB} -c -o $@ $<

XrdOssStatInfoDCP.o: XrdOssStatInfoDCP.cc ${HEADERS} Makefile
	g++ ${DEBUG} ${FLAGS} -fPIC -I ${XRD_INC} -I ${XRD_LIB} -c -o $@ $<

rucioGetMetaLink.o: rucioGetMetaLink.cc ${HEADERS} Makefile
	g++ ${DEBUG} ${FLAGS} -fPIC -I ${XRD_INC} -I ${XRD_LIB} -c -o $@ $<

pfn2cache.o: pfn2cache.cc ${HEADERS} Makefile
	g++ ${DEBUG} ${FLAGS} -fPIC -I ${XRD_INC} -I ${XRD_LIB} -c -o $@ $<

cacheQuery.o: cacheQuery.cc ${HEADERS} Makefile
	g++ ${DEBUG} ${FLAGS} -fPIC -I ${XRD_INC} -I ${XRD_LIB} -c -o $@ $<

#checkPFCcinfo.o: checkPFCcinfo.cc ${HEADERS} Makefile
#	g++ ${DEBUG} ${FLAGS} -fPIC -I ${XRD_INC} -I ${XRD_LIB} -c -o $@ $<

clean:
	rm -vf *.{o,so}


