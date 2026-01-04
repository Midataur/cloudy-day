include("rendering.jl")
include("utilities.jl")

using .Rendering, .Utilities



screen = Screen(6, 4)

display(
    reshape(
        map(x->pixelindextouv(x[1], screen), enumerate(screen.pixels)), (screen.height, screen.width)
    )
)