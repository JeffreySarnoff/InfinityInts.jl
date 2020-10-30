# InfinityInts.jl

#### Copyright © 2015-2019 by Jeffrey Sarnoff.
####  This work is released under The MIT License.

----

### Arithmetic with the `InfInt` type saturates ±Infinty, so there is no overflow or underflow.

---

## Exports
#### The exported type is `InfInt32` (Infinity and Int32).
#### Also exported
- `PosInf` (prints as `+∞`)
- `NegInf` (prints as `-∞`)
- `ZerInf` (prints as `¿?`) _indeterminate_ or _undefined_


This type works as if it were defined
```
# `ZerInf` is the result of e.g. `PosInf * 0` or `div(0, 0)`.
@enum KindOfNum SignedInt PosInfinity NegInfinity Indeterminate

struct InfInt <: Signed
    kind::KindOfNum
    value::Int32     # only accessed when kind === SignedInt
end
```
While the actual implementation uses a different approach, it is useful to think of this as described.
> Internally, each _Inf+Int32_ value is a struct with supertype `Signed`.
> The actual values are stored as `Float64s`
     - this simplifies the development of the code from the design
     - performance is improved by limiting finite numbers to the `Int32s`.
     - 

## Supported operations

- Predicates: `iseven`, `isodd`, `isinf`, `isnan`, `isfinite`, `iszero`, `isone`
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
