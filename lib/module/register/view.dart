import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/inputPhoneNumberComponent.dart';
import 'package:enerren/model/countryModel.dart';
import 'package:enerren/module/register/presenter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/SystemUtil.dart';
// import 'package:component_icons/font_awesome.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'viewModel.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => super.viewModel,
      child: Consumer<ViewModel>(
        builder: (ctx, data, child) {
          return Scaffold(
            appBar: BottonComponent.customAppBar1(
                context: context,
                actionText: "",
                title: "${System.data.resource.register}",
                backButtonColor: System.data.colorUtil.lightTextColor,
                titleStyle: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.lightTextColor,
                  fontSize: System.data.fontUtil.xl,
                ),
                backgroundColor: System.data.colorUtil.primaryColor),
            body: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 0, left: 15, right: 15),
                  margin: EdgeInsets.only(
                    top: 20.0,
                  ),
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          inputPhoneNumber(),
                          SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${System.data.resource.email}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      height: 3,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: InputComponent.inputTextWithCorner(
                                    backgroundColor: System
                                        .data.colorUtil.inputTextBackground,
                                    hintText: '',
                                    borderInputGray:
                                        System.data.colorUtil.borderInputColor,
                                    controller: emailController,
                                    textInputAction: TextInputAction.done,
                                    fontSize: 14,
                                    contentPadding: EdgeInsets.only(
                                        top: 3, bottom: 2, left: 15),
                                    focusnode: emailFocus,
                                    corner: 5,
                                    onChanged: (val) {
                                      viewModel.email = val;
                                    },
                                    keyboardType: TextInputType.emailAddress),
                                height: 50,
                              ),
                            ],
                          ),
                          Container(
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${System.data.resource.name}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue[600],
                                    fontWeight: FontWeight.bold,
                                    height: 3,
                                  ),
                                )),
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: InputComponent.inputTextWithCorner(
                                backgroundColor:
                                    System.data.colorUtil.inputTextBackground,
                                hintText: '',
                                borderInputGray:
                                    System.data.colorUtil.borderInputColor,
                                controller: nameController,
                                textInputAction: TextInputAction.done,
                                fontSize: 14,
                                contentPadding: EdgeInsets.only(
                                    top: 3, bottom: 2, left: 15),
                                focusnode: nameFocus,
                                onChanged: (val) {
                                  viewModel.name = val;
                                },
                                corner: 5,
                                keyboardType: TextInputType.emailAddress),
                            height: 50,
                          ),
                          Container(
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${System.data.resource.birthday}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      height: 3,
                                    ),
                                  ))),
                          SizedBox(height: 5),
                          Container(
                            child: InputComponent.inputTextWithCorner(
                                backgroundColor:
                                    System.data.colorUtil.inputTextBackground,
                                focusnode: dateFocus,
                                fontSize: 14,
                                textAlign: TextAlign.left,
                                borderInputGray:
                                    System.data.colorUtil.borderInputColor,
                                inputBorderError:
                                    System.data.colorUtil.redColor,
                                contentPadding:
                                    EdgeInsets.only(bottom: 10, left: 15),
                                controller: birthdateController,
                                stateInput: dateState,
                                suffixIcon: IconButton(
                                  icon: SvgPicture.asset(
                                      "assets/angkut/date_blue.svg"),
                                  onPressed: () => selectDate(context),
                                ),
                                textInputAction: TextInputAction.done,
                                corner: 5,
                                readOnly: false,
                                onChanged: (val) {
                                  birthdateController.text =
                                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                                }),
                          ),
                          Container(
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Alamat",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      height: 3,
                                    ),
                                  ))),
                          SizedBox(height: 5),
                          Container(
                            child: InputComponent.inputTextWithCorner(
                                backgroundColor:
                                    System.data.colorUtil.inputTextBackground,
                                hintText: '',
                                borderInputGray:
                                    System.data.colorUtil.borderInputColor,
                                controller: addressController,
                                textInputAction: TextInputAction.done,
                                fontSize: 14,
                                contentPadding: EdgeInsets.only(
                                    top: 3, bottom: 2, left: 15),
                                focusnode: addressFocus,
                                corner: 5,
                                onChanged: (val) {
                                  viewModel.address = val;
                                },
                                keyboardType: TextInputType.text),
                            height: 50,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: <Widget>[
                              Checkbox(
                                value: super.viewModel.isAgree,
                                onChanged: (val) {
                                  super.viewModel.isAgree = val;
                                  super.viewModel.commit();
                                },
                              ),
                              Expanded(
                                child: Container(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                        decorationStyle:
                                            TextDecorationStyle.wavy,
                                      ),
                                      text:
                                          '${System.data.resource.withRegisterImAgree}',
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              '${System.data.resource.termAndCondition} ',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            decorationStyle:
                                                TextDecorationStyle.wavy,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap =
                                                () => onTapTermAndCondition(),
                                        ),
                                        TextSpan(
                                          text: '${System.data.resource.and} ',
                                        ),
                                        TextSpan(
                                          text:
                                              '${System.data.resource.privacyPolicy} ',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            decorationStyle:
                                                TextDecorationStyle.wavy,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap =
                                                () => onTapPrivacyPolicy(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
                circularProgressIndicatorDecoration(),
              ],
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(15),
              height: 70,
              child: BottonComponent.roundedButton(
                  onPressed: () {
                    if (viewModel.loadingController.onLoading == false) {
                      submit();
                    }
                  },
                  text: System.data.resource.confirmation,
                  textstyle: System.data.textStyleUtil.mainLabel(
                    fontWeight: FontWeight.bold,
                    color: System.data.colorUtil.lightTextColor,
                  )),
            ),
          );
        },
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return CircularProgressIndicatorComponent(
      padding: EdgeInsets.only(bottom: 80),
      controller: loadingController,
    );
  }

  Widget inputPhoneNumber() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "${System.data.resource.phoneNumber}",
            style: TextStyle(
              fontSize: 15,
              color: Colors.blue[600],
              fontWeight: FontWeight.bold,
              height: 3,
            ),
          ),
        ),
        SizedBox(height: 5),
        Container(
          child: InternationalPhoneNumberInput.withCustomInput(
            onInputChanged: (val) {
              phoneController.text = val;
            },
            onInputValidated: (a) {
              setState(() {
                phoneController.setStateInput =
                    a == true ? StateInput.Enable : StateInput.Error;
              });
            },
            countries: CountryModel.getCountries()
                .where((x) => x.dialCode == "+62")
                .toList(),
            focusNode: phoneFocus,
            onBuildInputPhone: ((context, controller, formatter, listerner) {
              return Container(
                decoration: BoxDecoration(
                    color: System.data.colorUtil.inputTextBackground,
                    border: Border.all(
                      color: phoneController.stateInput == StateInput.Enable
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
          // child: InputComponent.inputTextWithCorner(
          //     backgroundColor: System.data.colorUtil.inputTextBackground,
          //     hintText: '',
          //     autoFocus: true,
          //     borderInputGray: System.data.colorUtil.borderInputColor,
          //     controller: phoneController,
          //     textInputAction: TextInputAction.done,
          //     fontSize: 14,
          //     contentPadding: EdgeInsets.only(top: 3, bottom: 2, left: 15),
          //     focusnode: phoneFocus,
          //     onChanged: (val) {
          //       viewModel.phone = val;
          //     },
          //     corner: 5,
          //     masking: "",
          //     keyboardType: TextInputType.number),
          // height: 50,
        ),
        SizedBox(height: 5),
        viewModel.phoneNumberPaternInValid == true
            ? Align(
                alignment: Alignment.topRight,
                child: Text(
                  "${System.data.resource.formatPhoneNumberNotValid}",
                  style: System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.redColor,
                  ),
                ),
              )
            : Container(
                height: 0,
                width: 0,
              ),
      ],
    );
  }
}
