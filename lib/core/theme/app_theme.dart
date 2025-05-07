import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF8B2232);
  static const Color backgroundColor = Colors.white;
  static const Color messageBackgroundColor = Color(0xFFEEEEEE);
  static const Color textFieldBackgroundColor = Color(0xFFF5F5F5);

  // Text Styles
  static TextStyle get headerTextStyle => GoogleFonts.inter(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      );

  static TextStyle get messageTextStyle => GoogleFonts.inter(
        fontSize: 14.0,
        color: Colors.black87,
      );

  static TextStyle get hintTextStyle => GoogleFonts.inter(
        color: Colors.grey,
        fontSize: 14.0,
      );

  // Dimensions
  static const double chatButtonSizeOpen = 0.0;
  static const double chatButtonSizeClosed = 60.0;
  static const double chatBoxWidth = 400.0;
  static const double chatBoxHeight = 500.0;
  static const double borderRadius = 16.0;
  static const double messageBorderRadius = 12.0;

  // Paddings
  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets chatHeaderPadding =
      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
  static const EdgeInsets chatMessagePadding = EdgeInsets.all(12.0);
  static const EdgeInsets chatInputPadding = EdgeInsets.all(12.0);
  static const EdgeInsets messageBottomPadding = EdgeInsets.only(bottom: 12.0);
  static const EdgeInsets textFieldContentPadding =
      EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsets chatButtonPosition =
      EdgeInsets.only(bottom: 20.0, right: 20.0);
  static const EdgeInsets chatBoxPosition =
      EdgeInsets.only(bottom: 20.0, right: 20.0);
  static const EdgeInsets horizontalSpacing =
      EdgeInsets.symmetric(horizontal: 8.0);

  // Durations
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration slideAnimationDuration = Duration(milliseconds: 400);

  // Decorations
  static final BoxDecoration chatBoxDecoration = BoxDecoration(
    color: backgroundColor,
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: [
      BoxShadow(color: Colors.black26, blurRadius: 10),
    ],
  );

  static const BoxDecoration chatHeaderDecoration = BoxDecoration(
    color: primaryColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
    ),
  );

  static BoxDecoration messageDecoration = BoxDecoration(
    color: messageBackgroundColor,
    borderRadius: BorderRadius.circular(messageBorderRadius),
  );

  static BoxDecoration sendButtonDecoration = const BoxDecoration(
    color: primaryColor,
    shape: BoxShape.circle,
  );

  static BoxDecoration chatInputDecoration = BoxDecoration(
    color: backgroundColor,
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        blurRadius: 4,
        offset: const Offset(0, -2),
      ),
    ],
  );

  static InputDecoration get textFieldDecoration => InputDecoration(
        hintText: 'Mesajınızı yazın...',
        hintStyle: hintTextStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: textFieldBackgroundColor,
        contentPadding: textFieldContentPadding,
      );
}
