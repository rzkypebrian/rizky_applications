import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/profileModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback onChangeProfile;
  final ProfileModel profileModel;
  final Object id;
  final ValueChanged<ProfileModel> onUpdateSuccess;

  const Presenter({
    Key key,
    this.view,
    this.onChangeProfile,
    this.profileModel,
    this.id,
    this.onUpdateSuccess,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  String loadingImage = "loading.gif";
  ProfileModel profileModel;
  DateTime selectedDate;
  Object id;

  InputComponentTextEditingController nameController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController addressController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController phoneController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController emailController =
      new InputComponentTextEditingController();

  ImagePickerController imagePickerController = new ImagePickerController();

  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  FocusNode nameFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  String getExtension(String string) {
    List<String> getList = string.split(".");
    String data = getList.last.replaceAll("'", "");
    String result;
    if (data == "png") {
      result = "data:image/png;base64,";
    } else if (data == "jpeg") {
      result = "data:image/jpeg;base64,";
    } else if (data == "jpg") {
      result = "data:image/jpg;base64,";
    } else if (data == "gif") {
      result = "data:image/gif;base64,";
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    loadingController.stopLoading();
    initProfileData();
    id = widget.id;
    initMainPage();
  }

  void initProfileData() {
    profileModel = widget.profileModel;
  }

  void initMainPage() {
    nameController.text = profileModel.name;
    emailController.text = profileModel.email;
    phoneController.text = profileModel.phone;
    addressController.text = profileModel.address;
  }

  void changeProfile() {
    if (widget.onChangeProfile != null) {
      widget.onChangeProfile();
    }
  }

  bool validateEmail() {
    if (emailController.text.isEmpty) {
      emailFocus.requestFocus();
      emailController.setStateInput = StateInput.Error;
      return false;
    } else {
      return null;
    }
  }

  bool validateName() {
    if (nameController.text.isEmpty) {
      nameFocus.requestFocus();
      nameController.setStateInput = StateInput.Error;
      return false;
    } else {
      return null;
    }
  }

  bool validatePhone() {
    if (phoneController.text.isEmpty) {
      phoneFocus.requestFocus();
      phoneController.setStateInput = StateInput.Error;
      return false;
    } else {
      if (profileModel.phone == phoneController.text) {
        return null;
      } else if (!RegExp(ConstantUtil.regexPhoneNumberPhatern)
          .hasMatch(phoneController.text)) {
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: System.data.resource.formatPhoneNumberNotValid,
          ),
        );
        phoneController.setStateInput = StateInput.Error;
        return false;
      } else {
        phoneController.setStateInput = StateInput.Enable;
        return null;
      }
    }
  }

  bool validateAddress() {
    if (addressController.text.isEmpty) {
      addressFocus.requestFocus();
      addressController.setStateInput = StateInput.Error;
      return false;
    } else {
      return null;
    }
  }

  bool validate() {
    bool valid = true;
    valid = validateName() ?? valid;
    valid = validateEmail() ?? valid;
    // valid = validatePhone() ?? valid;
    valid = validateAddress() ?? valid;
    return valid;
  }

  void submit() {
    if (validate()) {}
  }
}
