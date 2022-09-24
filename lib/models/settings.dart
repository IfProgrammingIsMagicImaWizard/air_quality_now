import 'dart:ui';

class Settings {
  final bool showClassificationBar;
  final bool darkMode;
  final bool hideBackground;
  final bool dismissDisclaimer;
  final Size size;
  final String? lastValidToken;
  final bool autoChangeTheme;

  Settings({
    required this.showClassificationBar,
    required this.darkMode,
    required this.hideBackground,
    required this.dismissDisclaimer,
    this.size = const Size(385, 740),
    this.lastValidToken,
    required this.autoChangeTheme,
  });

  copyWith({
    bool? showClassificationBar,
    bool? darkMode,
    bool? hideBackground,
    bool? dismissDisclaimer,
    Size? size,
    String? lastValidToken,
    bool? autoChangeTheme,
  }) {
    return Settings(
        showClassificationBar:
            showClassificationBar ?? this.showClassificationBar,
        darkMode: darkMode ?? this.darkMode,
        hideBackground: hideBackground ?? this.hideBackground,
        dismissDisclaimer: dismissDisclaimer ?? this.dismissDisclaimer,
        size: size ?? this.size,
        lastValidToken: lastValidToken ?? this.lastValidToken,
        autoChangeTheme: autoChangeTheme ?? this.autoChangeTheme);
  }

  Map<String, dynamic> toJson() => {
        'showClassificationBar': showClassificationBar,
        'darkMode': darkMode,
        'hideBackground': hideBackground,
        'dismissDisclaimer': dismissDisclaimer,
        'size': [size.width, size.height],
        'lastValidToken': lastValidToken,
        'autoChangeTheme': autoChangeTheme,
      };

  Settings.fromJson(Map<String, dynamic> json)
      : showClassificationBar = json['showClassificationBar'],
        darkMode = json['darkMode'],
        hideBackground = json['hideBackground'],
        dismissDisclaimer = json['dismissDisclaimer'],
        size = Size(json['size'][0], json['size'][1]),
        lastValidToken = json['lastValidToken'],
        autoChangeTheme = json['autoChangeTheme'];
}
