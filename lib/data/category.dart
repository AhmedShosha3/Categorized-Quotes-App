import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.title,
    required this.icon,
    required this.quotes,
    this.lightImage,
    this.darkImage,
    this.useCustomFont = false,
    this.fontSize = 20,
  });

  final String title;
  final IconData icon;
  final List<String> quotes;
  final String? lightImage;
  final String? darkImage;
  final bool useCustomFont;
  final double fontSize;
}
