import scala.io.Source

@main def run =
  val measurements = Source.fromFile("input").getLines.toList.map(i => i.toInt)
  val accumulator = (measurements.max + 1, 0)

  def countDecreases(acc: (Int, Int), depth: Int): (Int, Int) =
    val count = if depth > acc(0) then acc(1) + 1 else acc(1)
    (depth, count)
  
  println(measurements.foldLeft(accumulator)(countDecreases)(1))

  val windows = measurements.take(measurements.size - 2).zipWithIndex.map((element, index) => element + measurements(index + 1) + measurements(index + 2))
  val accumulator2 = (windows.max + 1, 0)
  println(windows.foldLeft(accumulator2)(countDecreases)(1))