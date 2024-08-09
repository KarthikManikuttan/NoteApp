import 'package:flutter/material.dart';

class BuildTextWidget extends StatefulWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final String? family;

  const BuildTextWidget({
    super.key,
    required this.text,
    this.size,
    this.color,
    this.weight,
    this.family,
  });

  @override
  State<BuildTextWidget> createState() => _BuildTextWidgetState();
}

class _BuildTextWidgetState extends State<BuildTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text!,
      style: TextStyle(
        color: widget.color ?? Colors.white,
        fontSize: widget.size,
        fontWeight: widget.weight,
        fontFamily: widget.family,
      ),
    );
  }
}
