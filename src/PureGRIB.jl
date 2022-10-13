module PureGRIB

struct IndicatorSection
    discipline::UInt8
    editionnumber::UInt8
    length::UInt64
end

function Base.read(io::IO, ::Type{IndicatorSection})
    magic = read(io, 4)
    if magic != map(UInt8, collect("GRIB"))
        throw(ErrorException("magic number 'GRIB' doesn't exist"))
    end
    skip(io, 2)
    IndicatorSection(
        read(io, UInt8),
        read(io, UInt8),
        read(io, UInt64) |> ntoh,
        )
end

end