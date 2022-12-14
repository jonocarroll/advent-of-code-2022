#' Day 14: Regolith Reservoir
#'
#' [Regolith Reservoir](https://adventofcode.com/2022/day/14)
#'
#' @name day14
#' @rdname day14
#' @details
#'
#' **Part One**
#'
#' The distress signal leads you to a giant waterfall! Actually, hang on -
#' the signal seems like it\'s coming from the waterfall itself, and that
#' doesn\'t make any sense. However, you do notice a little path that leads
#' *behind* the waterfall.
#'
#' Correction: the distress signal leads you behind a giant waterfall!
#' There seems to be a large cave system here, and the signal definitely
#' leads further inside.
#'
#' As you begin to make your way deeper underground, you feel the ground
#' rumble for a moment. Sand begins pouring into the cave! If you don\'t
#' quickly figure out where the sand is going, you could quickly become
#' trapped!
#'
#' Fortunately, your [familiarity](/2018/day/17) with analyzing the path of
#' falling material will come in handy here. You scan a two-dimensional
#' vertical slice of the cave above you (your puzzle input) and discover
#' that it is mostly *air* with structures made of *rock*.
#'
#' Your scan traces the path of each solid rock structure and reports the
#' `x,y` coordinates that form the shape of the path, where `x` represents
#' distance to the right and `y` represents distance down. Each path
#' appears as a single line of text in your scan. After the first point of
#' each path, each point indicates the end of a straight horizontal or
#' vertical line to be drawn from the previous point. For example:
#'
#'     498,4 -> 498,6 -> 496,6
#'     503,4 -> 502,4 -> 502,9 -> 494,9
#'
#' This scan means that there are two paths of rock; the first path
#' consists of two straight lines, and the second path consists of three
#' straight lines. (Specifically, the first path consists of a line of rock
#' from `498,4` through `498,6` and another line of rock from `498,6`
#' through `496,6`.)
#'
#' The sand is pouring into the cave from point `500,0`.
#'
#' Drawing rock as `#`, air as `.`, and the source of the sand as `+`, this
#' becomes:
#'
#'       4     5  5
#'       9     0  0
#'       4     0  3
#'     0 ......+...
#'     1 ..........
#'     2 ..........
#'     3 ..........
#'     4 ....#...##
#'     5 ....#...#.
#'     6 ..###...#.
#'     7 ........#.
#'     8 ........#.
#'     9 #########.
#'
#' Sand is produced *one unit at a time*, and the next unit of sand is not
#' produced until the previous unit of sand *comes to rest*. A unit of sand
#' is large enough to fill one tile of air in your scan.
#'
#' A unit of sand always falls *down one step* if possible. If the tile
#' immediately below is blocked (by rock or sand), the unit of sand
#' attempts to instead move diagonally *one step down and to the left*. If
#' that tile is blocked, the unit of sand attempts to instead move
#' diagonally *one step down and to the right*. Sand keeps moving as long
#' as it is able to do so, at each step trying to move down, then
#' down-left, then down-right. If all three possible destinations are
#' blocked, the unit of sand *comes to rest* and no longer moves, at which
#' point the next unit of sand is created back at the source.
#'
#' So, drawing sand that has come to rest as `o`, the first unit of sand
#' simply falls straight down and then stops:
#'
#'     ......+...
#'     ..........
#'     ..........
#'     ..........
#'     ....#...##
#'     ....#...#.
#'     ..###...#.
#'     ........#.
#'     ......o.#.
#'     #########.
#'
#' The second unit of sand then falls straight down, lands on the first
#' one, and then comes to rest to its left:
#'
#'     ......+...
#'     ..........
#'     ..........
#'     ..........
#'     ....#...##
#'     ....#...#.
#'     ..###...#.
#'     ........#.
#'     .....oo.#.
#'     #########.
#'
#' After a total of five units of sand have come to rest, they form this
#' pattern:
#'
#'     ......+...
#'     ..........
#'     ..........
#'     ..........
#'     ....#...##
#'     ....#...#.
#'     ..###...#.
#'     ......o.#.
#'     ....oooo#.
#'     #########.
#'
#' After a total of 22 units of sand:
#'
#'     ......+...
#'     ..........
#'     ......o...
#'     .....ooo..
#'     ....#ooo##
#'     ....#ooo#.
#'     ..###ooo#.
#'     ....oooo#.
#'     ...ooooo#.
#'     #########.
#'
#' Finally, only two more units of sand can possibly come to rest:
#'
#'     ......+...
#'     ..........
#'     ......o...
#'     .....ooo..
#'     ....#ooo##
#'     ...o#ooo#.
#'     ..###ooo#.
#'     ....oooo#.
#'     .o.ooooo#.
#'     #########.
#'
#' Once all *`24`* units of sand shown above have come to rest, all further
#' sand flows out the bottom, falling into the endless void. Just for fun,
#' the path any new sand takes before falling forever is shown here with
#' `~`:
#'
#'     .......+...
#'     .......~...
#'     ......~o...
#'     .....~ooo..
#'     ....~#ooo##
#'     ...~o#ooo#.
#'     ..~###ooo#.
#'     ..~..oooo#.
#'     .~o.ooooo#.
#'     ~#########.
#'     ~..........
#'     ~..........
#'     ~..........
#'
#' Using your scan, simulate the falling sand. *How many units of sand come
#' to rest before sand starts flowing into the abyss below?*
#'
#' **Part Two**

