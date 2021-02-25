import 'package:doers_project/helper/constColor.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(themeColors),
      ),
    ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}
