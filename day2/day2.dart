import 'dart:io';

void main() async {
  print(await part1());
  print(await part2());
}

Future<int> part1() async {
  final List<String> rounds = await input.readAsLines();
  final File input = File('input');
  int score = 0;

  rounds.forEach((round) {
    final List<String> shapes = round.split(' ');

    if (shapes.length != 2) {
      throw Exception('Invalid input');
    }

    final String opponent = shapes[0];
    final String player = shapes[1];

    final bool draw = player == 'X' && opponent == 'A' ||
        player == 'Y' && opponent == 'B' ||
        player == 'Z' && opponent == 'C';
    final bool win = player == 'X' && opponent == 'C' ||
        player == 'Y' && opponent == 'A' ||
        player == 'Z' && opponent == 'B';

    if (draw) {
      score += 3;
    } else if (win) {
      score += 6;
    }

    switch (player) {
      case 'X':
        score += 1;
        break;
      case 'Y':
        score += 2;
        break;
      case 'Z':
        score += 3;
        break;
      default:
        throw Exception('Invalid character');
    }
  });

  return score;
}

Future<int> part2() async {
  final File input = File('input');
  final List<String> rounds = await input.readAsLines();

  int totalScore = 0;

  final Map<String, int> scoringTable = {
    "A X": 3,
    "A Y": 4,
    "A Z": 8,
    "B X": 1,
    "B Y": 5,
    "B Z": 9,
    "C X": 2,
    "C Y": 6,
    "C Z": 7,
  };

  rounds.forEach((round) {
    int? score = scoringTable[round];
    if (score == null) {
      throw Exception('Invalid input');
    }
    totalScore += score;
  });

  return totalScore;
}
