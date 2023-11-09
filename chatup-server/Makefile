
.PHONY: build
build:
	cmake -DCMAKE_CXX_COMPILER=clang++ -S src -B build
	cd build && make

.PHONY: protobufs
protobufs:
	protoc -I=src/protobufs --cpp_out=src/protobufs src/protobufs/*.proto