#' You realize you misread the scan. There isn\'t an [endless
#' void]{title="Endless Void is my C cover band."} at the bottom of the
#' scan - there\'s floor, and you\'re standing on it!
#'
#' You don\'t have time to scan the floor, so assume the floor is an
#' infinite horizontal line with a `y` coordinate equal to *two plus the
#' highest `y` coordinate* of any point in your scan.
#'
#' In the example above, the highest `y` coordinate of any point is `9`,
#' and so the floor is at `y=11`. (This is as if your scan contained one
#' extra rock path like `-infinity,11 -> infinity,11`.) With the added
#' floor, the example above now looks like this:
#'
#'             ...........+........
#'             ....................
#'             ....................
#'             ....................
#'             .........#...##.....
#'             .........#...#......
#'             .......###...#......
#'             .............#......
#'             .............#......
#'             .....#########......
#'             ....................
#'     <-- etc #################### etc -->
#'
#' To find somewhere safe to stand, you\'ll need to simulate falling sand
#' until a unit of sand comes to rest at `500,0`, blocking the source
#' entirely and stopping the flow of sand into the cave. In the example
#' above, the situation finally looks like this after *`93`* units of sand
#' come to rest:
#'
#'     ............o............
#'     ...........ooo...........
#'     ..........ooooo..........
#'     .........ooooooo.........
#'     ........oo#ooo##o........
#'     .......ooo#ooo#ooo.......
#'     ......oo###ooo#oooo......
#'     .....oooo.oooo#ooooo.....
#'     ....oooooooooo#oooooo....
#'     ...ooo#########ooooooo...
#'     ..ooooo.......ooooooooo..
#'     #########################
#'
#' Using your scan, simulate the falling sand until the source of the sand
#' becomes blocked. *How many units of sand come to rest?*
#'
#' @param x some data
#' @return For Part One, `f14a(x)` returns .... For Part Two,
#'   `f14b(x)` returns ....
#' @export
#' @examples
#' f14a(example_data_14())
#' f14b()
f14a <- function(x) {
  allrocks <- lapply(x, rocks)
  cave <- matrix(".", nrow = 200, ncol = 1500)
  for (r in allrocks) {
    for (rr in seq_along(r[-1])) {
      f <- fill_rocks(r[rr], r[rr+1])
      cave[f] <- "#"
    }
  }
  done <- FALSE
  while(!done) {
    cave <- fall(cave, c(1, 500+500))
    done <- cave[matrix(c(1,1), ncol = 2)] == "X"
  }
  sum(cave == "o")
}


#' @rdname day14
#' @export
f14b <- function(x) {
  allrocks <- lapply(x, rocks)
  cave <- matrix(".", nrow = 200, ncol = 1500)
  for (r in allrocks) {
    for (rr in seq_along(r[-1])) {
      f <- fill_rocks(r[rr], r[rr+1])
      cave[f] <- "#"
    }
  }
  lowest_per_col <- apply(cave, 2, \(y) which.max(y == "#"))
  floor <- max(lowest_per_col) + 2
  ## offset by 1 since fill_rocks offsets, too
  f <- fill_rocks(list(c(1, floor-1)), list(c(1500, floor-1)))
  cave[f] <- "#"

  done <- FALSE
  while(!done) {
    cave <- fall(cave, c(1, 500+500), crit = "full")
    done <- cave[matrix(c(1,1), ncol = 2)] == "X"
  }
  sum(cave == "o")
}

