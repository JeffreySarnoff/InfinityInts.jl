# InfinityInts.jl

#### Copyright © 2015-2019 by Jeffrey Sarnoff.
####  This work is released under The MIT License.

----

### Arithmetic with the `InfInt` type saturates ±Infinty, so there is no overflow or underflow.

---

The exported type is `InfInt32` aliased as `InfInt` (Infinity and Integer, `IntInf` Integer with Infinity).

This type works as if it were defined
```
# `Undefined` is the result of e.g. `PosInfinity * Zero` or `div(Zero, Zero`).
@enum KindOfNum SignedInt PosInfinity NegInfinity Undefined

struct InfInt <: Signed
    kind::KindOfNum
    value::Int32     # only accessed when kind === SignedInt
end
```
While the actual implementation uses a different approach, it is useful to think of this as described.

## Supported operations

- Comparisons: `==`, `!=`, `<`, `<=`, `>=`, `>`, `isless`, `isequal`, `cmp`
- Arithmetic:  `+`, `-`, `*`, `div`, `rem` `fld`, `mod`, `cld`, `^`, `factorial`
- Bit Operations: `~`, `|`, `&`, `⊻`, `<<`, `>>`, `>>>`, `count_zeros`, `count_ones`
- Bit Patterns: `leading_zeros`, `trailing_zeros`, `leading_ones`, `trailing_ones`
- Low Level Functions: `signbit`, `sign`, `abs`, `abs2`, `copysign`, `flipsign`                      
- Low Level Operations: `hash`, `show`

## Type Coverage

- Provides all `Int32` values and signed infinity:`PosInf`, `NegInf`.
- Interoperates with `Int8`, `Int16`, `Int32`, `Int64`, `Int128`

----
