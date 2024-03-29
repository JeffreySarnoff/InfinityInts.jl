# InfinityInts.jl

#### Copyright © 2020-2023 by Jeffrey Sarnoff.
####  This work is released under The MIT License.

----

#### Arithmetic with the `InfInt` type saturates ±Infinty, so there is no overflow or underflow.
#### Supports Unified Algebra constants Top (⊤ \top) and Bottom (⊥ \bot) (or Bot)
- [Unified Algebra](https://www.cs.utoronto.ca/~hehner/UA.pdf)
- [From Boolean Algebra To Unified Algebra](http://www.cs.toronto.edu/~hehner/BAUA.pdf)

---

## Exports
#### The exported type is `InfInt32` (Infinity and Int32).
#### Also exported
- `PosInf` (prints as `+∞`)
- `NegInf` (prints as `-∞`)
- `Indet`  (prints as `±∞`) _indeterminate_ or _undefined_


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
- Internally, each _Inf+Int32_ value is a struct with supertype `Signed`.
- The actual values are stored as `Float64s`
     - this simplifies the development of the code from the design
     - performance is improved by limiting finite numbers to the `Int32s`.
     - arithmetic with Float64(::Int32) values is representationally safe
     - `^` requires work to determine the sign for saturating magnitudes
     
## Supported operations

- ArithOps:  `+`, `-`, `*`, `div`, `rem` `fld`, `mod`, `cld`, `^`, `factorial`
- Numerics: `signbit`, `sign`, `abs`, `abs2`, `copysign`, `flipsign`                      

- Comparison: `==`, `!=`, `<`, `<=`, `>=`, `>`, `isless`, `isequal
- Predicates: `iseven`, `isodd`, `isinf`, `isnan`, `isfinite`, `iszero`, `isone`

- Bit Operations: `~`, `|`, `&`, `⊻`, `<<`, `>>`, `>>>`, `count_zeros`, `count_ones`
- Binary Layouts: `leading_zeros`, `trailing_zeros`, `leading_ones`, `trailing_ones`

- Low Level Operations: `hash`, `show`

## Type Coverage

- Provides all `Int32` values and signed infinity:`PosInf`, `NegInf`.
- May generate the indeterminate value `Indet`
    - `z = zero(InfInt); div(z,z) # prints ¿?`
- Interoperates with `Int8`, `Int16`, `Int64`, `Int128` (using `Int32(x)`)

----
