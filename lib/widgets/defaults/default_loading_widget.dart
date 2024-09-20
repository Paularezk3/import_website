import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DefaultLoadingWidget extends StatelessWidget {
  const DefaultLoadingWidget({this.height, this.alignment, super.key});
  final double? height;
  final AlignmentGeometry? alignment;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment?? Alignment.topCenter,
      child: SizedBox(
        height: height??75,
        child: Lottie.asset("assets/animations/Loading.json"),
      ),
    ); // Loading icon
  }
}
