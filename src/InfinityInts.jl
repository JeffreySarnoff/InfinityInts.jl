module InfinityInts

export InfInt, PosInf, NegInf

const FloatInt32min = Float64(typemin(Int32))
const FloatInt32max = Float64(typemax(Int32))

struct InfInt <: Signed
    val::Float64
    
    function InfInt(x::Int32)
        return new(Float64(x))
    end
    
    function InfInt(x::Float64)
        if FloatInt32min <= x <= FloatInt32max
             x = trunc(x)
        elseif isfinite(x)
             x = copysign(Inf, x)
        end    # else isnan
        return new(x)
    end
end

const PosInf = InfInt(Inf)
const NegInf = InfInt(-Inf)

InfInt(x::T) where {T<:Signed} = InfInt(Int32(x))

@inline function Base.Int32(x::InfInt)
    if FloatInt32min <= x.val <= FloatInt32max
        Int32(x.val)
    elseif !isnan(x.val)
        signbit(x.val) ? typemax(Int32) : typemin(Int32)
    else
        throw(ErrorException("NaN"))
    end
end

for I in (:Int8, :Int16, :Int64, :Int128)
  @eval @inline function Base.$I(x::InfInt)
    if !isnan(x.val)
        $I(Int32(x))
    else
        throw(ErrorException("NaN"))
    end
  end
end

Base.isnan(x::InfInt) = isnan(x.val)
Base.isinf(x::InfInt) = isinf(x.val)
Base.isfinite(x::InfInt) = isfinite(x.val)

Base.:iseven(x::InfInt) = isfinite(x.val) && iseven(Int32(x.val))
Base.:isodd(x::InfInt) = isfinite(x.val) && isodd(Int32(x.val))

Base.signbit(x::InfInt) = signbit(x.val)
Base.sign(x::InfInt) = Int32(sign(x.val))

Base.:(~)(x::InfInt) = InfInt(~Int32(x))

for F in (:(|), :(&), :(xor))
  @eval begin
    Base.$F(x::InfInt, y::InfInt) = InfInt($F(Int32(x), Int32(y))) 
    Base.$F(x::InfInt, y::S) where {S<:Signed} = InfInt($F(Int32(x), Int32(y)))
    Base.$F(x::S, y::InfInt) where {S<:Signed} = InfInt($F(Int32(x), Int32(y)))    
  end
end

for F in (:(<<), :(>>), :(>>>))
  @eval begin
    Base.$F(x::InfInt, y::InfInt) = InfInt($F(Int32(x), Int32(y))) 
    Base.$F(x::InfInt, y::S) where {S<:Signed} = InfInt($F(Int32(x), Int32(y)))
    Base.$F(x::S, y::InfInt) where {S<:Signed} = InfInt($F(Int32(x), Int32(y)))
  end
end
        
for F in (:(==), :(!=), :(<=), :(>=), :(<), :(>))
  @eval begin
    Base.$F(x::InfInt, y::InfInt) = $F(x.val, y.val) 
    Base.$F(x::InfInt, y::S) where {S<:Signed} = $F(x.val, Float64(y))
    Base.$F(x::S, y::InfInt) where {S<:Signed} = $F(Float64(x), y.val)    
  end
end

for F in (:(+), :(-), :(*), :(mod), :(rem), :(div), :(fld), :(cld))
  @eval begin
    Base.$F(x::InfInt, y::InfInt) = InfInt($F(x.val, y.val)) 
    Base.$F(x::InfInt, y::S) where {S<:Signed} = InfInt($F(x.val, Float64(y)))
    Base.$F(x::S, y::InfInt) where {S<:Signed} = InfInt($F(Float64(x), y.val))    
  end
end

function Base.:(^)(x::InfInt, y::InfInt)
    xy = x.val^y.val
    if isodd(y) && signbit(x)
        xy = -abs(xy)
    else
        xy = abs(xy)
    end
    return InfInt(xy)
end

Base.hash(x::InfInt, u::UInt64) = hash(x.val, u)

Base.:(-)(x::InfInt) = InfInt(-x.val)
Base.:(abs)(x::InfInt) = InfInt(abs(x.val))
Base.:(abs2)(x::InfInt) = InfInt(abs2(x.val))

Base.copysign(x::InfInt, y::InfInt) = signbit(x.val) === signbit(y.val) ? x : -x
Base.flipsign(x::InfInt, y::InfInt) = signbit(y.val) ? -x : x

function Base.show(io::IO, x::InfInt)
    if isnan(x.val)
        str = "NaN"
    elseif isinf(x.val)
        str = signbit(x.val) ? "-Inf" : "+Inf"
    else
        str = string(Int32(x))
    end
    print(io, str)
end

end  # InfinityInts
