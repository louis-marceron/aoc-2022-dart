import 'dart:io';

void main() async {
  print(await part1());
  print(await part2());
}

Future<int> part1() async {
  File input = File('input');
  List<String> rangesList = await input.readAsLines();
  int numberFullyContained = 0;

  rangesList.forEach((line) {
    List<String> rangesString = line.split(RegExp(r'[-,]'));
    List<int> rangesInt = rangesString.map((e) => int.parse(e)).toList();
    bool firstRangeIsInSecondRange =
        rangesInt[0] >= rangesInt[2] && rangesInt[1] <= rangesInt[3];
    bool secondRangeIsInFirstRange =
        rangesInt[2] >= rangesInt[0] && rangesInt[3] <= rangesInt[1];

    if (firstRangeIsInSecondRange || secondRangeIsInFirstRange)
      numberFullyContained++;
  });

  return numberFullyContained;
}

Future<int> part2() async {
  File input = File('input');
  List<String> rangesList = await input.readAsLines();
  int numberFullyContained = 0;

  rangesList.forEach((line) {
    List<String> rangesString = line.split(RegExp(r'[-,]'));
    List<int> rangesInt = rangesString.map((e) => int.parse(e)).toList();

    if (rangesInt[0] >= rangesInt[2] && rangesInt[0] <= rangesInt[3] ||
        rangesInt[1] >= rangesInt[2] && rangesInt[1] <= rangesInt[3] ||
        rangesInt[2] >= rangesInt[0] && rangesInt[2] <= rangesInt[1] ||
        rangesInt[3] >= rangesInt[0] && rangesInt[3] <= rangesInt[1]) {
      numberFullyContained++;
    }
  });

  return numberFullyContained;
}
