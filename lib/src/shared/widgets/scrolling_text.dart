import 'package:flutter/material.dart';

class ScrollingText extends StatefulWidget {
  const ScrollingText({
    required this.text,
    this.style,
    this.width = 100,
    this.scrollSpeed = 30,
    this.pauseDuration = const Duration(seconds: 2),
    super.key,
  });

  final String text;
  final TextStyle? style;
  final double width;
  final double scrollSpeed; // pixels per second
  final Duration pauseDuration;

  @override
  State<ScrollingText> createState() => _ScrollingTextState();
}

class _ScrollingTextState extends State<ScrollingText>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  bool _isOverflowing = false;
  double _textWidth = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkOverflow();
    });
  }

  @override
  void didUpdateWidget(ScrollingText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkOverflow();
      });
    }
  }

  void _checkOverflow() {
    final textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    _textWidth = textPainter.width;
    _isOverflowing = _textWidth > widget.width;

    if (_isOverflowing && mounted) {
      _startScrolling();
    }
  }

  Future<void> _startScrolling() async {
    if (!mounted) return;

    // Wait before starting
    await Future<void>.delayed(widget.pauseDuration);
    if (!mounted) return;

    final scrollDistance = _textWidth - widget.width + 60; // +40 for padding
    final duration = Duration(
      milliseconds: ((scrollDistance / widget.scrollSpeed) * 1000).round(),
    );

    // Scroll to end
    await _scrollController.animateTo(
      scrollDistance,
      duration: duration,
      curve: Curves.linear,
    );

    if (!mounted) return;

    // Pause at end
    await Future<void>.delayed(widget.pauseDuration);
    if (!mounted) return;

    // Scroll back to start
    await _scrollController.animateTo(
      0,
      duration: duration,
      curve: Curves.linear,
    );

    if (!mounted) return;

    // Repeat
    await _startScrolling();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: _isOverflowing
                ? const [
                    Colors.transparent,
                    Colors.white,
                    Colors.white,
                    Colors.transparent,
                  ]
                : const [Colors.white, Colors.white],
            stops: _isOverflowing
                ? const [0.0, 0.1, 0.9, 1.0]
                : const [0.0, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.text,
              style: widget.style,
              maxLines: 1,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ),
    );
  }
}
