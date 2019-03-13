import math

def feetandinches(inches):
    return fractionize(inches, 12)

def feettoinch(feet, inches = 0):
    return feet * 12 + inches

def fractionize(n, m):
    return (math.floor(n/m), n%m)

def cmtoinch(cms):
    return cms / 2.54

def inchtocm(inches):
    return inches * 2.54

def cmtom(cm):
    return cm / 100
