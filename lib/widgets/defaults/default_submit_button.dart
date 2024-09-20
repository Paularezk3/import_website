import 'package:flutter/material.dart';

class DefaultSubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final double borderRadius;
  final bool isLoading;

  const DefaultSubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
    this.height = 50.0,
    this.width,
    this.borderRadius = 8.0,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed, // Disable button if loading
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
