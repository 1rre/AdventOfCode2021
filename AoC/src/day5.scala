
@main def day5 =
  def parseLine(l: String) =
    val Array(a,b) = l.split("->")
    val Array(x1,y1) = a.split(",").map(_.trim.toInt)
    val Array(x2,y2) = b.split(",").map(_.trim.toInt)
    ((x1,y1),(x2,y2))
  val input = io.Source.fromFile("input/day5")
    .getLines
    .map(parseLine)
    .toSeq

  def part1 =
    def rangePos(a: Int, b: Int) = (a min b) to (a max b)
    val points = collection.mutable.TreeMap[(Int, Int), Int]()
    for (((x1,y1),(x2,y2)) <- input)
      if (x1 == x2) rangePos(y1, y2) map (y => points((x1, y)) = points.getOrElse((x1, y), 0) + 1)
      else if (y1 == y2) rangePos(x1, x2) map (x => points((x, y1)) = points.getOrElse((x, y1), 0) + 1)
    points.values.filter(_ > 1).size

  def part2 =
    def rangePos(a: Int, b: Int) = (a min b) to (a max b)
    def rangeDiag(x1: Int, y1: Int, x2: Int, y2: Int) =
      val r1 = if (x1 < x2) x1 to x2 else x1 to x2 by -1
      val r2 = if (y1 < y2) y1 to y2 else y1 to y2 by -1
      r1 zip r2
    val points = collection.mutable.TreeMap[(Int, Int), Int]()
    for (((x1,y1),(x2,y2)) <- input)
      if (x1 == x2) rangePos(y1, y2) map (y => points((x1, y)) = points.getOrElse((x1, y), 0) + 1)
      else if (y1 == y2) rangePos(x1, x2) map (x => points((x, y1)) = points.getOrElse((x, y1), 0) + 1)
      else rangeDiag(x1, y1, x2, y2) map (x => points(x) = points.getOrElse(x, 0) + 1)
    points.values.filter(_ > 1).size

  
  val p1s = java.lang.System.nanoTime
  val p1 = part1
  val p1e = java.lang.System.nanoTime
  println(s"part 1: $p1, took: ${(p1e-p1s)/1e9}s")
  val p2s = java.lang.System.nanoTime
  val p2 = part2
  val p2e = java.lang.System.nanoTime
  println(s"part 2: $p2, took: ${(p2e-p2s)/1e9}s")
    