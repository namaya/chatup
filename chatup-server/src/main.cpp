
#include <fstream>
#include <iostream>
#include <string>

#include "protobufs/chatup.grpc.pb.h"
#include <grpcpp/server_builder.h>

std::vector<Chatroom> chatrooms{};

class ChatroomRepository {
private:
  std::vector<Chatroom> chatrooms{};

public:
  ChatroomRepository() {}

  std::vector<Chatroom> listChatrooms(std::string userId) { return chatrooms; }

  void createChatroom(Chatroom chatroom) { chatrooms.push_back(chatroom); }
};

class ChatUpServerImpl final : public ChatUpServer::Service {

public:
  ChatUpServerImpl() {}

  grpc::Status ListChatrooms(grpc::ServerContext *context,
                             const google::protobuf::Empty *request,
                             ChatroomList *response) {

    auto metadata = context->client_metadata();

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

std::string read_file(const std::string &path) {
  std::ifstream file{path};

  if (!file) {
    std::cerr << "Couldn't open file at '" << path << "'\n";
    return ""; // TODO: throw exception
  }

  file.seekg(0, std::ios_base::end);
  const auto file_length = file.tellg();
  file.seekg(0, std::ios_base::beg);

  char *buffer = new char[file_length];

  file.read(buffer, file_length);

  file.close();

  return std::string{buffer, (size_t)file_length};
}

int main() {
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
  std::string server_address{"0.0.0.0:50051"};

  // Configure SSL
  std::string server_public_cert = read_file("server.crt");
  std::string server_private_key = read_file("server.key");

  grpc::SslServerCredentialsOptions::PemKeyCertPair key_cert_pair;
  key_cert_pair.private_key = server_private_key;
  key_cert_pair.cert_chain = server_public_cert;

  grpc::SslServerCredentialsOptions ssl_opts;
  ssl_opts.pem_root_certs = "";
  ssl_opts.pem_key_cert_pairs.push_back(key_cert_pair);

  builder.AddListeningPort(server_address,
                           grpc::SslServerCredentials(ssl_opts));
  builder.RegisterService(&grpcService);

  std::unique_ptr<grpc::Server> server{builder.BuildAndStart()};

  std::cout << "Server listening on " << server_address << "\n";

  server->Wait();
}
