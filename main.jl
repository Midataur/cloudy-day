# activate the environment
import Pkg; Pkg.activate("./juliaenv/")

include("rendering.jl")
include("utilities.jl")

using .Rendering, .Utilities, FileIO

function main()
    screen = Screen(400, 400)

    runfragshader!(screen, genericfragshader; blue_val=0.4)

    save("./rendered_image.png", screen.pixels)
end

@time main()