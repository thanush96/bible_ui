part of values;

class AppColors {
  static List<List<Color>> ballColors = [
    [
      HexColor.fromHex("87D3DF"),
      HexColor.fromHex("DEABEF"),
    ],
    [
      HexColor.fromHex("FC946E"),
      HexColor.fromHex("FFD996"),
    ],
    [
      HexColor.fromHex("87C76F"),
      HexColor.fromHex("87C76F"),
    ],
    [
      HexColor.fromHex("E7B2EF"),
      HexColor.fromHex("EEFCCF"),
    ],
    [
      HexColor.fromHex("8CE0DF"),
      HexColor.fromHex("8CE0DF"),
    ],
    [
      HexColor.fromHex("353645"),
      HexColor.fromHex("1E2027"),
    ],
    [
      HexColor.fromHex("FDA7FF"),
      HexColor.fromHex("FDA7FF"),
    ],
    [
      HexColor.fromHex("899FFE"),
      HexColor.fromHex("899FFE"),
    ],
    [
      HexColor.fromHex("FC946E"),
      HexColor.fromHex("FFD996"),
    ],
    [
      HexColor.fromHex("87C76F"),
      HexColor.fromHex("87C76F"),
    ],
  ];

  // static final Color red = HexColor.fromHex("920d1b");
  // static final Color yellow = HexColor.fromHex("f5f5dc");
  // static final Color white = HexColor.fromHex("FFFFFF");

  static Color primaryColor = HexColor.fromHex("#b3282e");
  static final Color accentColor = HexColor.fromHex("#ffb548");
  static Color backgroundColor = HexColor.fromHex("#ECECFF");
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color? grey500 = Colors.grey[500];
  static Color? grey700 = Colors.grey[700];
  static Color greyTitle = HexColor.fromHex("#434652");
  static Color titleDivider = HexColor.fromHex("#566F8C");
  static Color scrollbarTrackColor = HexColor.fromHex("#8F96B0");

  static final Color grayFont = HexColor.fromHex("C0C0C0");
  // static final Color darkGray = HexColor.fromHex("949292");
  static final Color darkGray = HexColor.fromHex("bdbdbd");

  // void updateColors(String newPrimaryColor, String newBackgroundColor) {
  //   primaryColor = newPrimaryColor as Color;
  //   backgroundColor = newBackgroundColor as Color;
  //   notifyListeners();
  // }

  // void notifyListeners() {}
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

// ranges from 0.0 to 1.0

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
