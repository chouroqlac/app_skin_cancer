// ignore_for_file: unused_import, unnecessary_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, implicit_call_tearoffs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skinCancer_app/constants/colors.dart';
import 'package:skinCancer_app/controller/onboarding.dart';
import 'package:skinCancer_app/view/pageDetection.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});
  final OnboardingController _controller = Get.put(OnboardingController());

  // get primaryColor => null;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 135, 206, 235),
        elevation: 0,
        title: Column(
          children: [
            SizedBox(
              height: 2,
            ),
            Text(
              "EpidermoScan",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 14,
        ),
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller.pageController,
              onPageChanged: _controller.selectedPageIndex,
              itemCount: _controller.onboardingScreens.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 14,
                      ),
                      child: Image.asset(
                        _controller.onboardingScreens[index].AssetImage
                            .toString(),
                        fit: BoxFit.cover,
                        width: screenWidth,
                        height: screenHeight * 0.45,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.4,
                      ),
                      child: SizedBox(
                        width: screenWidth * 0.85,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.0,
                              ),
                              child: Text(
                                _controller.onboardingScreens[index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.0,
                              ),
                              child: Text(
                                _controller
                                    .onboardingScreens[index].description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  _controller.onboardingScreens.length,
                                  (index) => Obx(
                                    () {
                                      return GestureDetector(
                                        onTap: () {
                                          _controller.pageController
                                              .animateToPage(
                                            index,
                                            duration: const Duration(
                                              microseconds: 400,
                                            ),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(4),
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: _controller.selectedPageIndex
                                                        .value ==
                                                    index
                                                ? primaryColor
                                                : Colors.grey,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            Positioned(
              left: (screenWidth - 250) / 2,
              right: (screenWidth - 250) / 2,
              bottom: 20,
              child: Obx(
                () => _controller.isLastScreen
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: 4,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.offAll(() => TfliteModel());
                          },
                          child: Container(
                            /* width: screenWidth * 0.70,
                    height: screenHeight * 0.65,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),*/
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TfliteModel()),
                                  );
                                },
                                child: Text(
                                  'Détecter maintenant',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 135, 206, 235),
                                  minimumSize: Size(200, 55),
                                ),
                              ),
                              /*child: Text(
                        "Aller vers la détection",
                          style: TextStyle(
                               fontSize: 18,
                               fontWeight: FontWeight.bold,
                               color: Colors.white,
                             ),
                          ),*/
                            ),
                          ),
                        ),
                      )
                    : Center(),
              ),
            )
          ],
        ),
      )),
    );
  }
}
