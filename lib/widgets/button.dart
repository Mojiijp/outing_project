import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final double height;
  final double width;
  final String text;
  final Color colorText;
  final Color colorButton;
  final double fontTextSize;
  final void Function()? onPressed;

  const ButtonWidget(
      {super.key,
        required this.height,
        required this.width,
        required this.text,
        required this.colorText,
        required this.colorButton,
        required this.fontTextSize,
        this.onPressed});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: widget.colorButton),
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          style: TextStyle(fontSize: widget.fontTextSize, color: widget.colorText),
        ),
      ),
    );
  }
}
