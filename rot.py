import string


def a_zero(c):
    return ord(c.upper()) - ord('A')


def zero_a(n):
    return chr(n + ord('A'))


def string_from_ints(l, n=0):
    return ''.join(zero_a(c + n) for c in l)


def ints_from_string(st):
    return [a_zero(c) for c in st if c in string.ascii_letters]


def rot_char(n, m, c):
    num = (a_zero(c) + n) % m
    return zero_a(num)


def rot_ints(n, m, l):
    return [(i + n) % m for i in l]


def rot(n, m, st):
    return ''.join(rot_char(n, m, c) for c in st)


def brute_rot(m, st):
    return [rot(n, m, st) for n in range(1, m)]


def apply_key(key, text, m=26):
    key_len = len(key)
    txt_len = len(text)
    chunk_size = min(key_len, txt_len)
    max_len = max(key_len, txt_len)
    return ''.join(
        rot_char(a_zero(key[i]), m, text[i])
        for start in range(0, max_len, chunk_size)
        for i in range(start, min(start + chunk_size, max_len)))


if __name__ == '__main__':
    if a_zero('c') != 2:
        print('expected aZero(\'c\') => 3 but it was ' + str(a_zero('c')))
    if a_zero('z') != 25:
        print('expected aZero(z) => 26, but it was ' + str(a_zero('z')))
    if a_zero('y') != 24:
        print('expected aZero(y) => 25, but it was ' + str(a_zero('y')))
    if zero_a(4) != 'E':
        print('expected zeroA(4) => E, but it was ' + zero_a(4))
    if zero_a(25) != 'Z':
        print('expected zeroA(25) => Z, but it was ' + zero_a(26))
    if zero_a(a_zero('z')) != 'Z':
        print('expected zeroA(aZero(\'z\')) => Z, but it was ' + zero_a(a_zero('z')))
    if ints_from_string('az') != [0, 25]:
        print('expected intsFromString(\'az\') => [0,25], but it was ' + str(ints_from_string('az')))
    if rot_char(13, 26, 'a') != 'N':
        print('expected rotChar(13,26,\'a\') => \'N\', but it was ' + rot_char(13, 26, 'a'))
    if rot_char(13, 26, 'n') != 'A':
        print('expected rotChar(13,26,\'n\') => \'A\', but it was ' + rot_char(13, 26, 'n'))
    if rot_char(1, 26, 'y') != 'Z':
        print('expected rot(1, 26, \'y\') => Z, but it was ' + rot_char(1, 26, 'y'))
    if rot(1, 26, string.ascii_lowercase) != 'BCDEFGHIJKLMNOPQRSTUVWXYZA':
        print('expecting rot(1,26,ascii_lowercase) => \'BCDEFGHIJKLMNOPQRSTUVWXYZA\', ' +
              'but it was ' + rot(1, 26, string.ascii_lowercase))
    if rot(13, 26, string.ascii_lowercase) != 'NOPQRSTUVWXYZABCDEFGHIJKLM':
        print('expecting rot(13,26,ascii_lowercase) => \'NOPQRSTUVWXYZABCDEFGHIJKLM\', ' +
              'but it was ' + rot(13, 26, string.ascii_lowercase))
    if apply_key('bbb', 'abc') != 'BCD':
        print('expecting \'BCD\', but instead it was ' + apply_key('bbb', 'abc'))
    if apply_key('b', 'ab') != 'BC':
        print('expecting \'BC\' but instead it was ' + apply_key('b', 'ab'))
    if apply_key('bc', 'bb') != 'CD':
        print('expecting \'CD\' but instead it was ' + apply_key('bc', 'aa'))
