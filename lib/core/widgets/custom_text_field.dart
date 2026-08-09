import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resto/core/theme/app_colors.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.hint,
    required this.isPassword,
    required this.controller,
  });

  final String hint;
  final bool isPassword;
  final TextEditingController controller;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,

        cursorColor: Colors.white,
        cursorHeight: 20,

        style: const TextStyle(fontSize: 15, color: Colors.white),

        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please fill ${widget.hint}';
          }

          return null;
        },

        decoration: InputDecoration(
          hintText: widget.hint,

          hintStyle: const TextStyle(color: Colors.white60, fontSize: 14),

          filled: true,
          fillColor: Colors.white.withOpacity(0.10),

          // الـ TextField نفسه ثابت
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),

          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: _togglePassword,
                  splashRadius: 20,
                  icon: Icon(
                    _obscureText
                        ? CupertinoIcons.eye
                        : CupertinoIcons.eye_slash,
                    color: Colors.white60,
                    size: 19,
                  ),
                )
              : null,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.20),
              width: 0.8,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.2),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent, width: 0.8),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
          ),

          // مهم جدًا
          errorStyle: const TextStyle(fontSize: 11, height: 1.2),
        ),
      ),
    );
  }
}
