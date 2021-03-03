// The world pixel by pixel 2021
// Daniel Rozin
// fragment shader to create a variable blur effect 

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;  // this is the color of all the pixels coming in
uniform vec2 texOffset;     // the x and y position of this pixels

varying vec4 vertColor;
varying vec4 vertTexCoord;
uniform float x;                // this is our argument coming from processing
uniform float y;                 // this is our argument coming from processing




void main() {

int amount;

amount =  int(sqrt((x-vertTexCoord.x)*(x-vertTexCoord.x)+(y-vertTexCoord.y)*(y-vertTexCoord.y))*30); // calculate distance from mouse to our pixel

if (amount > 20)amount =20;         // 20 in enough


float countPix= 0;
vec4 sumColors= vec4(0,0,0,0);                  // make a new vector to hold our sum (R,G,B,A)
	for (int x = -amount;x<= amount;x++){        // lets visit all pixels around our pixels from -amount to +amount
		for (int y = -amount;y<= amount;y++){
		vec2 thisPixPosition = vertTexCoord.st + vec2(texOffset.s*x, texOffset.s*y);   // calculate the position of a pixel
		  vec4 thisPixColor = texture2D(texture, thisPixPosition);                      // get the color of a pixel
			sumColors+=thisPixColor;                                        // add the color of the pixel to our sum
            countPix++;                                                     // keep count of how any pixels we added
		}
	}


  gl_FragColor = sumColors/countPix;    // divide the sum with the number of pixels to get the average


}
