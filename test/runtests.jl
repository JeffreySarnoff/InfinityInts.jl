using InfinityInts, Test

a = InfInt(10)
b = InfInt(5)
c = InfInt(50)
d = InfInt(2)
e = InfInt(1)
f = InfInt(0)

@test a == a
@test a === a
@test a != b
@test a !== b

@test a <= b
@test a < b
@test d >= e
@test d > e

@test b + b == a
@test a - b === b
@test a * b === c

@test div(c, b) == a
@test div(c, -b) == -a
@test div(-c, b) == -a
@test div(-c, -b) == a

@test rem(b, d) == e
@test rem(-b, d) == -e
@test rem(b, -d) == e
@test rem(-b, -d) == -e

@test fld(c, b) == a
@test fld(-c, b) == -a
@test fld(c, -b) == -a
@test fld(-c, -b) == a

@test mod(b, d) == e
@test mod(-b, d) == e
@test mod(b, -d) == -e
@test mod(-b, -d) == -e
