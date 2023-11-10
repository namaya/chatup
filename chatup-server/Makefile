
.PHONY: build
build:
	cmake -DCMAKE_CXX_COMPILER=clang++ -S src -B build
	cd build && make

.PHONY: protobufs
protobufs:
	./.dependencies/bin/protoc -I../protos --grpc_out=src/protobufs --plugin=protoc-gen-grpc=./.dependencies/bin/grpc_cpp_plugin ../protos/chatup.proto
	./.dependencies/bin/protoc -I../protos -I./.dependencies/include --cpp_out=src/protobufs ../protos/*.proto
