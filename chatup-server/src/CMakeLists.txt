cmake_minimum_required(VERSION 3.27)

project(ChatUpServer
        VERSION 0.1.0
        DESCRIPTION "A backend messaging server for ChatUp."
        LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Declare external dependencies
include(FetchContent)

FetchContent_Declare(jwt-cpp
  GIT_REPOSITORY git@github.com:Thalhammer/jwt-cpp.git
  GIT_TAG v0.7.0
)
set(ABSL_ENABLE_INSTALL ON)
FetchContent_Declare(gRPC
  GIT_REPOSITORY git@github.com:grpc/grpc.git
  GIT_TAG v1.60.1
)

# Populate CMake variables with contents of external projects
FetchContent_MakeAvailable(gRPC jwt-cpp)

set(CMAKE_CXX_COMPILER /usr/bin/clang++)

# set(CMAKE_PREFIX_PATH ../.cvenv)  # specify virtual environment path

# Create target "ChatUpServer"
add_executable(ChatUpServer main.cpp protobufs/chatup.grpc.pb.cc protobufs/chatup.pb.cc protobufs/user.pb.cc)

# link external libraries to ChatUpServer
target_link_libraries(ChatUpServer grpc++ jwt-cpp::jwt-cpp)