fall <- function(cave, sand, crit = "fall") {
  down <- c(sand[1]+1, sand[2])
  if (crit == "fall" && down[1] > 200) {
    cave[matrix(c(1,1), ncol = 2)] <- "X"
    return(cave)
  } else if (blocked(cave, c(1, 500+500))) {
    sandmat <<- rbind(sandmat, c(1, 500+500))
    cave[matrix(c(1,500+500), ncol = 2)] <- "o"
    cave[matrix(c(1,1), ncol = 2)] <- "X"
    return(cave)
  }
  if (blocked(cave, down)) {
    downleft <- c(sand[1]+1, sand[2]-1)
    if (blocked(cave, downleft)) {
      downright <- c(sand[1]+1, sand[2]+1)
      if (blocked(cave, downright)) {
        sandmat <<- rbind(sandmat, sand)
        cave[matrix(sand, ncol = 2)] <- "o"
      } else {
        return(fall(cave, downright))
      }
    } else {
      return(fall(cave, downleft))
    }
  } else {
    return(fall(cave, down))
  }
  return(cave)
}

blocked <- function(cave, x) {
  cave[matrix(x, ncol = 2)] %in% c("#", "o")
}

rocks <- function(x) {
  rocks <- strsplit(x, " -> ")[[1]]
  rocks <- strsplit(rocks, ",")
  for (r in seq_along(rocks)) {
    rocks[[r]] <- as.integer(rocks[[r]])
    rocks[[r]][1] <- rocks[[r]][1] + 500
  }
  rocks
}

fill_rocks <- function(x, y) {
  x <- x[[1]]
  x[2] <- x[2] + 1
  y <- y[[1]]
  y[2] <- y[2] + 1
  # horizontal
  if (x[1] == y[1]) {
    span <- x[2]:y[2]
    return(matrix(c(span, rep(x[1], length(span))), ncol = 2, byrow = FALSE))
  }
  # vertical
  if (x[2] == y[2]) {
    span <- x[1]:y[1]
    return(matrix(c(rep(x[2], length(span)), span), ncol = 2, byrow = FALSE))
  }
}

sandmat <- matrix(ncol = 2, nrow = 0)

plot_cave <- function(cave, scale = 2) {
  floor <- which(cave[, 1] == "#")
  # min_x <- min(unlist(apply(cave[-floor, ], 1, \(y) which(y == "#")))) # 959
  # max_x <- max(unlist(apply(cave[-floor, ], 1, \(y) which(y == "#")))) # 1017
  cavedf <- reshape2::melt(cave)
  sanddf <- as.data.frame(sandmat)
  sanddf$id <- 1:nrow(sanddf)
  library(ggplot2)
  # library(gganimate)
  p <- ggplot(cavedf, aes(Var2, Var1, fill = value)) +
    geom_tile() +
    geom_point(data = sanddf, aes(V2, V1, color = id), shape = 15, size = 1, inherit.aes = FALSE) +
    scale_fill_manual(values = c("." = "black", "#" = "brown", "o" = "yellow")) +
    # coord_cartesian(xlim = c(950, 1020), ylim = c(180, 0)) +
    xlim(950, 1020) +
    ylim(180, 0) +
    coord_equal() +
    theme_void() +
    scale_color_viridis_c() +
    # theme(aspect.ratio = 1) +
    guides(fill = "none", color = "none") #+
    # transition_reveal(id) +
    # shadow_mark(past = TRUE, future = FALSE)
  ggsave(filename = "inst/vis-day14.png", dpi = 200, height = 1600, width = 800, units = "px", bg = "black")
  # animate(p, end_pause = 10, nframes = round(nrow(sanddf)/100))
  # anim_save(filename = "inst/vis-day14.gif")
}


#' @param example Which example data to use (by position or name). Defaults to
#'   1.
#' @rdname day14
#' @export
example_data_14 <- function(example = 1) {
  l <- list(
    a = c(
          "498,4 -> 498,6 -> 496,6",
          "503,4 -> 502,4 -> 502,9 -> 494,9"
    )
  )
  l[[example]]
}
