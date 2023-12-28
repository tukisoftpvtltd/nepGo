
String capitalize(String input) {
  if (input == null || input.isEmpty) return '';

  List<String> words = input.split(' ');
  List<String> capitalizedWords = [];

  for (String word in words) {
    if (word.isNotEmpty) {
      String capitalizedWord = word[0].toUpperCase() + word.substring(1);
      capitalizedWords.add(capitalizedWord);
    }
  }

  return capitalizedWords.join(' ');
}