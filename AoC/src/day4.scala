class Board(val input: Array[Array[Int]]):
  var t = false
  def searchVertical(col: Int): Boolean = input.forall(_(col) == -1)
  def searchHorizontal(row: Int): Boolean = input(row).forall(_ == -1)
  def mark(n: Int): Boolean =
    for (i <- input.indices; j <- input(i).indices if input(i)(j) == n)
      input(i)(j) = -1
      if (searchVertical(j) || searchHorizontal(i)) return true
    false
  def unmarkedSum = input.flatten.filter(_ != -1).sum

@main def main =
  val input = io.Source.fromFile("input/day4").getLines().toSeq
  val nums = input.head.split(",").map(_.toInt)
  val boards = input
    .drop(2)
    .grouped(6)
    .map(x =>
      new Board(x.take(5).map("""\s+""".r.split(_).filterNot(_.isEmpty).map(_.toInt)).toArray)
    )
    .toArray
  println(s"part 1: ${part1(nums, boards.clone)}")
  println(s"part 2: ${part2(nums, boards.clone)}")

def part1(nums: Array[Int], boards: Array[Board]): Int =
  for (n <- nums)
    boards.find(_.mark(n)) match
      case Some(board) =>
        return board.unmarkedSum * n.toInt
      case None =>
  -1

def part2(nums: Array[Int], boards: Array[Board]) =
  var last: Option[Int] = None
  for (n <- nums)
    boards
      .filter(b => !b.t && b.mark(n.toInt))
      .foreach(b =>
        b.t = true
        last = Some(n.toInt * b.unmarkedSum)
      )
  last.getOrElse(-1)
