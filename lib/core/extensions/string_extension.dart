extension StringExtension on String {
  int hexColor() {
    var newColor = '0xff$this';
    newColor = newColor.replaceAll('#', '');

    return int.parse(newColor);
  }
}
