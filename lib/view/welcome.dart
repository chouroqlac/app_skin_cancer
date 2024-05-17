// ignore_for_file: unnecessary_import, prefer_const_constructors, unused_import, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skinCancer_app/view/onboarding.dart';
import 'package:skinCancer_app/view/pageDetection.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late bool seenOnboarding;

  final GetStorage box = GetStorage();

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    /* seenOnboarding = box.read("seenOnboarding") ?? false;
         Future.delayed(const Duration(seconds: 3),
         (){
          if (seenOnboarding){
              // navigate to the login page
              Get.offAll(() => PageDetection());
          } else {
            box.write("seenOnboarding", true); 
            //navigate to Onboarding page
            Get.offAll(() => OnboardingView()); 
      
                    }
         }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/CancerPeaux5.PNG",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.4),
              ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Bienvenue dans",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    "EpidermoScan",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Votre guide personnel pour vous aider à détecter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    "les signes précoces de cancer de la peau",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => OnboardingView());
                    },
                    child: Container(
                        height: 50.0,
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          bottom: 20,
                          left: 20,
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: const Text(
                            "En savoir plus",
                            style: TextStyle(
                              color: Color.fromARGB(255, 108, 160, 220),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            )));
  }
}
