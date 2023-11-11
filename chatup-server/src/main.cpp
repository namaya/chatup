
#include "protobufs/chatup.grpc.pb.h"
#include <grpcpp/server_builder.h>
#include <iostream>

class ChatUpServerImpl final : public ChatUpServer::Service {

  grpc::Status ListChatrooms(grpc::ServerContext *context,
                             const google::protobuf::Empty *request,
                             Chatroom *response) {
    return grpc::Status::OK;
  }
  grpc::Status CreateChatroom(grpc::ServerContext *context,
                              const Chatroom *request, Chatroom *response) {
    return grpc::Status::OK;
  }
  grpc::Status Join(grpc::ServerContext *context, const JoinRequest *request,
                    ChatMessage *response) {
    return grpc::Status::OK;
  }
  grpc::Status Leave(grpc::ServerContext *context, const ::JoinRequest *request,
                     google::protobuf::Empty *response) {
    return grpc::Status::OK;
  }
  grpc::Status SendMessage(grpc::ServerContext *context,
                           const ::ChatMessage *request,
                           google::protobuf::Empty *response) {
    return grpc::Status::OK;
  }
};

int main() {
  std::string server_address{"0.0.0.0:50051"};

  ChatUpServerImpl grpcService{};

  grpc::ServerBuilder builder{};

  builder.AddListeningPort(server_address, grpc::InsecureServerCredentials());
  builder.RegisterService(&grpcService);

  std::unique_ptr<grpc::Server> server{builder.BuildAndStart()};

  std::cout << "Server listening on " << server_address << "\n";

  server->Wait();
}
