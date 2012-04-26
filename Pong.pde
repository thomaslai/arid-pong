import traer.physics.*;

Particle b;
ParticleSystem physics;

void setup()
{
  size( 800, 400 );
  frameRate( 30 );
  smooth();
  ellipseMode( CENTER );
  noStroke();
  noCursor();
  physics = new ParticleSystem();
  physics.setIntegrator( ParticleSystem.MODIFIED_EULER ); 
  b = physics.makeParticle( 1.0, width/2, height/2, 0 );
  b.velocity().set(10,5,0);
}

void draw()
{
  handleBoundaryCollisions( b );
  physics.tick();
  background( 255 );  
  stroke( 0 );
  fill( 0 );  
  rect( width - 30, mouseY, 5, 50 );
  rect( 30, b.position().y() - 15, 5, 50 );
  ellipse( b.position().x(), b.position().y(), 30, 30 );
}

// really basic collision strategy:
// sides of the window are walls
// if it hits a wall pull it outside the wall and flip the direction of the velocity
// the collisions aren't perfect so we take them down a notch too
void handleBoundaryCollisions( Particle p )
{
  if ( p.position().x() - 15 < 30 || (p.position().x() + 15 > width - 30 && p.position().y() - 15 < mouseY + 25 && p.position().y() + 15 > mouseY - 25) )
    p.velocity().set( -1.05*p.velocity().x(), p.velocity().y(), 0 );
  if ( p.position().y() -15 < 0 || p.position().y() + 15 > height )
    p.velocity().set( p.velocity().x(), -1.05*p.velocity().y(), 0 );
  p.position().set( constrain( p.position().x(), 0, width ), constrain( p.position().y(), 0, height ), 0 );
}
