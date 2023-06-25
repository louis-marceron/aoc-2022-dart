import 'dart:io';
import 'dart:math';

void main() async {
  print(await part1());
  print(await part2());
}

Future<int> part1() async {
  try {
    final File file = File('input');
    final String fileContent = await file.readAsString();

    final List<List<String>> splittedString =
        fileContent.split('\n\n').map((e) => e.split('\n')).toList();

    final Iterable<List<int>> splittedInt = splittedString.map(
        (list) => list.where((str) => str.isNotEmpty).map(int.parse).toList());

    final Iterable<int> sumList = splittedInt
        .map((group) => group.reduce((value, element) => value + element));

    final int biggestSum = sumList.reduce(max);

    return biggestSum;
  } on FormatException catch (_e, s) {
    print('Invalid integer literal : $s');
    return Future.error('Failed to parse integer: $e');
  } catch (_e, s) {
    return Future.error(s);
  }
}

Future<int> part2() async {
  try {
    final File file = File('input');
    final List<String> calories = await file.readAsLines();
    final List<int> topElves = [];
    int current = 0;

    calories.forEach((calorie) {
      if (calorie.isEmpty) {
        addIfTopElf(topElves, current);
        current = 0;
      } else {
        current += int.parse(calorie);
      }
    });

    final int topElvesCaloriesTotal =
        topElves.reduce((value, element) => value += element);

    return topElvesCaloriesTotal;
  } catch (_e, s) {
    return Future.error(s);
  }
}

void addIfTopElf(List<int> topElves, int elfCalories) {
  try {
    if (topElves.length < 3) {
      topElves.add(elfCalories);
      return;
    }

    int smallestCaloriesIndex = 0;

    for (int i = 0; i < topElves.length; i++) {
      if (topElves[i] < topElves[smallestCaloriesIndex]) {
        smallestCaloriesIndex = i;
      }
    }

    if (elfCalories > topElves[smallestCaloriesIndex]) {
      topElves[smallestCaloriesIndex] = elfCalories;
    }
  } catch (_e, s) {
    print(s);
  }
}
