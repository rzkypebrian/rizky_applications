import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'viewModel.dart';

class View<T> extends PresenterState<T> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => super.model,
      child: Consumer<ViewModel>(
        builder: (cts, dt, child) {
          return Scaffold(
            backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
            appBar: appbar(),
            body: Stack(
              children: <Widget>[
                body(),
                circularProgressIndicatorDecoration(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return CircularProgressIndicatorComponent(
      controller: loadingController,
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Container(
        height: 400,
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
             BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
          ],
        ),
        child: Container(
          child: Column(
            children: <Widget>[
              inputReceiptNumber(),
              trackButton(),
              SizedBox(
                height: 30,
              ),
              Divider(
                indent: 30,
                endIndent: 30,
                color: System.data.colorUtil.blueColor,
                thickness: 1,
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 15),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        FontAwesomeLight(FontAwesomeId.fa_history),
                        color: System.data.colorUtil.primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "${System.data.resource.historyTrackShipment}",
                        style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.blueColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 180,
                child: ListView(
                  children: List.generate(
                    model.receiptNumbers.length,
                    (a) {
                      return shipmentHistory(
                          model.receiptNumbers[a].shipmentNumber);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appbar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      title: "${System.data.resource.trackShipment}",
      titleColor: System.data.colorUtil.lightTextColor,
      backgroundColor: System.data.colorUtil.blueColor,
      backButtonColor: System.data.colorUtil.lightTextColor,
    );
  }

  Widget trackButton() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 120,
      height: 50,
      child: BottonComponent.roundedButton(
          text: "${System.data.resource.track}",
          textstyle: System.data.textStyleUtil.mainLabel(
            color: System.data.colorUtil.lightTextColor,
            fontSize: System.data.fontUtil.xl,
          ),
          colorBackground: System.data.colorUtil.blueColor,
          onPressed: () {
            onTapTrack();
          }),
    );
  }

  Widget inputReceiptNumber() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 25, left: 40, right: 40),
      child: InputComponent.inputTextWithCorner(
        hintText: "${System.data.resource.inputReceiptNumber}",
        borderInputGray: System.data.colorUtil.blueColor,
        corner: 10,
        controller: receipeController,
        contentPadding: EdgeInsets.all(15),
      ),
    );
  }

  Widget shipmentHistory(String receiptIdNum) {
    return GestureDetector(
      onTap: () {
        submit(receiptIdNum);
      },
      child: Container(
        margin: EdgeInsets.only(left: 60, top: 5),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text("$receiptIdNum"),
            ),
            Container(
              height: 20,
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Icon(
                FontAwesomeSolid(FontAwesomeId.fa_chevron_right),
                size: 10,
                color: System.data.colorUtil.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
