
#include "protobufs/chatup.grpc.pb.h"
#include <grpcpp/server_builder.h>
#include <iostream>
#include <string>

std::vector<Chatroom> chatrooms{};

class ChatUpServerImpl final : public ChatUpServer::Service {

public:
  ChatUpServerImpl() {}

  grpc::Status ListChatrooms(grpc::ServerContext *context,
                             const google::protobuf::Empty *request,
                             ChatroomList *response) {
    for (const auto &chatroom : chatrooms) {
      response->add_chatrooms()->CopyFrom(chatroom);
    }
    return grpc::Status::OK;
  }
  grpc::Status CreateChatroom(grpc::ServerContext *context,
                              const Chatroom *request, Chatroom *response) {
    // copy request
    Chatroom newChatroom = *request;

    // add chatroom to the list of chatrooms
    chatrooms.push_back(newChatroom);

    return grpc::Status::OK;
  }
  grpc::Status Join(grpc::ServerContext *context, const JoinRequest *request,
                    ChatMessage *response) {
    std::cout << "Received join request\n";
    return grpc::Status::OK;
  }
  grpc::Status Leave(grpc::ServerContext *context, const ::JoinRequest *request,
                     google::protobuf::Empty *response) {
    std::cout << "Received leave request\n";
    return grpc::Status::OK;
  }
  grpc::Status SendMessage(grpc::ServerContext *context,
                           const ::ChatMessage *request,
                           google::protobuf::Empty *response) {
    std::cout << "Recieved send message request\n";
    return grpc::Status::OK;
  }
};

int main() {
  std::string server_address{"0.0.0.0:50051"};

  // Add some mock data
  auto nick = User{};
  auto katelynn = User{};

  nick.set_id("1");
  nick.set_name("Nick");
  katelynn.set_id("2");
  katelynn.set_name("Katelynn");

  for (int i = 0; i < 10; i++) {
    auto chatroom = Chatroom{};

    chatroom.set_id(std::to_string(i));
    chatroom.set_name("Chatroom " + std::to_string(i));

    // add members
    auto user1 = chatroom.add_members();
    user1->CopyFrom(katelynn);

    auto user2 = chatroom.add_members();
    user2->CopyFrom(nick);

    chatrooms.push_back(chatroom);
  }

  std::cout << "Chatrooms: " << chatrooms.size() << "\n";

  ChatUpServerImpl grpcService{};

  grpc::ServerBuilder builder{};

  builder.AddListeningPort(server_address, grpc::InsecureServerCredentials());
  builder.RegisterService(&grpcService);

  std::unique_ptr<grpc::Server> server{builder.BuildAndStart()};

  std::cout << "Server listening on " << server_address << "\n";

  server->Wait();
}
