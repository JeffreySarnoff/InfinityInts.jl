module InfInts

export InfInt32, InfInt64

import Base.Checked: add_with_overflow, sub_with_overflow, mul_with_overflow
#checked_neg, checked_abs, checked_add, checked_sub, checked_mul,
#                     checked_div, checked_rem, checked_fld, checked_mod, checked_cld,
struct InfInt
    value::Int64
end

const PosInf64 = typemax(Int64)
const NegInf64 = typemin(Int64)

const PosInf = InfInt(PosInf64)
const NegInf = InfInt(NegInf64)
const ZerInf = InfInt(Int64(0))

Base.isinf(x::InfInt) = x.value === PosInf64 || x.value === NegInf64
Base.iszero(x::InfInt) = iszero(x.value)
Base.isone(x::InfInt) = iszero(x.value)

function Base.:(*)(x::InfInt, y::InfInt)
    res, ovf = mul_with_overflow(x.value, y.value)
    if ovf
        signbit(x.value) === signbit(y.value) ? PosInf : NegInf
    else
        InfInt(res)
    end
end

function Base.:(*)(x::InfInt, y::Int64)
    res, ovf = mul_with_overflow(x.value, y)
    if ovf
        signbit(x.value) === signbit(y) ? PosInf : NegInf
    else
        InfInt(res)
    end
end

function Base.:(*)(x::Int64, y::InfInt)
    res, ovf = mul_with_overflow(x, y.value)
    if ovf
        signbit(x) === signbit(y.value) ? PosInf : NegInf
    else
        InfInt(res)
    end
end

function Base.:(+)(x::InfInt, y::InfInt)
    res, ovf = add_with_overflow(x.value, y.value)
    if ovf # both signbits match
        signbit(x.value) ? NegInf : PosInf
    else
        InfInt(res)
    end
end

function Base.:(-)(x::InfInt, y::InfInt)
    res, ovf = sub_with_overflow(x.value, y.value)
    if ovf # signbits do not match
        signbit(res) ? PosInf : NegInf
    else
        InfInt(res)
    end
end

function Base.div(x::InfInt, y::InfInt)
    x === 0 && y === 0 && throw(ErrorException("integer division error: div(0,0)"))
    isinf(x) && isinf(y) && throw(ErrorException("integer division error: div(±Inf,±Inf)"))
    iszero(x) && return ZerInf
    if isinf(x)
        signbit(x.value) === signbit(y.value) ? x : -x
    else
        InfInt(div(x.value, y.value))
    end
end

function Base.show(io::IO, x::InfInt)
    if isinf(x)
        str = signbit(x.value) ? "-Inf" : "+Inf"
    else
        str = string(x.value)
    end
    print(io, str)
end

end  # InfInts
