import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/ratingComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/module/ratingDriver/main.dart';
import 'package:enerren/module/ratingDriver/presenter.dart';
import 'package:provider/provider.dart';

import 'viewModel.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (ctx) => super.model,
      child: Consumer<ViewModel>(builder: (ctx, data, child) {
        return Scaffold(
          backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
          appBar: appBar(),
          body: Stack(
            children: <Widget>[
              body(),
              circularProgressIndicatorComponent(),
            ],
          ),
          bottomNavigationBar: bottomNavBar(),
        );
      }),
    );
  }

  Widget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      backButtonColor: System.data.colorUtil.lightTextColor,
      backgroundColor: System.data.colorUtil.primaryColor,
      title: "${System.data.resource.ratingDriver}",
      titleStyle: System.data.textStyleUtil.mainLabel(
        color: System.data.colorUtil.lightTextColor,
        fontSize: System.data.fontUtil.xlPlus,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 30),
            // color: System.data.colorUtil.greyColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color:
                            System.data.colorUtil.shadowColor.withOpacity(0.2),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: listComponent(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> listComponent() {
    return <Widget>[
      imageDriver(),
      driverName(),
      inputRating(),
      inputNote(),
    ];
  }

  Widget imageDriver() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 120,
      width: 120,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: System.data.colorUtil.orangeColor),
          image: new DecorationImage(
              image: NetworkImage('${widget.driverImageUrl}'),
              fit: BoxFit.cover)),
    );
  }

  Widget driverName() {
    return Container(
        margin: EdgeInsets.only(top: 15, bottom: 40),
        child: Text(
          "${widget.driverName}",
          style: TextStyle(
            color: System.data.colorUtil.primaryColor,
            fontSize: System.data.fontUtil.xlPlus,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  Widget inputRating() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: RatingComponent(
        controller: ratingController,
        readOnly: false,
      ),
    );
  }

  Widget inputNote() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 40, right: 40, bottom: 50),
      child: InputComponent.inputTextWithCorner(
        hintText: "${System.data.resource.writeComment}",
        backgroundColor: System.data.colorUtil.inputTextBackground,
        controller: commentController,
        maxLines: 8,
        borderInputGray: System.data.colorUtil.borderColor,
        corner: 7,
      ),
    );
  }

  Widget circularProgressIndicatorComponent() {
    return DecorationComponent.circularProgressDecoration(
      controller: loadingController,
    );
  }

  Widget bottomNavBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: BottonComponent.roundedButton(
          onPressed: () {
            submit();
          },
          height: 60,
          width: 60,
          radius: 15,
          text: System.data.resource.finish,
          colorBackground: System.data.colorUtil.primaryColor,
          textstyle: System.data.textStyleUtil.mainLabel(
              fontWeight: FontWeight.bold,
              color: System.data.colorUtil.lightTextColor,
              fontSize: System.data.fontUtil.xl)),
    );
  }
}
