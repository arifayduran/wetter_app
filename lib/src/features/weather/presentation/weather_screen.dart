import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:wetter_app/src/features/weather/data/places.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, required this.placeIndex});

  final int placeIndex;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.placeIndex;
    _pageController = PageController(initialPage: _currentIndex);
    bottombarColor.value = Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: bottombarColor,
      builder: (BuildContext context, Color value, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: places.values.length,
            itemBuilder: (context, index) {
              return places.values.toList()[index][1];
            },
          ),
          bottomNavigationBar: Container(
            height: 72,
            color: value.withOpacity(.8),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 20, left: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    SmoothPageIndicator(
                      controller: _pageController,
                      // onDotClicked: (index) {
                      //   setState(() {
                      //     _currentIndex = index;
                      //   });
                      // },
                      count: places.values.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 6.5,
                        dotWidth: 6.5,
                        expansionFactor: 3,
                        spacing: 6,
                        activeDotColor: Colors.white,
                        dotColor: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const SFIcon(
                        SFIcons.sf_list_bullet,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
