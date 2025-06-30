import 'package:flutter/material.dart';

extension OpacityFix on Color {
  Color applyOpacity(double opacity) => withAlpha((opacity * 255).round());
}
