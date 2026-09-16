import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwipeButton extends StatefulWidget {
  final String label;
  final VoidCallback onCompleted;
  final Color baseColor;

  const SwipeButton({
    super.key,
    required this.label,
    required this.onCompleted,
    this.baseColor = const Color(0xFFFF5622),
  });

  @override
  State<SwipeButton> createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton> with SingleTickerProviderStateMixin {
  double _position = 0;
  bool _isCompleted = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _reset() {
    _animation = Tween<double>(begin: _position, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {
          _position = _animation.value;
        });
      });
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        final double thumbSize = 52;
        final double maxPosition = maxWidth - thumbSize - 8;

        return Container(
          height: 60,
          width: maxWidth,
          decoration: BoxDecoration(
            color: widget.baseColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Center(
                child: Opacity(
                  opacity: (1 - (_position / maxPosition)).clamp(0.0, 1.0),
                  child: Text(
                    widget.label,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 4 + _position,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (_isCompleted) return;
                    setState(() {
                      _position += details.delta.dx;
                      if (_position < 0) _position = 0;
                      if (_position > maxPosition) _position = maxPosition;
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    if (_isCompleted) return;
                    if (_position >= maxPosition * 0.9) {
                      setState(() {
                        _position = maxPosition;
                        _isCompleted = true;
                      });
                      widget.onCompleted();
                    } else {
                      _reset();
                    }
                  },
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 200),
                    scale: _position > 0 ? 1.05 : 1.0,
                    child: Container(
                      width: thumbSize,
                      height: thumbSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.double_arrow,
                        color: widget.baseColor,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
