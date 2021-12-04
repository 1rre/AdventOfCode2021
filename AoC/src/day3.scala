/*
@main def main =
  val input = io.Source.fromFile("input/day3_sample").getLines().toSeq
  val part1 = input.map(_.map(_ - '0')).reduce((x, y) => x.zip(y).map(z => z._1 + z._2)).foldLeft(Seq(0, 0))((x, y) => if (y > input.size / 2d) Seq((x(0) << 1) + 1, x(1) << 1) else Seq(x(0) << 1, (x(1) << 1) + 1)).product
  println(s"part1: $part1")
  val part2 = input.map(a => input.map(_.map(_ - '0')).reduce((x, y) => x.zip(y).map(z => z._1 + z._2)).map(x => if (x > input.size / 2d) (1, 0) else if (x == input.size / 2d) (1, 1)else (0, 1)).zip(a.map(_ - '0'))).map(_.map(n => ((n._1._1, n._2), (n._1._2, n._2))).unzip).unzip.productIterator.map(_.asInstanceOf[::[Seq[(Int, Int)]]].maxBy(_.span(x => x._1 == x._2)._1.length).foldLeft(0)(_*2+_._2)).product
  println(s"part2: $part2")
*/