import 'dart:io';

void main() async {
  print(await part1());
  print(await part2());
}

Future<int> part1() async {
  final List<List<int>> input = (await File('input').readAsLines())
      .map((e) => e.split('').map((e) => int.parse(e)).toList())
      .toList();
  int visibleTrees = 0;

  for (int i = 0; i < input.length; i++) {
    for (int j = 0; j < input[i].length; j++) {
      if (isVisible(input, i, j)) visibleTrees++;
    }
  }

  return visibleTrees;
}

bool isVisible(List<List<int>> input, int line, int column) {
  final int treeSize = input[line][column];
  bool visibleFromTop = true;
  bool visibleFromRight = true;
  bool visibleFromBottom = true;
  bool visibleFromLeft = true;
  int i;

  // Visible from the top
  i = line - 1;
  while (i >= 0) {
    if (input[i][column] >= treeSize) {
      visibleFromTop = false;
      break;
    }
    i--;
  }

  // Visible from the right
  i = column + 1;
  while (i < input[line].length) {
    if (input[line][i] >= treeSize) {
      visibleFromRight = false;
      break;
    }
    i++;
  }

  // Visible from the bottom
  i = line + 1;
  while (i < input.length) {
    if (input[i][column] >= treeSize) {
      visibleFromBottom = false;
      break;
    }
    i++;
  }

  // Visible from the left
  i = column - 1;
  while (i >= 0) {
    if (input[line][i] >= treeSize) {
      visibleFromLeft = false;
      break;
    }
    i--;
  }

  return visibleFromTop ||
      visibleFromRight ||
      visibleFromBottom ||
      visibleFromLeft;
}

Future<int> part2() async {
  final List<List<int>> input = (await File('input').readAsLines())
      .map((e) => e.split('').map((e) => int.parse(e)).toList())
      .toList();
  int highestScore = 0;

  for (int i = 0; i < input.length; i++) {
    for (int j = 0; j < input[i].length; j++) {
      final int score = getScore(input, i, j);
      if (score > highestScore) highestScore = score;
    }
  }

  return highestScore;
}

int getScore(List<List<int>> input, int line, int column) {
  final int treeSize = input[line][column];
  int topScore = 0;
  int rightScore = 0;
  int bottomScore = 0;
  int leftScore = 0;
  int i;

  // Visible from the top
  i = line - 1;
  while (i >= 0) {
    topScore++;
    if (input[i][column] >= treeSize) break;
    i--;
  }

  // Visible from the right
  i = column + 1;
  while (i < input[line].length) {
    rightScore++;
    if (input[line][i] >= treeSize) break;
    i++;
  }

  // Visible from the bottom
  i = line + 1;
  while (i < input.length) {
    bottomScore++;
    if (input[i][column] >= treeSize) break;
    i++;
  }

  // Visible from the left
  i = column - 1;
  while (i >= 0) {
    leftScore++;
    if (input[line][i] >= treeSize) break;
    i--;
  }

  return topScore * rightScore * bottomScore * leftScore;
}
