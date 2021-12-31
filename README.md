# Schlafli_Stars
 An entry for a mathologer contest.

## Installation
On windows 64-bit, just download and extract the zip file.
On windows 32-bit, download the other zip file and install Java 8
On mac or linux, download and install Processing 3, and then pull the repository and open the .pde files with processing. Just hit "play".


Given the Schläfli Symbol {P/Q} of a polygon this program produces similar "miracle" animations as seen in this video:
https://www.youtube.com/watch?v=oEN0o9ZGmOM

Pressing P or Q will put you in editing mode. You can use BACKSPACE and number keys to change
the corresponding part of the Schläfli symbol. Then just hit ENTER/RETURN to confirm your choice.

The +/- keys change the radial distance of the pen on to the center of the rolling circle.

## Toggle Controls
?: Help Text (Show/Hide basic help text)
P: Edit P
Q: Edit Q
A: Rolling shape (Show/Hide shapes inscribed in rolling circles)
S: Formation shape (Show/Hide shapes made from formation of rolling cirlces.)
D: Rollers (Show/Hide inner rolling circles)
I: Info (Show/Hide info at top-left)
F: Full Mode (Show just one pen's worth of things or all pens.)
G: Show/Hide Spirograph approximating ideal polygon
H: Show/Hide Ideal Polygon of Schläfli Symbol
T: Trace Mode (Shows movement trace. Can make UI look strange. "I" and "?" hide it.)
R: Record (saves frames in "./frames" as png files. Can be slow.)

## Info Panel

First it shows the full Schläfli symbol. Then it shows the reduced Schläfli Symbol of the subshapes multiplied by
the number of subshapes. Then it shows the relative pen radius (treating a rolling circle as radius 1.
Underneath it shows the gcd and lcm of P and Q. The Degeneracy is the number of "Extra" shapes. So 0 means that P/Q is irreducible.