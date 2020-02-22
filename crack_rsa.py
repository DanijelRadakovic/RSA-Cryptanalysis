import gmpy2
import sys


def get_args():
    if len(sys.argv) != 7:
        print("required 4 arguments:")
        print("-p\tfirst prime factor")
        print("-q\tsecond prime factor")
        print("-e\tpublic exponent")
        sys.exit(1)

    p, q, e = -1, -1, -1
    for i in range(1, len(sys.argv), 2):
        if sys.argv[i] == "-p":
            p = int(sys.argv[i + 1])
        elif sys.argv[i] == "-q":
            q = int(sys.argv[i + 1])
        elif sys.argv[i] == "-e":
            e = int(sys.argv[i + 1])
        else:
            print("could not recognize parameter")
            sys.exit(1)
    return p, q, e


if __name__ == '__main__':
    p, q, e = get_args()

    N = p * q
    PHI = (p - 1) * (q - 1)
    d = (gmpy2.invert(e, PHI))

    print("p=%s\nq=%s\nN=%s" % (p, q, N,))
    print("public key: (%s,%s)" % (e, N))
    print("private key: (%s,%s)" % (d, N))
