cmake_minimum_required(VERSION 3.15)
project(rsa-cryptanalysis)

find_package(MPI REQUIRED)

set(CMAKE_CXX_STANDARD 17)
set(SOURCE_FILES main.cpp rsa_mpi.h)

if(MPI_FOUND)
    SET(CMAKE_CXX_COMPILER mpicxx)
    set(CMAKE_CXX_COMPILE_FLAGS ${CMAKE_CXX_COMPILE_FLAGS} ${MPI_COMPILE_FLAGS})
    set(CMAKE_CXX_LINK_FLAGS ${CMAKE_CXX_LINK_FLAGS} ${MPI_LINK_FLAGS})
    include_directories(${MPI_INCLUDE_PATH})
endif()

add_executable(rsa-cryptanalysis ${SOURCE_FILES})