import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:outing_project/components/colors.dart';

class InputField extends StatefulWidget {
  final bool readOnly;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction? textInputAction;
  final String label;
  final double fontText;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final GestureTapCallback? onTap;

  const InputField({
    super.key,
    required this.readOnly,
    required this.controller,
    required this.focusNode,
    required this.textInputAction,
    required this.label,
    required this.fontText,
    required this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onFieldSubmitted,
    this.onChanged,
    this.decoration,
    this.onTap
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: widget.fontText, color: Colors.black),
      readOnly: widget.readOnly,
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        isDense: true,
        labelText: widget.label,
        labelStyle: TextStyle(
          fontSize: widget.fontText,
          color: widget.focusNode.hasFocus
              ? Colors.teal
              : subLabel,
        ),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.teal,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade200,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      ),
      onTap: () {
        if (widget.onTap != null) widget.onTap!();
      },
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
