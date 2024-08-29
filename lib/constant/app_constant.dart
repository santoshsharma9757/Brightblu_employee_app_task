import 'package:flutter/material.dart';

// Font weights
class AppFontWeight {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight heavy = FontWeight.w900;
   static const Color lightBlue= Color(0xFFD6E9F7);
}

// Colors
class AppColors {
  static const Color primary = Color(0xFFF603D0);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color blue = Color(0xFF2196F3);
  static const Color purple = Color(0xFFA25DEC);
  static const Color amountCard = Color(0xFF2A2A30);
  static  Color grey = Colors.grey.withOpacity(0.2);
  static const Color green = Colors.green;
  static const Color orange = Colors.deepOrange;
   static const Color red = Colors.red;
  static const Color teal=Colors.teal;
  static const Color lightBlue= Color(0xFFD6E9F7);
  static const Color lightOrange= Color(0xFFF8E1CE);

  static MaterialColor customColor = MaterialColor(
    0xFFF603D0,
    <int, Color>{
      50: const Color(0xFFF603D0).withOpacity(0.1),
      100: const Color(0xFFF603D0).withOpacity(0.2),
      200: const Color(0xFFF603D0).withOpacity(0.3),
      300: const Color(0xFFF603D0).withOpacity(0.4),
      400: const Color(0xFFF603D0).withOpacity(0.5),
      500: const Color(0xFFF603D0),
      600: const Color(0xFFF603D0).withOpacity(0.7),
      700: const Color(0xFFF603D0).withOpacity(0.8),
      800: const Color(0xFFF603D0).withOpacity(0.9),
      900: const Color(0xFFF603D0).withOpacity(1.0),
    },
  );
}

class AppSpacing {
  // Horizontal spacing
  static const SizedBox horizontalExtraSmall = SizedBox(width: 5.0);
  static const SizedBox horizontalSmall = SizedBox(width: 8.0);
  static const SizedBox horizontalMedium = SizedBox(width: 16.0);
  static const SizedBox horizontalLarge = SizedBox(width: 32.0);

  // Vertical spacing
  static const SizedBox verticalExtraSmall = SizedBox(height: 4.0);
  static const SizedBox verticalSmall = SizedBox(height: 8.0);
  static const SizedBox verticalMedium = SizedBox(height: 16.0);
  static const SizedBox verticalLarge = SizedBox(height: 32.0);

  // Dynamic spacing
  static SizedBox horizontal(double width) => SizedBox(width: width);
  static SizedBox vertical(double height) => SizedBox(height: height);
}

// Paddings
class AppPadding {
  static const double extrasmall = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 32.0;
}

// Margins
class AppMargin {
  static const double veryExtraSmall = 2.0;
  static const double extraSmall = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 32.0;
}

// Border radii
class AppBorderRadius {
  static const Radius small = Radius.circular(4.0);
  static const Radius medium = Radius.circular(8.0);
  static const Radius large = Radius.circular(16.0);
  static const Radius extraLarge = Radius.circular(32.0);
  static const double circleAvatarRadiusSmall = 30;
  static const double circleAvatarRadius = 40;
}

// Elevations
class AppElevation {
  static const double low = 2.0;
  static const double medium = 6.0;
  static const double high = 12.0;
}

// Thicknesses
class AppThickness {
  static const double thin = 1.0;
  static const double medium = 2.0;
  static const double thick = 4.0;
}

// Icon Sizes
class AppIconSize {
  static const double extrasmall = 8.0;
  static const double small = 16.0;
  static const double medium = 24.0;
  static const double large = 32.0;
  static const double extraLarge = 48.0;
}
