import 'dart:io';

void main() async {
  print(await part1());
  print(await part2());
}

Future<int?> part1() async {
  final List<String> input = (await File('input').readAsString()).split('');
  return solve(input, 4);
}

Future<int?> part2() async {
  final List<String> input = (await File('input').readAsString()).split('');
  return solve(input, 14);
}

int? solve(List<String> input, int distinctCharacters) {
  int i = 0;

  while (i < input.length) {
    final end = i + distinctCharacters < input.length ? i + distinctCharacters : input.length - 1;
    final Set<String> subSet = input.sublist(i, end).toSet();
    final bool allCharDifferent = subSet.length == distinctCharacters;

    if (allCharDifferent) return end;

    i++;
  }

  return null;
}
