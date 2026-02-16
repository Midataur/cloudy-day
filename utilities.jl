# start module
module Utilities

export pixelindextouv

"""
Converts an index in a screen array to uv coords.
"""
function pixelindextouv(oned_index, screen)
    # convert 1d index into 2d index
    y, x = CartesianIndices(screen.pixels)[oned_index].I

    # convert index coordinates to uv coordinates
    return [(x-1)/screen.width, (screen.height-y)/screen.height]
end

# end module
end