% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/day10.R
\name{day10}
\alias{day10}
\alias{f10a}
\alias{f10b}
\alias{example_data_10}
\title{Day 10: Cathode-Ray Tube}
\usage{
f10a(x)

f10b(x)

example_data_10(example = 1)
}
\arguments{
\item{x}{some data}

\item{example}{Which example data to use (by position or name). Defaults to
1.}
}
\value{
For Part One, \code{f10a(x)} returns .... For Part Two,
\code{f10b(x)} returns ....
}
\description{
\href{https://adventofcode.com/2022/day/10}{Cathode-Ray Tube}
}
\details{
\strong{Part One}

You avoid the ropes, plunge into the river, and swim to shore.

The Elves yell something about meeting back up with them upriver, but
the river is too loud to tell exactly what they\'re saying. They finish
crossing the bridge and disappear from view.

Situations like this must be why the Elves prioritized getting the
communication system on your handheld device working. You pull it out of
your pack, but the amount of water slowly draining from a big crack in
its screen tells you it probably won\'t be of much immediate use.

\emph{Unless}, that is, you can design a replacement for the device\'s video
system! It seems to be some kind of \href{https://en.wikipedia.org/wiki/Cathode-ray_tube}{cathode-ray tube}{target="_blank"}
screen and simple CPU that are both driven by a precise \emph{clock circuit}.
The clock circuit ticks at a constant rate; each tick is called a
\emph{cycle}.

Start by figuring out the signal being sent by the CPU. The CPU has a
single register, \code{X}, which starts with the value \code{1}. It supports only
two instructions:
\itemize{
\item \verb{addx V} takes \emph{two cycles} to complete. \emph{After} two cycles, the \code{X}
register is increased by the value \code{V}. (\code{V} can be negative.)
\item \code{noop} takes \emph{one cycle} to complete. It has no other effect.
}

The CPU uses these instructions in a program (your puzzle input) to,
somehow, tell the screen what to draw.

Consider the following small program:

\if{html}{\out{<div class="sourceCode">}}\preformatted{noop
addx 3
addx -5
}\if{html}{\out{</div>}}

Execution of this program proceeds as follows:
\itemize{
\item At the start of the first cycle, the \code{noop} instruction begins
execution. During the first cycle, \code{X} is \code{1}. After the first
cycle, the \code{noop} instruction finishes execution, doing nothing.
\item At the start of the second cycle, the \verb{addx 3} instruction begins
execution. During the second cycle, \code{X} is still \code{1}.
\item During the third cycle, \code{X} is still \code{1}. After the third cycle, the
\verb{addx 3} instruction finishes execution, setting \code{X} to \code{4}.
\item At the start of the fourth cycle, the \code{addx -5} instruction begins
execution. During the fourth cycle, \code{X} is still \code{4}.
\item During the fifth cycle, \code{X} is still \code{4}. After the fifth cycle, the
\code{addx -5} instruction finishes execution, setting \code{X} to \code{-1}.
}

Maybe you can learn something by looking at the value of the \code{X}
register throughout execution. For now, consider the \emph{signal strength}
(the cycle number multiplied by the value of the \code{X} register) \emph{during}
the 20th cycle and every 40 cycles after that (that is, during the 20th,
60th, 100th, 140th, 180th, and 220th cycles).

For example, consider this larger program:

\if{html}{\out{<div class="sourceCode">}}\preformatted{addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop
}\if{html}{\out{</div>}}

The interesting signal strengths can be determined as follows:
\itemize{
\item During the 20th cycle, register \code{X} has the value \code{21}, so the
signal strength is 20 \* 21 = \emph{420}. (The 20th cycle occurs in the
middle of the second \code{addx -1}, so the value of register \code{X} is the
starting value, \code{1}, plus all of the other \code{addx} values up to that
point: 1 + 15 - 11 + 6 - 3 + 5 - 1 - 8 + 13 + 4 = 21.)
\item During the 60th cycle, register \code{X} has the value \code{19}, so the
signal strength is 60 \* 19 = \emph{\code{1140}}.
\item During the 100th cycle, register \code{X} has the value \code{18}, so the
signal strength is 100 \* 18 = \emph{\code{1800}}.
\item During the 140th cycle, register \code{X} has the value \code{21}, so the
signal strength is 140 \* 21 = \emph{\code{2940}}.
\item During the 180th cycle, register \code{X} has the value \code{16}, so the
signal strength is 180 \* 16 = \emph{\code{2880}}.
\item During the 220th cycle, register \code{X} has the value \code{18}, so the
signal strength is 220 \* 18 = \emph{\code{3960}}.
}

The sum of these signal strengths is \emph{\code{13140}}.

Find the signal strength during the 20th, 60th, 100th, 140th, 180th, and
220th cycles. \emph{What is the sum of these six signal strengths?}

\strong{Part Two}

It seems like the \code{X} register controls the horizontal position of a
\href{https://en.wikipedia.org/wiki/Sprite_(computer_graphics)}{sprite}{target="_blank"}.
Specifically, the sprite is 3 pixels wide, and the \code{X} register sets the
horizontal position of the \emph{middle} of that sprite. (In this system,
there is no such thing as \"vertical position\": if the sprite\'s
horizontal position puts its pixels where the CRT is currently drawing,
then those pixels will be drawn.)

You count the pixels on the CRT: 40 wide and 6 high. This CRT screen
draws the top row of pixels left-to-right, then the row below that, and
so on. The left-most pixel in each row is in position \code{0}, and the
right-most pixel in each row is in position \code{39}.

Like the CPU, the CRT is tied closely to the clock circuit: the CRT
draws \emph{a single pixel during each cycle}. Representing each pixel of the
screen as a \verb{#}, here are the cycles during which the first and last
pixel in each row are drawn:

\if{html}{\out{<div class="sourceCode">}}\preformatted{Cycle   1 -> ######################################## <- Cycle  40
Cycle  41 -> ######################################## <- Cycle  80
Cycle  81 -> ######################################## <- Cycle 120
Cycle 121 -> ######################################## <- Cycle 160
Cycle 161 -> ######################################## <- Cycle 200
Cycle 201 -> ######################################## <- Cycle 240
}\if{html}{\out{</div>}}

So, by
\href{https://en.wikipedia.org/wiki/Racing_the_Beam}{carefully}{target="_blank"}
\href{https://www.youtube.com/watch?v=sJFnWZH5FXc}{[timing]{title="While you're at it, go watch everything else by Retro Game Mechanics Explained, too."}}{target="_blank"}
the CPU instructions and the CRT drawing operations, you should be able
to determine whether the sprite is visible the instant each pixel is
drawn. If the sprite is positioned such that one of its three pixels is
the pixel currently being drawn, the screen produces a \emph{lit} pixel
(\verb{#}); otherwise, the screen leaves the pixel \emph{dark} (\code{.}).

The first few pixels from the larger example above are drawn as follows:

\if{html}{\out{<div class="sourceCode">}}\preformatted{Sprite position: ###.....................................

Start cycle   1: begin executing addx 15
During cycle  1: CRT draws pixel in position 0
Current CRT row: #

During cycle  2: CRT draws pixel in position 1
Current CRT row: ##
End of cycle  2: finish executing addx 15 (Register X is now 16)
Sprite position: ...............###......................

Start cycle   3: begin executing addx -11
During cycle  3: CRT draws pixel in position 2
Current CRT row: ##.

During cycle  4: CRT draws pixel in position 3
Current CRT row: ##..
End of cycle  4: finish executing addx -11 (Register X is now 5)
Sprite position: ....###.................................

Start cycle   5: begin executing addx 6
During cycle  5: CRT draws pixel in position 4
Current CRT row: ##..#

During cycle  6: CRT draws pixel in position 5
Current CRT row: ##..##
End of cycle  6: finish executing addx 6 (Register X is now 11)
Sprite position: ..........###...........................

Start cycle   7: begin executing addx -3
During cycle  7: CRT draws pixel in position 6
Current CRT row: ##..##.

During cycle  8: CRT draws pixel in position 7
Current CRT row: ##..##..
End of cycle  8: finish executing addx -3 (Register X is now 8)
Sprite position: .......###..............................

Start cycle   9: begin executing addx 5
During cycle  9: CRT draws pixel in position 8
Current CRT row: ##..##..#

During cycle 10: CRT draws pixel in position 9
Current CRT row: ##..##..##
End of cycle 10: finish executing addx 5 (Register X is now 13)
Sprite position: ............###.........................

Start cycle  11: begin executing addx -1
During cycle 11: CRT draws pixel in position 10
Current CRT row: ##..##..##.

During cycle 12: CRT draws pixel in position 11
Current CRT row: ##..##..##..
End of cycle 12: finish executing addx -1 (Register X is now 12)
Sprite position: ...........###..........................

Start cycle  13: begin executing addx -8
During cycle 13: CRT draws pixel in position 12
Current CRT row: ##..##..##..#

During cycle 14: CRT draws pixel in position 13
Current CRT row: ##..##..##..##
End of cycle 14: finish executing addx -8 (Register X is now 4)
Sprite position: ...###..................................

Start cycle  15: begin executing addx 13
During cycle 15: CRT draws pixel in position 14
Current CRT row: ##..##..##..##.

During cycle 16: CRT draws pixel in position 15
Current CRT row: ##..##..##..##..
End of cycle 16: finish executing addx 13 (Register X is now 17)
Sprite position: ................###.....................

Start cycle  17: begin executing addx 4
During cycle 17: CRT draws pixel in position 16
Current CRT row: ##..##..##..##..#

During cycle 18: CRT draws pixel in position 17
Current CRT row: ##..##..##..##..##
End of cycle 18: finish executing addx 4 (Register X is now 21)
Sprite position: ....................###.................

Start cycle  19: begin executing noop
During cycle 19: CRT draws pixel in position 18
Current CRT row: ##..##..##..##..##.
End of cycle 19: finish executing noop

Start cycle  20: begin executing addx -1
During cycle 20: CRT draws pixel in position 19
Current CRT row: ##..##..##..##..##..

During cycle 21: CRT draws pixel in position 20
Current CRT row: ##..##..##..##..##..#
End of cycle 21: finish executing addx -1 (Register X is now 20)
Sprite position: ...................###..................
}\if{html}{\out{</div>}}

Allowing the program to run to completion causes the CRT to produce the
following image:

\if{html}{\out{<div class="sourceCode">}}\preformatted{##..##..##..##..##..##..##..##..##..##..
###...###...###...###...###...###...###.
####....####....####....####....####....
#####.....#####.....#####.....#####.....
######......######......######......####
#######.......#######.......#######.....
}\if{html}{\out{</div>}}

Render the image given by your program. \emph{What eight capital letters
appear on your CRT?}
}
\examples{
f10a(example_data_10())
f10b()
}
