import 'package:flutter/material.dart';

/// App-wide theme mode. Changing this value rebuilds [MaterialApp].
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: Colors.lightBlue,
  brightness: Brightness.light,
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: Colors.deepPurple,
  brightness: Brightness.dark,
);

/// AppBar button that switches between light and dark mode.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      tooltip: isDark ? 'Light Mode' : 'Dark Mode',
      icon: Icon(
        isDark ? Icons.light_mode_sharp : Icons.dark_mode_sharp,
        size: 25,
        color: isDark ? Colors.orange : null,
      ),
      onPressed: () =>
          themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark,
    );
  }
}
