import 'dart:io';
import 'dart:math';

Future<void> main() async {
    try {
        final File file = File('input');
        final String fileContent = await file.readAsString();

        final List<List<String>> splittedString = fileContent
            .split('\n\n')
            .map((e) => e.split('\n'))
            .toList();

        final Iterable<List<int>> splittedInt = splittedString
            .map((list) => 
                    list
                    .where((str) => str.isNotEmpty)
                    .map(int.parse)
                    .toList()
                );

        final Iterable<int> sumList = splittedInt
            .map((group) => group.reduce((value, element) => value + element));

        final int biggestSum = sumList
            .reduce(max);

        print(biggestSum);
    } on FormatException catch (_e, s) {
        print('Invalid integer literal : $s');
    }
}
