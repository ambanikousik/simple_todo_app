import 'package:flutter/material.dart';

extension ThemeExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  LinearGradient get backgroundGradient => LinearGradient(
        colors: [
          const HSLColor.fromAHSL(1, 240, 1, 0.2).toColor(),
          const HSLColor.fromAHSL(1, 289, 1, 0.21).toColor(),
          const HSLColor.fromAHSL(1, 315, 1, 0.27).toColor(),
          const HSLColor.fromAHSL(1, 329, 1, 0.36).toColor(),
          const HSLColor.fromAHSL(1, 337, 1, 0.43).toColor(),
          const HSLColor.fromAHSL(0.91, 357, 1, 0.59).toColor(),
          const HSLColor.fromAHSL(1, 17, 1, 0.59).toColor(),
          const HSLColor.fromAHSL(1, 34, 1, 0.53).toColor(),
          const HSLColor.fromAHSL(1, 45, 1, 0.5).toColor(),
          const HSLColor.fromAHSL(1, 55, 1, 0.5).toColor(),
        ],
        stops: const [
          0.0,
          0.11,
          0.22,
          0.33,
          0.44,
          0.56,
          0.67,
          0.78,
          0.89,
          1.0,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        transform: const GradientRotation(45 * 3.1415926535 / 180),
      );
  // LinearGradient get backgroundGradient => const LinearGradient(
  //       begin: Alignment.topCenter,
  //       end: Alignment.bottomCenter,
  //       colors: [
  //         Color.fromRGBO(61, 37, 38, 1),
  //         Color.fromRGBO(19, 21, 31, 1),
  //       ],
  //     );
}
