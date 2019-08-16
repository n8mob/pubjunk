import hashlib


def hashit(s):
    m = hashlib.sha256()
    m.update(s)
    return m.hexdigest()


if __name__ == "__main__":

    hashes = [hashit(s.encode()) for s in [f'32241{i}' for i in [1, 2, 3, 4, 5, 6]]]

    correctHash = 'ee07ca6b5d247f0a680638dc7f14ca3a10c6d0e8c3fda5bb5c6d2392f19cba86'
    if correctHash in hashes:
        print(f'The missing number is {hashes.index(correctHash) + 1}')

    for i, s in enumerate(hashes):
        print(f'{i+1}:\t{s}')
