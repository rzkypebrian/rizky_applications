import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class KeyboardComponent {
  static Widget pinKeyboard({
    @required BuildContext context,
    ValueChanged<String> onKeyPress,
    ValueChanged<String> onSugestPress,
    VoidCallback onTapDelete,
    VoidCallback onTapClear,
    List<String> sugest = const [],
  }) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: (MediaQuery.of(context).size.height * 1 / 3) +
            (sugest.length > 0 ? 50 : 0),
        child: Column(
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white60,
                  border: Border(
                      top: BorderSide(
                    color: System.data.colorUtil.greyColor,
                    width: 0.1,
                  ))),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(sugest.length, (i) {
                    return GestureDetector(
                      onTap: () {
                        onSugestPress(sugest[i]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Center(
                          child: Text(
                            "${sugest[i]}",
                            style: System.data.textStyleUtil.mainLabel(
                              fontSize: System.data.fontUtil.xxl,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            )),
            Container(
              height: MediaQuery.of(context).size.height * 1 / 3,
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: padButton(
                            text: "1",
                            onPress: onKeyPress,
                          ),
                        ),
                        Expanded(
                          child: padButton(
                            text: "2",
                            onPress: onKeyPress,
                          ),
                        ),
                        Expanded(
                          child: padButton(
                            text: "3",
                            onPress: onKeyPress,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: padButton(
                            text: "4",
                            onPress: onKeyPress,
                          ),
                        ),
                        Expanded(
                          child: padButton(
                            text: "5",
                            onPress: onKeyPress,
                          ),
                        ),
                        Expanded(
                          child: padButton(
                            text: "6",
                            onPress: onKeyPress,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: padButton(
                            text: "7",
                            onPress: onKeyPress,
                          ),
                        ),
                        Expanded(
                          child: padButton(
                            text: "8",
                            onPress: onKeyPress,
                          ),
                        ),
                        Expanded(
                          child: padButton(
                            text: "9",
                            onPress: onKeyPress,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: padButton(
                              text: "Clear",
                              onPress: (value) {
                                onTapClear();
                              }),
                        ),
                        Expanded(
                          child: padButton(
                            text: "0",
                            onPress: onKeyPress,
                          ),
                        ),
                        Expanded(
                          child: padButton(
                            text: "Delete",
                            onPress: (value) {
                              onTapDelete();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget padButton({
    String text,
    String value,
    ValueChanged<String> onPress,
  }) {
    return Container(
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: Colors.white,
        onPressed: () {
          onPress(value ?? text);
        },
        child: Center(
          child: Text(
            "$text",
            style: System.data.textStyleUtil.mainLabel(
              fontSize: System.data.fontUtil.xxxl,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
