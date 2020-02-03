//
// Created by danijel on 1/28/20.
//

#ifndef RSA_CRYPTANALYSIS_RSA_MPI_H
#define RSA_CRYPTANALYSIS_RSA_MPI_H

#pragma once

#include <mpi.h>

#include <boost/archive/text_iarchive.hpp>
#include <boost/archive/text_oarchive.hpp>
#include <boost/mpi.hpp>


#include <iostream>
#include <sstream>
using namespace std;


const int MAX_PONG_CNT = 14;

struct ProcessRounds {
    vector<int> rounds;
    int last_rank;
};

#endif //RSA_CRYPTANALYSIS_RSA_MPI_H
