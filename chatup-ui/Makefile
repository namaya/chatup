

.PHONY: protobufs
protobufs:
	../chatup-server/.dependencies/bin/protoc -I../protos --plugin=bin/protoc-gen-grpc-swift --grpc-swift_opt=Client=true,Server=false --grpc-swift_out=protobufs ../protos/chatup.proto
	../chatup-server/.dependencies/bin/protoc -I../protos --plugin=bin/protoc-gen-swift --swift_opt=Visibility=Public --swift_out=protobufs ../protos/*.proto

