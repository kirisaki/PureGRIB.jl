using PureGRIB
using Test

@testset "PureGRIB.jl" begin
    @testset "Indicator Section" begin
        @testset "right format" begin
            buf = IOBuffer([
                0x47, 0x52, 0x49, 0x42, 0xFF, 0xFF, 
                0x00,
                0x02,
                0x00, 0x00, 0x00, 0x00, 0x03, 0x02, 0xE9, 0x61
                ])
            indicator = read(buf, PureGRIB.IndicatorSection)
            @test indicator.discipline == 0x00
            @test indicator.editionnumber == 0x02
            @test indicator.length == 0x000000000302E961
        end
        @testset "invalid magic numbers" begin
            buf = IOBuffer([
                0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 
                0x00,
                0x02,
                0x00, 0x00, 0x00, 0x00, 0x03, 0x02, 0xE9, 0x61
                ])
           @test_throws ErrorException read(buf, PureGRIB.IndicatorSection) 
        end
    end
end
