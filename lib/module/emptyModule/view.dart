import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/material.dart';
import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                envo == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'android ${envo.detailAndroid?.androidId} ${envo.detailAndroid?.board}\n ${envo.detailAndroid?.bootloader} ${envo.detailAndroid?.brand} ${envo.detailAndroid?.device}',
                        ),
                      ),
                envo == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'ios ${envo.detailsIos?.utsname?.machine} ${envo.detailsIos?.utsname?.nodename} \n${envo.detailsIos?.utsname?.release} ${envo.detailsIos?.utsname?.sysname} ${envo.detailsIos?.utsname?.version}',
                        ),
                      ),
                envo == null
                    ? Container()
                    : Text(
                        'disk space on: ${envo.diskSpace?.total} - ${envo.diskSpace?.free}\n'),
                envo == null
                    ? Container()
                    : Text('battery on:  ${envo.battrey} %\n'),
                envo == null
                    ? Container()
                    : Text(
                        'ram on: tot ${envo.memory.totalMemory} free ${envo.memory.freeMemory} MB %\n'),
                Text("Empty Module"),
                Container(
                  width: 100,
                  margin: EdgeInsets.only(top: 10),
                  child: BottonComponent.roundedButton(
                    text: "Goto Home",
                    onPressed: () {
                      gotoHome();
                    },
                  ),
                ),
                Container(
                  width: 100,
                  margin: EdgeInsets.only(top: 10),
                  child: BottonComponent.roundedButton(
                      text: "start loading",
                      onPressed: () {
                        controller.startLoading();
                      }),
                ),
                Container(
                  width: 100,
                  margin: EdgeInsets.only(top: 10),
                  child: BottonComponent.roundedButton(
                      text: "Stop loading",
                      onPressed: () {
                        controller.stopLoading();
                      }),
                ),
                Container(
                  width: 200,
                  margin: EdgeInsets.only(top: 10),
                  child: BottonComponent.roundedButton(
                    text: "Stop loading with message",
                    onPressed: () {
                      controller.stopLoading(message: "some message");
                    },
                  ),
                ),
                Container(
                  width: 200,
                  margin: EdgeInsets.only(top: 10),
                  child: BottonComponent.roundedButton(
                    text: "Stop loading with non error",
                    onPressed: () {
                      controller.stopLoading(
                          message: "some message", isError: false);
                    },
                  ),
                ),
              ],
            ),
          ),
          CircularProgressIndicatorComponent(
            controller: controller,
            height: 100,
            width: 100,
            aligment: Alignment.bottomCenter,
          )
        ],
      ),
    );
  }
}
