import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import '../../component/BottonComponent.dart';
import '../../Util/SystemUtil.dart';
import 'presenter.dart';
import 'package:flutter/material.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: getAppBar(),
        bottomNavigationBar: bottomNavigationBar(),
        body: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                ListView(
                  children: getComponent(),
                ),
                circularProgressIndicator()
              ],
            )),
      ),
    );
  }

  Widget circularProgressIndicator() {
    return CircularProgressIndicatorComponent(
      controller: loadingController,
    );
  }

  List<Widget> getComponent() {
    switch (widget.passwordState) {
      case PasswordState.ChangePassword:
        return changePasseordComponents();
        break;
      case PasswordState.CreatePassword:
        return newPasswordComponent();
      case PasswordState.ResetPassword:
        return resetPasswordComponent();
      default:
        return changePasseordComponents();
    }
  }

  Decoration decoration() {
    return BoxDecoration(
      color: Colors.white,
    );
  }

  Widget bottomNavigationBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
        child: BottonComponent.roundedButton(
          // border: ColorUtil.primaryColor,
          onPressed: () {
            if (loadingController.onLoading == false) {
              submit();
            }
          },
          colorBackground: System.data.colorUtil.primaryColor,
          textstyle: System.data.textStyleUtil.mainTitle(),
          text: getLabelBottonSubmit(),
        ),
      ),
    );
  }

  String getLabelBottonSubmit() {
    switch (widget.passwordState) {
      case PasswordState.ChangePassword:
        return "${System.data.resource.save}";
        break;
      case PasswordState.CreatePassword:
        return "${System.data.resource.next}";
      case PasswordState.ResetPassword:
        return "${System.data.resource.resetPassword}";
      default:
        return "${System.data.resource.save}";
    }
  }

  PreferredSizeWidget getAppBar() {
    switch (widget.passwordState) {
      case PasswordState.ChangePassword:
        return appBar();
        break;
      case PasswordState.CreatePassword:
        return appBarCreatePassword();
      case PasswordState.ResetPassword:
        return appBarResetPassword();
      default:
        return AppBar();
    }
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      title: System.data.resource.changePassword,
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

  PreferredSizeWidget appBarCreatePassword() {
    return BottonComponent.customAppBar1(
      title: System.data.resource.createPassword,
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

  PreferredSizeWidget appBarResetPassword() {
    return BottonComponent.customAppBar1(
      title: System.data.resource.resetPassword,
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

  List<Widget> changePasseordComponents() {
    return <Widget>[
      currentPassword(),
      newPassword(),
      confirmPassword(),
    ];
  }

  List<Widget> newPasswordComponent() {
    return <Widget>[
      headerPage(),
      newPassword(),
      confirmPassword(),
    ];
  }

  List<Widget> resetPasswordComponent() {
    return <Widget>[
      headerPageResetPassword(),
      newPassword(),
      confirmPassword(),
    ];
  }

  Widget headerPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${System.data.resource.createPassword}",
          style: System.data.textStyleUtil.pageTitle(),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "${System.data.resource.lastStep}",
          style: System.data.textStyleUtil.mainLabel(),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget headerPageResetPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${System.data.resource.resetPassword}",
          style: System.data.textStyleUtil.pageTitle(),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget currentPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          System.data.resource.currentPassword,
          style: System.data.textStyleUtil.mainLabel(),
        ),
        SizedBox(
          height: 10,
        ),
        InputComponent.inputTextWithCorner(
            backgroundColor: System.data.colorUtil.inputTextBackground,
            autoFocus: true,
            hintText: '',
            focusnode: focusCurrentPassword,
            borderInputGray: System.data.colorUtil.borderInputColor,
            controller: currentPasswordController,
            textInputAction: TextInputAction.next,
            onSubmited: (val) {
              FocusScope.of(context).requestFocus(focusNewPassword);
            },
            onChanged: onCurrentPasswordChange,
            corner: 5,
            obscureText: true),
        SizedBox(
          height: 5,
        ),
        stateMessage(currentPasswordController),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget newPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          System.data.resource.newPassword,
          style: System.data.textStyleUtil.mainLabel(),
        ),
        SizedBox(
          height: 10,
        ),
        InputComponent.inputTextWithCorner(
            backgroundColor: System.data.colorUtil.inputTextBackground,
            hintText: '',
            focusnode: focusNewPassword,
            borderInputGray: System.data.colorUtil.borderInputColor,
            controller: newPasswordController,
            textInputAction: TextInputAction.next,
            onSubmited: (val) {
              FocusScope.of(context).requestFocus(focusConfirmPassword);
            },
            onChanged: onNewPasswordChange,
            corner: 5,
            obscureText: true),
        SizedBox(
          height: 5,
        ),
        stateMessage(newPasswordController),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget confirmPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          System.data.resource.confirmPassword,
          style: System.data.textStyleUtil.mainLabel(),
        ),
        SizedBox(
          height: 10,
        ),
        InputComponent.inputTextWithCorner(
            backgroundColor: System.data.colorUtil.inputTextBackground,
            hintText: '',
            focusnode: focusConfirmPassword,
            borderInputGray: System.data.colorUtil.borderInputColor,
            controller: confirmPasswordController,
            textInputAction: TextInputAction.done,
            corner: 5,
            onChanged: onConfirmPasswordChange,
            obscureText: true),
        SizedBox(
          height: 5,
        ),
        stateMessage(confirmPasswordController),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget stateMessage(InputComponentTextEditingController controller) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: ((ctx, value, child) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 15,
          child: controller != null
              ? Text(
                  "${controller.stateInputMessage?.message ?? ""}",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontFamily: System.data.fontUtil.primary,
                      color: controller.stateInputMessage?.color,
                      fontSize: System.data.fontUtil.l),
                )
              : Text(""),
        );
      }),
    );
  }
}
