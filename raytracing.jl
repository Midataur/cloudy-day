module Raytracing

export Camera, Sphere, Viewport, directionFromAngles

"""
An object that stores data for a camera.
"""
struct Camera
    #the position of the camera
    pos::Vector{Real}
    
    # the next two are camera angles
    # spherical coordinates, physics convention
    phi::Real
    theta::Real
    
    # direction vector of the camera
    # derived entirely from phi and theta
    direction::Vector{Real}

    # 
    Camera(pos, phi, theta) = new(
        pos, phi, theta, directionfromAngles(
            phi,
            theta
        )
    )
end

"""
An object that stores data for a viewport.
"""
struct Viewport
    # distance from the camera
    dist::Real
    
    # pixels per unit length
    ppul::Real
    
    # everything below this line is a derived quantity
    
    # the size of the screen in real coordinates
    width::Real
    height::Real
    
    # these vectors determine the screen directions
    # dx points along the x axis in screen coordinates
    # dy points along the y axis in screen coordinates
    # they are unit vectors
    vx::Vector{Real}
    vy::Vector{Real}
    
    # top left of the screen
    # corresponds to (0,0) in pixel coordinates
    bottomleft::Vector{Real}
end

"""
A geometric sphere primitive.
"""
struct Sphere
    # the center of the sphere
    center::Vector{Real}

    # defines the radius
    radius::Real
    
    # defines the "front" direction for texture purposes
    front_angle::Real
end

"""
Gives a unit vector from spherical coords.
phi is the angle from x axis.
theta is the angle from xy plane.
"""
function directionfromangles(phi, theta)
    return [
        cos(phi)*cos(theta),
        sin(phi)*cos(theta),
        sin(theta)
    ]
end

end