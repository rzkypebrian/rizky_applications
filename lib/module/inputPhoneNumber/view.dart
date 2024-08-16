import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/inputPhoneNumberComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/countryModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => closeKeyboard(context),
      child: Scaffold(
        backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
        appBar: appBar(),
        body: Container(
          child: Stack(
            children: <Widget>[
              SafeArea(
                child: Container(
                  margin: EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: listComponent(),
                  ),
                ),
              ),
              circularProgressIndicatorDecoration(),
            ],
          ),
        ),
        bottomNavigationBar: buttonNavigationBar(),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      backButtonColor: System.data.colorUtil.lightTextColor,
      backgroundColor: System.data.colorUtil.primaryColor,
      title: System.data.resource.phoneNumber,
      titleStyle: System.data.textStyleUtil.mainTitle(
        color: System.data.colorUtil.lightTextColor,
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: model.loadingController,
    );
  }

  List<Widget> listComponent() {
    return <Widget>[
      Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 15,
          right: 15,
        ),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
           BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ]),
        child: inputPhone(),
      ),
    ];
  }

  Widget inputPhone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InternationalPhoneNumberInput.withCustomInput(
          onInputChanged: (val) {
            model.phoneController.text = val;
            print("input $val");
          },
          onInputValidated: (a) {
              model.validPhone = a;
              model.phoneState =
                  a == true ? StateInput.Enable : StateInput.Error;
          },
          countries: CountryModel.getCountries()
              .where((x) => x.dialCode == "+62")
              .toList(),
          focusNode: model.focusPhone,
          onBuildInputPhone: ((context, controller, formatter, listerner) {
            return Container(
              decoration: BoxDecoration(
                  color: System.data.colorUtil.inputTextBackground,
                  border: Border.all(
                    color: model.phoneState == StateInput.Enable
                        ? System.data.colorUtil.borderInputColor
                        : System.data.colorUtil.redColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.phone,
                inputFormatters: formatter,
                onChanged: (text) {
                  listerner();
                },
                decoration: InputDecoration(
                  fillColor: System.data.colorUtil.inputTextBackground,
                  border: InputBorder.none,
                ),
              ),
            );
          }),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget dropdownCountry(CountryModel country) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // Image.asset(
        //   country.flagUri,
        //   width: 32.0,
        //   // package: 'intl_phone_number_input',
        // ),
        SizedBox(width: 12.0),
        Text(
          country.dialCode,
          style: System.data.textStyleUtil.mainLabel(),
        )
      ],
    );
  }

  Widget buttonNavigationBar() {
    return SafeArea(
      child: Container(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                submitBotton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget submitBotton() {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      width: MediaQuery.of(context).size.width,
      // height: 100,
      color: Colors.transparent,
      child: Align(
          alignment: Alignment.bottomCenter,
          child: BottonComponent.roundedButton(
              colorBackground: System.data.colorUtil.primaryColor,
              text: "${System.data.resource.submit}",
              textstyle: System.data.textStyleUtil.mainTitle(
                color: System.data.colorUtil.lightTextColor,
              ),
              onPressed: () {
                if (model.loadingController.onLoading == false) {
                  submit();
                }
              })),
    );
  }
}
