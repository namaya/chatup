
.PHONY: build
build:
	cmake -S src -B build
	cmake --build build

.PHONY: protobufs
protobufs:
	./.cvenv/bin/protoc -I../protos --grpc_out=src/protobufs --plugin=protoc-gen-grpc=./.cvenv/bin/grpc_cpp_plugin ../protos/chatup.proto
	./.cvenv/bin/protoc -I../protos -I./.cvenv/include --cpp_out=src/protobufs ../protos/*.proto
