# declare module
module Rendering

include("utilities.jl")

# load things
using Distributed, Images, .Utilities

# export some things
export Screen, runfragshader!, genericfragshader

"""
The basic object to which things are rendered.
"""
mutable struct Screen
    width::Integer
    height::Integer
    pixels::Matrix{RGB}
    Screen(width, height) = new(
        width, height, zeros(RGB, height, width)
    )
end

"""
Renders an image via a frag shader.
Takes in a screen and a shader and
uses the shader function to determine pixel colors.
kwargs is passed to the shader function.
The pixel array in mutated in place.
"""
function runfragshader!(
    screen::Screen,
    shader; 
    kwargs...
)
    # create a function that can be plugged into map
    wrappedshader = ((index, x)::Tuple{Int, RGB}) -> shader(
        x; 
        uv=pixelindextouv(index, screen), 
        kwargs...
    )

    # run the shader on every pixel
    # todo: switch back to pmap
    screen.pixels = map(wrappedshader, enumerate(screen.pixels))
end

"""
A template for a generic fragment shader.
Takes in a pixel value, a uv coords, and some state data in kwargs.
Requires you to feed in a blue_val value to the runfragshader! kwargs.
"""
function genericfragshader(pixel_value; uv, kwargs...)
    (x, y) = uv

    blue_val = kwargs[:blue_val]
    #blue_val = 0.
    
    return RGB(x, y, blue_val)
end

# end module
end