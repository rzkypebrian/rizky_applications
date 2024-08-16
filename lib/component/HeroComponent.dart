import 'package:enerren/util/NavigationUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeroComponent extends StatelessWidget {
  final String pathImage;
  final String tagImage;
  final Color backgroundColor;

  HeroComponent({
    this.pathImage,
    this.tagImage,
    this.backgroundColor,
  });
  @override
  Widget build(BuildContext context) {
    System.data.routes.routeHistory.add(RouteHistory(
      routeName: "hero",
    ));
    return Scaffold(
      backgroundColor: backgroundColor,
      body: InteractiveViewer(
        child: Center(
          child: Hero(
            tag: '$tagImage',
            child: Image.network(
              '$pathImage',
              errorBuilder: (bb, o, st) => Container(
                width: 28,
                height: 16,
                child: SvgPicture.asset("assets/erroImage.svg"),
              ),
            ),
          ),
        ),
        // onTap: () {
        //   Navigator.pop(context);
        // },
      ),
    );
  }
}
