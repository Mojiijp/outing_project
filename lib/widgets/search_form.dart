import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:outing_project/components/colors.dart';

class SearchField extends StatefulWidget {
  final bool readOnly;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Widget? label;
  final String? hintText;
  final double fontText;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final GestureTapCallback? onTap;

  const SearchField({
    super.key,
    required this.readOnly,
    required this.controller,
    required this.focusNode,
    required this.textInputAction,
    this.keyboardType,
    required this.fontText,
    required this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onFieldSubmitted,
    this.onChanged,
    this.decoration,
    this.onTap,
    this.label,
    this.hintText,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      style: TextStyle(fontSize: widget.fontText, color: Colors.black),
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        isDense: true,
        label: widget.label,
        labelStyle: TextStyle(
          fontSize: widget.fontText,
          color: widget.focusNode.hasFocus
              ? Colors.teal
              : subLabel,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: widget.fontText,
          color: widget.focusNode.hasFocus
              ? Colors.teal
              : Colors.black,
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
            color: Colors.grey,
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
