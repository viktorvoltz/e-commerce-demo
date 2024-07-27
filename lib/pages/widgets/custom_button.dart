import 'package:ecommerce/provider/auth_provider.dart';
import 'package:ecommerce/util/adaptive_spacing.dart';
import 'package:ecommerce/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomAuthButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.systemBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 1.7.h, horizontal: 20.w),
      ),
      child: authProvider.isLoading
          ? SizedBox(
              height: 2.h,
              width: 2.h,
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
