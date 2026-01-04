# declare module
module Rendering

include("utilities.jl")

# load things
using Distributed, Images, .Utilities

# export some things
export Screen, runfragshader


# define the screen
mutable struct Screen
    width::Integer
    height::Integer
    pixels::Matrix{RGB}
    Screen(width, height) = new(
        # 3 is for RGB
        width, height, zeros(RGB, height, width)
    )
end

# define rendering an image
# takes in a screen and a shader
# uses the shader function to determine pixel colors
# kwargs is passed to the shader function
# changes the pixel array in place
function runfragshader(
    screen::Screen,
    shader; 
    kwargs...
)
    # create a function that can be plugged into map
    wrappedshader = (x, index) -> shader(
        x; 
        uv=pixelindextouv(index, screen), 
        kwargs...
    )

    # run the shader on every pixel
    screen.pixels = pmap(wrappedshader, screen.pixels)
end

# end module
end