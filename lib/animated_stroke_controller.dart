import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class AnimatedStrokeController extends GetxController with GetTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> rotationAnimation;
  late Animation<double> rotationAnimationForText;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      duration: Duration(milliseconds: 950),
      // Adjust duration for speed of rotation
      vsync: this,
    );
    rotationAnimation = Tween<double>(begin: 0.0, end: pi) // 2π (360 degrees)
        .animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));

    rotationAnimationForText = Tween<double>(
        begin: -pi / 2, end: 0) // 2*pi for one full rotation
        .animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Delay before reversing after the forward animation is done
        Future.delayed(Duration(milliseconds: 800), () {
          animationController.reverse(); // Reverse the animation after delay
        });
      } else if (status == AnimationStatus.dismissed) {
        // Delay before forward animation after it has reversed completely
        Future.delayed(Duration(milliseconds: 800), () {
          animationController.forward(); // Start forward animation after delay
        });
      }
    });

    animationController.forward(); // Start forward animation initially
  }

  @override
  void onClose() {
    animationController.dispose();
    // animationControllerForText.dispose();
    super.onClose();
  }

 }