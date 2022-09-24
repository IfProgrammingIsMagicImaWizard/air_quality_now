import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../globals/style.dart';
import '../pages/setup_page.dart';
import 'big_main_button.dart';
import 'windows_custom_bar.dart';

class CarouselWithIndicator extends StatefulWidget {
  final bool isFirstTime;
  const CarouselWithIndicator({this.isFirstTime = false, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  final List<String> imgList = [
    'assets/images/1_tutorial_move.webp',
    'assets/images/2_tutorial_detail.webp',
    'assets/images/3_tutorial_settings.webp',
  ];
  final List<String> text = [
    'Drag the card to change the order'.tr(),
    'Two taps in the card to more details'.tr(),
    'Go to Settings for more options'.tr(),
  ];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  late List<Widget> imageSliders = imageSliders = imgList
      .map((item) => Image.asset(
            item,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (() => Future.value(false)),
        child: WindowsCustomBar(
          child: Scaffold(
            body: Container(
              color: const Color(0xFFC4E0F3),
              child: Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Container(
                        color: Colors.white.withOpacity(0.27),
                        child: Center(
                            child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: Text(
                            text[_current],
                            style: carouselTitleStyle(),
                            textAlign: TextAlign.center,
                          ),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 32,
                        ),
                        child: CarouselSlider(
                          items: imageSliders,
                          carouselController: _controller,
                          options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.57,
                              viewportFraction: 1.0,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 6),
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imgList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (_current == entry.key)
                                      ? const Color(0xFF5B3FA4)
                                      : Colors.white),
                            ),
                          );
                        }).toList(),
                      ),
                      const Spacer(),
                      BigMainButton(
                          text: 'Dismiss'.tr(),
                          onPressed: () {
                            (widget.isFirstTime)
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SetupPage()))
                                : Navigator.of(context).pop;
                          }),
                    ]),
              ),
            ),
          ),
        ));
  }
}
