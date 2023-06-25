import 'dart:io';

void main() async {
  print(await part1());
  print(await part2());
}

Future<int> part1() async {
  final List<String> input = await File('input').readAsLines();
  return solve(input.iterator).totalSize;
}

({int totalSize, int dirSize}) solve(Iterator<String> input) {
  int totalSize = 0;
  int dirSize = 0;

  while (input.moveNext() && input.current != '\$ cd ..') {
    final List<String> splitLine = input.current.split(' ');

    if (splitLine[1] == 'cd') {
      var result = solve(input);
      totalSize += result.totalSize;
      dirSize += result.dirSize;
    } else if (splitLine[0] != 'dir' && splitLine[0] != '\$') {
      dirSize += int.parse(splitLine[0]);
    }
  }

  if (dirSize <= 100000) {
    totalSize += dirSize;
  }

  return (totalSize: totalSize, dirSize: dirSize);
}

Future<int> part2() async {
  const DISK_SPACE = 70000000;
  const UNUSED_SPACE_NEEDED = 30000000;
  final List<String> input = await File('input').readAsLines();
  final int sizeToBeDeleted =
      UNUSED_SPACE_NEEDED - (DISK_SPACE - getUsedSpace(input.iterator));

  return solve2(input.iterator, sizeToBeDeleted).sizeDeleted ?? -1;
}

({int dirSize, int? sizeDeleted}) solve2(
    Iterator<String> input, int sizeToBeDeleted) {
  int dirSize = 0;
  int? smallestDir;
  List<int> dirSizeList = List<int>.empty(growable: true);

  while (input.moveNext() && input.current != '\$ cd ..') {
    final List<String> splitLine = input.current.split(' ');

    if (splitLine[1] == 'cd') {
      final result = solve2(input, sizeToBeDeleted);
      final int? sizeDeleted = result.sizeDeleted;

      dirSize += result.dirSize;

      if (sizeDeleted != null) {
        dirSizeList.add(sizeDeleted);
      }
    } else if (splitLine[0] != 'dir' && splitLine[0] != '\$') {
      dirSize += int.parse(splitLine[0]);
    }
  }

  if (dirSize >= sizeToBeDeleted) dirSizeList.add(dirSize);

  if (!dirSizeList.isEmpty) {
    smallestDir = dirSizeList.reduce((curr, next) => curr < next ? curr : next);
  }

  return (dirSize: dirSize, sizeDeleted: smallestDir);
}

int getUsedSpace(Iterator<String> input) {
  int totalSize = 0;

  while (input.moveNext() && input.current != '\$ cd ..') {
    final List<String> splitLine = input.current.split(' ');

    if (splitLine[1] == 'cd') {
      totalSize += getUsedSpace(input);
    } else if (splitLine[0] != 'dir' && splitLine[0] != '\$') {
      totalSize += int.parse(splitLine[0]);
    }
  }

  return totalSize;
}
