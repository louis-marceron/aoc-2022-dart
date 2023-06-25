import 'dart:io';

void main() async {
  print(await part1());
  print(await part2());
}

Future<int> part1() async {
  final File input = File('input');
  final List<String> rucksacks = await input.readAsLines();
  final int sumOfCommonPriorities = rucksacks
      .map((rucksack) => getCommonItem(rucksack))
      .reduce((total, priority) => total + priority);

  return sumOfCommonPriorities;
}

int getCommonItem(String rucksack) {
  final List<int> itemsPriority = convertToPriorities(rucksack);
  final int halfIndex = itemsPriority.length ~/ 2;
  final List<int> firstHalf = itemsPriority.sublist(0, halfIndex);
  final List<int> secondHalf = itemsPriority.sublist(halfIndex);
  final List<int> commonItem =
      firstHalf.toSet().intersection(secondHalf.toSet()).toList();

  if (commonItem.length != 1) {
    throw Exception(
        'Invalid input: there must be exactly one common item between the two compartments');
  }

  return commonItem[0];
}

List<int> convertToPriorities(String rucksack) {
  if (rucksack.length % 2 != 0)
    throw Exception('The number of items must be even');

  final List<int> codeUnits = rucksack.codeUnits;

  final List<int> priorities = codeUnits.map((codeUnit) {
    // A-Z
    if (codeUnit >= 65 && codeUnit <= 90) return codeUnit - 38;

    // a-z
    if (codeUnit >= 97 && codeUnit <= 122)
      return codeUnit - 96;
    else
      throw Exception('The item\'s name must be a letter between a-z or A-Z');
  }).toList();

  return priorities;
}

Future<int> part2() async {
  final File input = File('input');
  final List<String> rucksacks = await input.readAsLines();
  int i = 0;
  int total = 0;

  while (i < rucksacks.length) {
    total += convertToPriorities(rucksacks[i])
        .toSet()
        .intersection(convertToPriorities(rucksacks[i + 1]).toSet())
        .intersection(convertToPriorities(rucksacks[i + 2]).toSet())
        .toList()[0];

    i += 3;
  }

  return total;
}
