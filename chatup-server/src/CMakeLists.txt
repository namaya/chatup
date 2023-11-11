cmake_minimum_required(VERSION 3.27)

project(ChatUpServer
        VERSION 0.1.0
        DESCRIPTION "A backend messaging server for ChatUp."
        LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_PREFIX_PATH ../.dependencies)

# specify directory of header files
include_directories(../.dependencies/include)

# specify directory of library files
link_directories(../.dependencies/lib)

find_package(protobuf CONFIG REQUIRED)
find_package(gRPC CONFIG REQUIRED)

add_executable(ChatUpServer main.cpp protobufs/chatup.grpc.pb.cc protobufs/chatup.pb.cc protobufs/user.pb.cc)
# add_executable(ChatUpServer main.cpp)

# link a specific library to the executable
target_link_libraries(ChatUpServer gRPC::grpc++)
