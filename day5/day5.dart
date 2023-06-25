import 'dart:io';

void main() async {
  print(await part1());
  print(await part2());
}

Future<String> part1() async {
  final List<String> input = await File('input').readAsLines();
  final List<List<String>> stacks = getStacks(input);
  String topCrates = '';
  int firstMoveLine = 0;

  while (!input[firstMoveLine].isEmpty) {
    firstMoveLine++;
  }
  firstMoveLine++;

  int currentMoveLine = firstMoveLine;
  ({int quantity, int from, int to}) moveInfo;

  while (currentMoveLine < input.length) {
    moveInfo = getMoveInfo(input[currentMoveLine]);

    for (int i = 0; i < moveInfo.quantity; i++) {
      final int? indexOrigin = getTopCrateIndex(stacks, moveInfo.from);

      if (indexOrigin == null) break;

      String crate = stacks[moveInfo.from][indexOrigin];
      stacks[moveInfo.from].removeLast();
      stacks[moveInfo.to].add(crate);
    }

    currentMoveLine++;
  }

  topCrates = concatTopCrates(stacks);

  return topCrates;
}

Future<String> part2() async {
  final List<String> input = await File('input').readAsLines();
  final List<List<String>> stacks = getStacks(input);
  String topCrates = '';
  int firstMoveLine = 0;

  while (!input[firstMoveLine].isEmpty) {
    firstMoveLine++;
  }
  firstMoveLine++;

  int currentMoveLine = firstMoveLine;
  ({int quantity, int from, int to}) moveInfo;

  while (currentMoveLine < input.length) {
    moveInfo = getMoveInfo(input[currentMoveLine]);

    List<String> movedCrates = List.empty(growable: true);

    for (int i = 0; i < moveInfo.quantity; i++) {
      final int? indexOrigin = getTopCrateIndex(stacks, moveInfo.from);

      if (indexOrigin == null) break;

      movedCrates.insert(0, stacks[moveInfo.from][indexOrigin]);
      stacks[moveInfo.from].removeLast();
    }

    stacks[moveInfo.to].addAll(movedCrates);

    currentMoveLine++;
  }

  topCrates = concatTopCrates(stacks);

  return topCrates;
}

List<List<String>> getStacks(List<String> input) {
  final List<List<String>> stacks = [];
  int bottomCrateLine = 0;

  while (input[bottomCrateLine + 1][1] != '1') bottomCrateLine++;

  final int numberOfStacks = (input[bottomCrateLine].length + 1) ~/ 4;

  for (int i = 0; i < numberOfStacks; i++) {
    int crateLineIndex = bottomCrateLine;
    final int crateColumnIndex = i * 4 + 1;
    List<String> stack = [];

    while (
        crateLineIndex >= 0 && input[crateLineIndex][crateColumnIndex] != ' ') {
      stack.add(input[crateLineIndex][crateColumnIndex]);
      crateLineIndex--;
    }

    stacks.add(stack);
  }

  return stacks;
}

({int quantity, int from, int to}) getMoveInfo(String move) {
  List<String> splitString = move.split(' ');
  return (
    quantity: int.parse(splitString[1]),
    from: int.parse(splitString[3]) - 1,
    to: int.parse(splitString[5]) - 1
  );
}

int? getTopCrateIndex(List<List<String>> stacks, int stackIndex) {
  if (stacks[stackIndex].isEmpty) return null;

  int topCrateIndex = 0;

  while (topCrateIndex + 1 < stacks[stackIndex].length &&
      stacks[stackIndex][topCrateIndex + 1] != ' ') {
    topCrateIndex++;
  }

  return topCrateIndex;
}

String concatTopCrates(List<List<String>> stacks) {
  String topCrates = '';
  stacks.forEach((stack) {
    if (stack.isEmpty) return;
    topCrates += stack[stack.length - 1];
  });
  return topCrates;
}
