import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingComponent extends StatelessWidget {
  final double space;
  final double score;
  final RatingController controller;
  final bool readOnly;
  final double width;
  final double height;
  final MainAxisAlignment alignment;

  RatingComponent({
    this.score = 0,
    this.space = 10,
    this.controller,
    this.readOnly,
    this.width = 20,
    this.height = 30,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    RatingController _controller = this.controller ?? RatingController();
    _controller.value.readOnly =
        this.readOnly == null ? _controller.value.readOnly : this.readOnly;
    _controller.value.score = this.score ?? _controller.value.score;
    return ValueListenableBuilder<RatingValue>(
      valueListenable: _controller,
      builder: (ctx, data, child) {
        return Container(
          child: Row(
            mainAxisAlignment: alignment ?? MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (!data.readOnly) {
                    _controller.setRating(1);
                  }
                },
                child: SvgPicture.asset(
                  "assets/start_rating.svg",
                  width: width,
                  height: height,
                  color:
                      (data.score ?? score) >= 1 ? null : Colors.grey.shade400,
                ),
              ),
              SizedBox(
                width: space,
              ),
              GestureDetector(
                onTap: () {
                  if (!data.readOnly) {
                    _controller.setRating(2);
                  }
                },
                child: SvgPicture.asset(
                  "assets/start_rating.svg",
                  width: width,
                  height: height,
                  color:
                      (data.score ?? score) >= 2 ? null : Colors.grey.shade400,
                ),
              ),
              SizedBox(
                width: space,
              ),
              GestureDetector(
                onTap: () {
                  if (!data.readOnly) {
                    _controller.setRating(3);
                  }
                },
                child: SvgPicture.asset(
                  "assets/start_rating.svg",
                  width: width,
                  height: height,
                  color:
                      (data.score ?? score) >= 3 ? null : Colors.grey.shade400,
                ),
              ),
              SizedBox(
                width: space,
              ),
              GestureDetector(
                onTap: () {
                  if (!data.readOnly) {
                    _controller.setRating(4);
                  }
                },
                child: SvgPicture.asset(
                  "assets/start_rating.svg",
                  width: width,
                  height: height,
                  color:
                      (data.score ?? score) >= 4 ? null : Colors.grey.shade400,
                ),
              ),
              SizedBox(
                width: space,
              ),
              GestureDetector(
                onTap: () {
                  if (!data.readOnly) {
                    _controller.setRating(5);
                  }
                },
                child: SvgPicture.asset(
                  "assets/start_rating.svg",
                  width: width,
                  height: height,
                  color:
                      (data.score ?? score) >= 5 ? null : Colors.grey.shade400,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RatingValue {
  double score;
  bool readOnly;

  RatingValue({
    this.score = 0,
    this.readOnly = false,
  });
}

class RatingController extends ValueNotifier<RatingValue> {
  RatingController({RatingValue value})
      : super(value == null ? RatingValue() : value);

  set readOnly(bool status) {
    value.readOnly = status;
    notifyListeners();
  }

  void setRating(double score) {
    if (value.readOnly) return;
    print("score  is $score");
    value.score = score;
    notifyListeners();
  }
}
