# start module
module Utilities

export pixelindextouv

# converts an index in a screen array to uv coords
function pixelindextouv(index, screen)
    # convert 1d index into 2d index
    y,x = CartesianIndices(screen.pixels)[index].I

    # convert index coordinates to uv coordinates
    return [(x-1)/screen.width, (screen.height-y)/screen.height]
end

# end module
end