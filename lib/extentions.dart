import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension OpacityFix on Color {
  Color applyOpacity(double opacity) => withAlpha((opacity * 255).round());
}

class ShowLoading extends ConsumerStatefulWidget {
  final bool isLoading;
  const ShowLoading({super.key, required this.isLoading});

  @override
  ConsumerState<ShowLoading> createState() => _ShowLoadingState();
}

class _ShowLoadingState extends ConsumerState<ShowLoading> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flexible(
        child: widget.isLoading
            ? const CircularProgressIndicator()
            : const SizedBox.shrink(),
      ),
    );
  }
}
