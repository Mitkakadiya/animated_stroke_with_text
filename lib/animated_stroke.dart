import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'animated_stroke_controller.dart';
import 'gredient_circle_painter.dart';

class AnimatedStroke extends StatelessWidget {
   AnimatedStroke({super.key});
  AnimatedStrokeController controller = Get.put(AnimatedStrokeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            temperatureView(
                borderColor: Colors.deepOrange,
                tempIconPath: "assets/icon/icon_hot.png",
                temperature: "70",
                temperature2: "40",
                itemName: "Front Door",
                bgColor: Color(0xFF1C1C1E),
                gradiantColors: [Colors.deepOrange,Color(0xFF1C1C1E)],
                controller: controller)
          ],
        ),
      ),
    );
  }

  Widget temperatureView(
      {required Color borderColor,
      required String tempIconPath,
      required String temperature,
      required String temperature2,
      required String itemName,
      required Color bgColor,
      required List<Color> gradiantColors,
      required AnimatedStrokeController controller}) {
    return Column(children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              left: 0, right: 0, bottom: 8, child: Image.asset(tempIconPath,height: 12,width: 12,)),
          Positioned(
              top: 5,
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: controller.rotationAnimationForText,
                    builder: (BuildContext context, Widget? child) {
                      double opacity1 = (1 -
                              (controller.rotationAnimationForText.value.abs() /
                                  (pi / 2)))
                          .clamp(0.0, 1.0);
                      double opacity2 = (1 -
                              (controller.rotationAnimationForText.value.abs() -
                                          pi / 2)
                                      .abs() /
                                  (pi / 2))
                          .clamp(0.0, 1.0);
                      return Transform.rotate(
                        angle: controller.rotationAnimationForText.value,
                        child: ClipOval(
                          child: CircleAvatar(
                            radius: 50, // Adjust size as needed
                            backgroundColor: Colors.transparent,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                    alignment: Alignment(0, -1),
                                    child: ClipRRect(
                                      child: Opacity(
                                        opacity: opacity1,
                                        child: Text(
                                          temperature,
                                          style: TextStyle(
                                            color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment(1, 0),
                                  child: Transform.rotate(
                                    angle: pi / 2,
                                    child: Opacity(
                                      opacity: opacity2,
                                      child: Text(
                                        temperature2,
                                        style: TextStyle(
                                          color: borderColor,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                      top: 0,
                      bottom: 0,
                      left: 15,
                      child: Container(
                        width: 20,
                        color: bgColor,
                      )),
                  Positioned(
                      top: 0,
                      bottom: 0,
                      right: 15,
                      child: Container(
                        width: 20,
                        color: bgColor,
                      ))
                ],
              )),
          AnimatedBuilder(
              animation: controller.rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: controller.rotationAnimation.value,
                  child: CustomPaint(
                    size: Size(56, 56),
                    painter: GradientCirclePainter(
                        gradient: LinearGradient(
                          colors: gradiantColors,
                          stops: [0.0, 1.0],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                        ),
                        strokeWidth: 1.5),
                  ),
                );
              }),
        ],
      ),
      SizedBox(height: 10),
      Text(
        itemName,
        style: TextStyle(fontSize: 14),
      ),
    ]).paddingSymmetric(horizontal: 11);
  }
}
