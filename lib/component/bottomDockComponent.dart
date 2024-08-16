import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'package:component_icons/font_awesome.dart';

class BottomDockComponent extends StatelessWidget {
  final BottomDockComponentController controller;
  final double minHeight;
  final Color gripBackground;
  final IconData gripIcon;
  final double maxHeight;
  final double extraArea;
  final Color backgroundColor;
  final Widget child;
  final Color gripColorOnFree;
  final Color gripColorOnDrag;
  final bool isExpand;
  final WidgetFromDataBuilder<BottomDockComponentValue> handleBar;
  final BoxDecoration contentDecoration;
  final BoxDecoration bottonSheetDecoration;
  final double extraHeight;
  final EdgeInsetsGeometry contentPadding;
  final ValueChanged<bool> onUpdateStatusExpand;

  const BottomDockComponent({
    Key key,
    @required this.controller,
    this.minHeight,
    this.gripBackground,
    this.gripIcon = const FontAwesomeRegular(FontAwesomeId.fa_grip_lines),
    this.maxHeight,
    this.extraArea = 0,
    this.backgroundColor,
    this.gripColorOnFree,
    this.gripColorOnDrag,
    this.child,
    this.isExpand,
    this.handleBar,
    this.contentDecoration,
    this.extraHeight = 0,
    this.bottonSheetDecoration,
    this.contentPadding,
    this.onUpdateStatusExpand,
  }) : super(key: key);

  Widget build(BuildContext context) {
    controller.value.gripColor = gripColorOnFree;
    controller.value.isExpand = isExpand;
    controller.value.onUpdateStatusExpand = onUpdateStatusExpand;
    controller.value.sizeBoxHeight =
        isExpand ? maxHeight : minHeight + extraArea;

    return Align(
      alignment: Alignment.bottomCenter,
      child: ValueListenableBuilder<BottomDockComponentValue>(
        valueListenable: controller,
        builder: (ctx, value, c) {
          return Container(
              padding: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
              height: value.sizeBoxHeight + extraHeight,
              width: double.infinity,
              decoration: bottonSheetDecoration ??
                  BoxDecoration(
                    color: Colors.transparent,
                  ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onVerticalDragStart: (drag) {
                        controller.onVerticalDragStart(drag);
                      },
                      onVerticalDragEnd: (drag) {
                        controller.onVerticakDragEnd(
                            gripColorOnFree, maxHeight, minHeight, extraArea);
                      },
                      onVerticalDragDown: (drag) {
                        controller.onVerticalDragDown(gripColorOnDrag);
                      },
                      onVerticalDragUpdate: (drag) {
                        controller.onVerticalDragUpdate(
                            drag, minHeight, maxHeight, extraArea);
                      },
                      child: handleBar != null
                          ? handleBar(value)
                          : Container(
                              width: double.infinity,
                              height: minHeight + 30,
                              color: Colors.transparent,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  color: gripBackground,
                                  width: double.infinity,
                                  height: minHeight,
                                  child: Icon(
                                    gripIcon,
                                    color: value.gripColor,
                                  ),
                                ),
                              )),
                    ),
                  ),
                  Container(
                    height: maxHeight - (minHeight + extraArea) + extraHeight,
                    decoration: contentDecoration ??
                        BoxDecoration(
                          color: backgroundColor,
                        ),
                    padding: contentPadding ??
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: child,
                  )
                ],
              ));
        },
      ),
    );
  }
}

class BottomDockComponentValue {
  Color gripColor;
  double sizeBoxHeight;
  Offset dragStart;
  bool isExpand;
  ValueChanged<bool> onUpdateStatusExpand;

  BottomDockComponentValue({
    this.gripColor = Colors.green,
    this.sizeBoxHeight,
    this.dragStart,
    this.isExpand = false,
  });
}

class BottomDockComponentController
    extends ValueNotifier<BottomDockComponentValue> {
  BottomDockComponentController({
    BottomDockComponentValue value,
  }) : super(value == null ? new BottomDockComponentValue() : value);

  void onVerticakDragEnd(Color gripColorOnFree, double maxHeight,
      double minHeight, double extraArea) {
    value.gripColor = gripColorOnFree;
    if (value.isExpand) {
      value.sizeBoxHeight = maxHeight;
    } else {
      value.sizeBoxHeight = minHeight + extraArea;
    }
    notifyListeners();
  }

  void onVerticalDragDown(Color gripColorOnDrag) {
    value.gripColor = gripColorOnDrag;
    notifyListeners();
  }

  void onVerticalDragStart(DragStartDetails drag) {
    value.dragStart = drag.globalPosition;
    notifyListeners();
  }

  void onVerticalDragUpdate(DragUpdateDetails drag, double minHeight,
      double maxHeight, double extraArea) {
    if (drag.globalPosition.dy > value.dragStart.dy) {
      if (value.sizeBoxHeight > minHeight + extraArea) {
        value.sizeBoxHeight =
            value.sizeBoxHeight - (drag.globalPosition.dy - value.dragStart.dy);
        value.dragStart = drag.globalPosition;
        value.sizeBoxHeight = value.sizeBoxHeight < minHeight
            ? minHeight + extraArea
            : value.sizeBoxHeight;
        value.isExpand = false;
        if (value.onUpdateStatusExpand != null) {
          value.onUpdateStatusExpand(value.isExpand);
        }
      }
    } else {
      if (value.sizeBoxHeight < maxHeight) {
        value.sizeBoxHeight =
            value.sizeBoxHeight + (value.dragStart.dy - drag.globalPosition.dy);
        value.dragStart = drag.globalPosition;
        value.sizeBoxHeight = value.sizeBoxHeight > value.sizeBoxHeight
            ? value.sizeBoxHeight
            : value.sizeBoxHeight;
        value.isExpand = true;
        if (value.onUpdateStatusExpand != null) {
          value.onUpdateStatusExpand(value.isExpand);
        }
      }
    }
    notifyListeners();
  }

  void expand() {
    value.sizeBoxHeight = value.sizeBoxHeight;
    value.isExpand = true;
    notifyListeners();
  }

  void less() {
    value.sizeBoxHeight = value.sizeBoxHeight;
    value.isExpand = false;
  }
}
