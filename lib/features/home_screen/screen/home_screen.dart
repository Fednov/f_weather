import 'package:f_weather/core/extensions/buildcontext_extensions.dart';
import 'package:f_weather/core/widgets/app_screen_size_limiter.dart';
import 'package:f_weather/core/widgets/app_screen_background.dart';
import 'package:f_weather/features/home_screen/widgets/home_screen_gesture_handler.dart';
import 'package:flutter/material.dart';

import '../widgets/founded_location_list.dart';

import '../widgets/location_search_text_field.dart';
import '../widgets/screen_body/home_screen_body_switcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = context.sizeOf();

    return Scaffold(
      body: AppScreenBackground(
        child: AppScreenSizeLimiter(
          child: SizedBox.expand(
            child: HomeScreenGestureHandler(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    const LocationSearchTextField(),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.02),
                          child: const HomeScreenBodySwitcher(),
                        ),
                        const FoundedLocationList(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
