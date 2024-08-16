import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/keyboardComponent.dart';
import 'package:enerren/component/timerCountDownComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'viewModel.dart';
import 'presenter.dart';

/// module_sbbi_accountVerification
class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: DecoratedBox(
        decoration: decoration(),
        child: ChangeNotifierProvider.value(
          value: super.model,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar(),
            body: Stack(
              children: [
                body(),
                Consumer<ViewModel>(builder: (c, d, h) {
                  return KeyboardComponent.pinKeyboard(
                    context: context,
                    onKeyPress: (value) {
                      setPin(value);
                    },
                    onTapClear: reset,
                    onTapDelete: back,
                    sugest: model.pinSugest,
                    onSugestPress: readSuggestion,
                  );
                }),
                circularProgressIndicator(model.loadingController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Decoration decoration() {
    return BoxDecoration(
      color: Colors.white,
    );
  }

  Widget body() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title(),
          message(
            message:
                System.data.resource.checkYourInboxEnter6DigitActivationCode,
            phonNumber: widget.phoneNumber,
          ),
          verificationBox(),
          timerContainer(),
          bottonSubmit(),
        ],
      ),
    );
  }

  Widget timerContainer() {
    return widget.withTimer && (model.startTimer == true)
        ? Container(
            margin: EdgeInsets.only(top: 15, bottom: 20),
            child: Center(
              child: TimerCountDownComponent(
                controller: model.timerCountDownController,
                child: (time) {
                  if (time.duration.inMilliseconds <= 0) {
                    return timerCountDownFinish(time);
                  } else {
                    return timerCountDown(time);
                  }
                },
              ),
            ),
          )
        : Container();
  }

  Widget timerCountDown(TimerCountDown time) {
    return Text(
      "${time.duration.inMinutes.toString().padLeft(2, "0")} : ${(time.duration.inSeconds - (Duration(minutes: time.duration.inMinutes).inSeconds)).toString().padLeft(2, "0")}",
      style: System.data.textStyleUtil.mainLabel(),
    );
  }

  Widget timerCountDownFinish(TimerCountDown time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "${System.data.resource.didnotReceiveVerificationCode}",
          style: System.data.textStyleUtil.mainLabel(),
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            resend();
          },
          child: Text(
            "${System.data.resource.resend}",
            style: System.data.textStyleUtil.linkLabel(),
          ),
        )
      ],
    );
  }

  Widget bottonSubmit() {
    return BottonComponent.roundedButton(
        onPressed: () {
          if (model.loadingController.onLoading == false) {
            submit();
          }
        },
        colorBackground: System.data.colorUtil.primaryColor,
        textstyle: System.data.textStyleUtil.mainTitle(),
        text: "${System.data.resource.next}");
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      title: System.data.resource.verification,
      context: context,
      actionText: "",
      titleColor: System.data.colorUtil.secondaryColor,
      backButtonColor: System.data.colorUtil.lightTextColor,
      actionTextStyle: System.data.textStyleUtil.mainLabel(),
      actionTextColor: System.data.colorUtil.secondaryColor,
      titleStyle: System.data.textStyleUtil.mainTitle(),
      backgroundColor: System.data.colorUtil.primaryColor,
    );
  }

  Widget circularProgressIndicator(
      CircularProgressIndicatorController controller) {
    return CircularProgressIndicatorComponent(
      controller: controller,
    );
  }

  Widget title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          System.data.resource.verification,
          style: System.data.textStyleUtil.pageTitle(),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget message({String message, String phonNumber}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "$message  ${widget.scurePhoneNUmber ? secureNumber(phonNumber) : phonNumber}",
          style: System.data.textStyleUtil.mainLabel(),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget verificationBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Consumer<ViewModel>(
          builder: (c, d, h) {
            return Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: listPinInput(),
              ),
            );
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  List<Widget> listPinInput() {
    return List.generate(widget.pinLenght, (index) {
      return input(
        index: index,
      );
    });
  }

  Widget input({
    @required int index,
  }) {
    return GestureDetector(
      onTap: () {
        model.activePins = index;
        model.commit();
      },
      child: Container(
        margin: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width / widget.pinLenght -
            (8 * 2) -
            (20 * 2) / widget.pinLenght,
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: index == model.activePins
                  ? System.data.colorUtil.primaryColor
                  : model.pinsSate[index] == StateInput.Error
                      ? System.data.colorUtil.redColor
                      : System.data.colorUtil.greyColor,
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(2),
            child: widget.obscureText
                ? obscureView(model.pins[index])
                : unObscureView(model.pins[index]),
          ),
        ),
      ),
    );
  }

  Widget unObscureView(String pin) {
    return Text(
      pin,
    );
  }

  Widget obscureView(String pin) {
    return pin != ""
        ? Icon(
            Icons.brightness_1,
            size: 10,
          )
        : SizedBox();
  }
}
