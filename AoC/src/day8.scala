import collection.mutable.Set

val nums = Vector(
  Vector(0,1,2,3,4,5),
  Vector(1,2),
  Vector(0,1,3,4,6),
  Vector(0,1,2,3,6),
  Vector(1,2,5,6),
  Vector(0,2,3,5,6),
  Vector(0,2,3,4,5,6),
  Vector(0,1,2),
  Vector(0,1,2,3,4,5,6),
  Vector(0,1,2,3,5,6)
)

class Segment {
  val options = Vector.fill(7)(Set.from('a' to 'g'))
  def rmDups =
    for (i <- options.indices)
      options(i).filterInPlace(ch =>
        !(options.indices.filterNot(_ == i).exists(j => options(j).size == 1 && (options(j) contains ch)))
      )
  def addChars(s: String) = {
    val enf = nums.filter(_.size == s.size).reduce(_ intersect _)
    for (i <- enf) options(i).filterInPlace(s contains _)
    if (nums.count(_.size == s.size) == 1)
      for (i <- options.indices if !(enf contains i)) options(i) --= s
  }
}

@main def day8 =
  val input = io.Source.fromFile("input/day8").getLines.toArray.map(" \\| ".r.split(_).map(_.split(" ")))
  println(s"Part 1: $part1")
  println(s"Part 2: $part2")

  def part1 =
    input.map(_(1).count(Seq(2,3,4,7) contains _.length)).sum

  def part2 =
    val result = for (Array(in, out) <- input) yield
      val seg = new Segment
      for (s <- in) seg.addChars(s)
      seg.rmDups
      val outNum = out.map(x => nums.indexOf(x.map(y => (seg.options.indexWhere(_ contains y))).toVector.sorted))
      outNum.mkString.toInt
    result.sum