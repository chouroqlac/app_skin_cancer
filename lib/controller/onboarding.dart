// ignore_for_file: unnecessary_import, unused_import

import 'package:flutter/material.dart';
import 'package:skinCancer_app/modele/onboarding_info.dart';
import 'package:skinCancer_app/view/onboarding.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class OnboardingController extends GetxController {
  RxInt selectedPageIndex = 0.obs;
  bool get isLastScreen =>
      selectedPageIndex.value == onboardingScreens.length - 1;

  PageController pageController = PageController();

  forwardAction() {
    if (isLastScreen) {
      //Get.offAll(()=> LoginView());
    } else {
      pageController.nextPage(
        duration: 300.milliseconds,
        curve: Curves.ease,
      );
    }
  }

  List<OnboardingInfo> onboardingScreens = [
    OnboardingInfo(
      "assets/onboarding/onboarding_1.jpg",
      "Ensemble, luttons contre le cancer de la peau",
      "Faites de la prévention une priorité et sauvez des vies",
    ),
    OnboardingInfo(
      "assets/onboarding/onboarding_9.PNG",
      "Confidentialité garantie",
      "Vos données sont sécurisées et ne seront jamais partagées sans votre consentement",
    ),
    OnboardingInfo(
      "assets/onboarding/onboarding_11.jpg",
      "Analysez vos grains de beauté",
      "Capturez des photos de vos lésions cutanées pour une évaluation rapide et précise",
    ),
  ];
}
