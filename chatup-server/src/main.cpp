
#include "protobufs/chatup.grpc.pb.h"
#include <grpcpp/grpcpp.h>
#include <iostream>

class ChatUpServerImpl final : public ChatUpServer::Service {

    ::grpc::Status ListChatrooms(::grpc::ServerContext *context,
                               const ::google::protobuf::Empty *request,
                               ::Chatroom *response) {
    return ::grpc::Status::OK;
  }
  ::grpc::Status CreateChatroom(::grpc::ServerContext *context,
                                const ::Chatroom *request,
                                ::Chatroom *response) {
    return ::grpc::Status::OK;
  }
  ::grpc::Status Join(::grpc::ServerContext *context,
                      const ::JoinRequest *request, ::ChatMessage *response) {
    return ::grpc::Status::OK;
  }
  ::grpc::Status Leave(::grpc::ServerContext *context,
                       const ::JoinRequest *request,
                       ::google::protobuf::Empty *response) {
    return ::grpc::Status::OK;
  }
  ::grpc::Status SendMessage(::grpc::ServerContext *context,
                             const ::ChatMessage *request,
                             ::google::protobuf::Empty *response) {
    return ::grpc::Status::OK;
  }
};

int main() { std::cout << "Hello, world!\n"; }