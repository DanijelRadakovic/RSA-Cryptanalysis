#include "rsa_mpi.h"
#include <vector>
#include <algorithm>


ProcessRounds calc_process_rounds(int process_cnt) {
    int init = MAX_PONG_CNT < process_cnt ? 0 : MAX_PONG_CNT / process_cnt;
    int remainder = MAX_PONG_CNT % process_cnt;
    vector<int> v(process_cnt, init);
    for (size_t i = 0; i < remainder; ++i) ++v[i];
    return ProcessRounds{v, static_cast<int>(std::min_element(v.begin(), v.end()) - v.begin())};
}


int main(int argc, char *argv[]) {

    int size, rank;
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    int name_len;
    ostringstream out_stream;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Get_processor_name(processor_name, &name_len);

    if (size < 2) {
        cerr << "World is to small, need at least 2 nodes" << endl;
        MPI_Abort(MPI_COMM_WORLD, 1);
    }

    auto process_rounds = calc_process_rounds(size);
    int rounds = process_rounds.rounds[rank],
            last_rank = process_rounds.last_rank,
            round = 0,
            pong_cnt = 0,
            destination = (rank + 1) % size,
            source = rank == 0 ? size - 1 : (rank - 1) % size;

    cout << "Process rank: " << rank << " rounds: " << rounds << endl;

    while (round < rounds) {
        if (rank == pong_cnt % size) {
            pong_cnt++;
            cout << "Process " << rank << " sending " << pong_cnt << " to process " << destination << endl;
            MPI_Send(&pong_cnt, 1, MPI_INT, destination, 0, MPI_COMM_WORLD);
            ++round;
        } else {
            MPI_Recv(&pong_cnt, 1, MPI_INT, source, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            cout << "Process " << rank << " received " << pong_cnt << " from process " << source << endl;
        }
    }

    if (last_rank == rank) {
        MPI_Recv(&pong_cnt, 1, MPI_INT, source, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        cout << "Process " << rank << " received " << pong_cnt << " from process " << source << endl;
    }

    MPI_Finalize();

    return 0;
}
