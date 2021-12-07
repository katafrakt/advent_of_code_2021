import std.stdio;
import std.file;
import std.conv;
import std.algorithm.searching;
import std.array;
import std.algorithm;
import std.math;
import std.functional;

ulong triangle(ulong n) @safe {
    return n < 2 ? 1 : n + memoize!triangle(n - 1);
}

void calculate(int part) {
  auto input = readText("input");
  auto numbers = input.split(",").map!(x => to!int(x));
  auto max = maxElement(numbers);
  ulong currentMinFuel = 0;
  for(int i = 0; i < max; i++) {
    ulong currentFuel = 0;
    for(int y = 0; y < numbers.length; y++) {
      if(part == 2) {
        currentFuel += triangle(abs(numbers[y] - i));
      } else {
        currentFuel += abs(numbers[y] - i);
      }
    }
    if(currentMinFuel == 0 || currentFuel < currentMinFuel) currentMinFuel = currentFuel;
  }
  writeln(currentMinFuel);
}

void main() {
  calculate(1);
  calculate(2);
}