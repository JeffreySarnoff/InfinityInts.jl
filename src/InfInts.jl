module InfInts

export InfInt32, InfInt64

import Base.Checked: add_with_overflow, sub_with_overflow, mul_with_overflow
#checked_neg, checked_abs, checked_add, checked_sub, checked_mul,
#                     checked_div, checked_rem, checked_fld, checked_mod, checked_cld,
 truct Special64
    value::Int64
end

const PosInf = Special(1)
const NegInf = Special(-1)
const InvInf = Special(0)

const InfInt = Union{Int64, Special64}

function InfInt(x::Int64)
  iszero(x) ? InvInf : x
end  


end  # InfInts
