cmake_minimum_required(VERSION 3.16)
project(botapp)

set(CMAKE_CXX_STANDARD 20)

# Зависимости
find_package(OpenSSL REQUIRED)
find_package(CURL REQUIRED)
find_package(nlohmann_json REQUIRED)
find_package(Threads REQUIRED)

add_executable(botapp main.cpp)

target_link_libraries(botapp
    PRIVATE
    TgBot
    OpenSSL::SSL
    OpenSSL::Crypto
    CURL::libcurl
    nlohmann_json::nlohmann_json
    Threads::Threads
)
