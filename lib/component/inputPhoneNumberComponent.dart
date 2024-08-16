import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/model/countryModel.dart';
import 'package:enerren/util/phoneInputFormaterUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libphonenumber/libphonenumber.dart';

typedef OnBuildInputPhone = Widget Function(
    BuildContext context,
    InputComponentTextEditingController controller,
    List<TextInputFormatter> formater,
    VoidCallback onChange);

typedef OnBuildDropDownCountry = Widget Function(
  BuildContext context,
  CountryModel country,
);

class InternationalPhoneNumberInput extends StatefulWidget {
  final ValueChanged<String> onInputChanged;
  final ValueChanged<bool> onInputValidated;

  final String initialCountry2LetterCode;
  final String hintText;
  final String errorMessage;

  final bool formatInput;
  final bool shouldParse;
  final bool shouldValidate;

  final InputBorder inputBorder;
  final InputDecoration inputDecoration;

  final FocusNode focusNode;

  final List<CountryModel> countries;

  final OnBuildInputPhone onBuildInputPhone;
  final OnBuildDropDownCountry onBuildDropDownCountry;
  final TextStyle dropDownTextStyle;
  final TextStyle inputTextStyle;

  const InternationalPhoneNumberInput(
      {Key key,
      @required this.onInputChanged,
      this.onInputValidated,
      this.focusNode,
      this.countries,
      this.inputBorder,
      this.inputDecoration,
      this.initialCountry2LetterCode = 'NG',
      this.hintText = '(800) 000-0001 23',
      this.shouldParse = true,
      this.shouldValidate = true,
      this.formatInput = true,
      this.errorMessage = 'Invalid phone number',
      this.onBuildInputPhone,
      this.onBuildDropDownCountry,
      this.dropDownTextStyle,
      this.inputTextStyle})
      : super(key: key);

  factory InternationalPhoneNumberInput.withCustomDecoration({
    @required ValueChanged<String> onInputChanged,
    ValueChanged<bool> onInputValidated,
    FocusNode focusNode,
    List<CountryModel> countries,
    @required InputDecoration inputDecoration,
    String initialCountry2LetterCode = 'NG',
    bool formatInput = true,
    bool shouldParse = true,
    bool shouldValidate = true,
  }) {
    return InternationalPhoneNumberInput(
      onInputChanged: onInputChanged,
      onInputValidated: onInputValidated,
      focusNode: focusNode,
      countries: countries,
      inputDecoration: inputDecoration,
      initialCountry2LetterCode: initialCountry2LetterCode,
      formatInput: formatInput,
      shouldParse: shouldParse,
      shouldValidate: shouldValidate,
    );
  }

  factory InternationalPhoneNumberInput.withCustomBorder({
    @required ValueChanged<String> onInputChanged,
    @required ValueChanged<bool> onInputValidated,
    FocusNode focusNode,
    List<CountryModel> countries,
    @required InputBorder inputBorder,
    @required String hintText,
    String initialCountry2LetterCode = 'NG',
    String errorMessage = 'Invalid phone number',
    bool formatInput = true,
    bool shouldParse = true,
    bool shouldValidate = true,
  }) {
    return InternationalPhoneNumberInput(
      onInputChanged: onInputChanged,
      onInputValidated: onInputValidated,
      focusNode: focusNode,
      countries: countries,
      inputBorder: inputBorder,
      hintText: hintText,
      initialCountry2LetterCode: initialCountry2LetterCode,
      errorMessage: errorMessage,
      formatInput: formatInput,
      shouldParse: shouldParse,
      shouldValidate: shouldValidate,
    );
  }

  factory InternationalPhoneNumberInput.withCustomInput({
    @required ValueChanged<String> onInputChanged,
    @required ValueChanged<bool> onInputValidated,
    FocusNode focusNode,
    List<CountryModel> countries,
    // @required InputBorder inputBorder,
    // @required String hintText,
    String initialCountry2LetterCode = 'NG',
    String errorMessage = 'Invalid phone number',
    bool formatInput = true,
    bool shouldParse = true,
    bool shouldValidate = true,
    @required OnBuildInputPhone onBuildInputPhone,
    OnBuildDropDownCountry onBuildDropDownCountry,
    TextStyle dropdownTextStyle,
  }) {
    return InternationalPhoneNumberInput(
      onInputChanged: onInputChanged,
      onInputValidated: onInputValidated,
      focusNode: focusNode,
      countries: countries,
      // inputBorder: inputBorder,
      // hintText: hintText,
      initialCountry2LetterCode: initialCountry2LetterCode,
      errorMessage: errorMessage,
      formatInput: formatInput,
      shouldParse: shouldParse,
      shouldValidate: shouldValidate,
      onBuildInputPhone: onBuildInputPhone,
      onBuildDropDownCountry: onBuildDropDownCountry,
      dropDownTextStyle: dropdownTextStyle,
    );
  }

  @override
  State<StatefulWidget> createState() => _InternationalPhoneNumberInputState();
}

class _InternationalPhoneNumberInputState
    extends State<InternationalPhoneNumberInput> {
  final PhoneInputFormatter _kPhoneInputFormatter = PhoneInputFormatter();

  bool _isNotValid = false;

  List<CountryModel> _countries = [];
  CountryModel _selectedCountry;

  InputComponentTextEditingController _controller =
      new InputComponentTextEditingController();

  List<TextInputFormatter> _buildInputFormatter() {
    List<TextInputFormatter> formatter = [
      LengthLimitingTextInputFormatter(20),
      // WhitelistingTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
    ];
    if (widget.formatInput) {
      formatter.add(_kPhoneInputFormatter);
    }

    return formatter;
  }

  _loadCountries(BuildContext context) {
    setState(() {
      _countries = widget.countries ?? CountryModel.getCountries();
      _selectedCountry = CountryModel.getInitialSelectedCountry(
          _countries, widget.initialCountry2LetterCode);
    });
  }

  void _phoneNumberControllerListener() {
    _isNotValid = false;
    String parsedPhoneNumberString =
        _controller.text.replaceAll(RegExp(r'([\(\1\)\1\s\-])'), '');

    if (widget.shouldParse) {
      getParsedPhoneNumber(parsedPhoneNumberString, _selectedCountry.alpha2code)
          .then((phoneNumber) {
        if (phoneNumber == null) {
          if (widget.onInputValidated != null) {
            widget.onInputValidated(false);
          }
          if (widget.shouldValidate) {
            setState(() {
              _isNotValid = true;
            });
          }
        } else {
          widget.onInputChanged(phoneNumber);
          if (widget.onInputValidated != null) {
            widget.onInputValidated(true);
          }
          if (widget.shouldValidate) {
            setState(() {
              _isNotValid = false;
            });
          }
        }
      });
    } else {
      String phoneNumber =
          '${_selectedCountry.dialCode}$parsedPhoneNumberString';
      widget.onInputChanged(phoneNumber);
    }
  }

  static Future<String> getParsedPhoneNumber(
      String phoneNumber, String iso) async {
    if (phoneNumber.isNotEmpty) {
      try {
        bool isValidPhoneNumber = await PhoneNumberUtil.isValidPhoneNumber(
            phoneNumber: phoneNumber, isoCode: iso);

        if (isValidPhoneNumber) {
          return await PhoneNumberUtil.normalizePhoneNumber(
              phoneNumber: phoneNumber, isoCode: iso);
        }
      } on Exception {
        return null;
      }
    }
    return null;
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () => _loadCountries(context));
    _controller = InputComponentTextEditingController();
    _controller.addListener(_phoneNumberControllerListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            DropdownButtonHideUnderline(
              child: DropdownButton<CountryModel>(
                value: _selectedCountry,
                items: _mapCountryToDropdownItem(_countries),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                  });
                  _phoneNumberControllerListener();
                },
              ),
            ),
            widget.onBuildInputPhone == null
                ? Flexible(
                    child: TextField(
                      controller: _controller,
                      focusNode: widget.focusNode,
                      keyboardType: TextInputType.phone,
                      inputFormatters: _buildInputFormatter(),
                      onChanged: (text) {
                        _phoneNumberControllerListener();
                      },
                      decoration: _getInputDecoration(widget.inputDecoration),
                    ),
                  )
                : Expanded(
                    child: Container(
                        width: 200,
                        // height: 60,
                        child: widget.onBuildInputPhone(
                            context,
                            _controller,
                            _buildInputFormatter(),
                            _phoneNumberControllerListener)),
                  )
          ],
        ),
      ),
    );
  }

  InputDecoration _getInputDecoration(InputDecoration decoration) {
    return decoration ??
        InputDecoration(
          border: widget.inputBorder ?? UnderlineInputBorder(),
          hintText: widget.hintText,
          errorText: _isNotValid ? widget.errorMessage : null,
        );
  }

  List<DropdownMenuItem<CountryModel>> _mapCountryToDropdownItem(
          List<CountryModel> countries) =>
      countries
          .map(
            (country) => DropdownMenuItem<CountryModel>(
              value: country,
              child: widget.onBuildDropDownCountry == null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Image.asset(
                        //   country.flagUri,
                        //   width: 32.0,
                        //   errorBuilder: ((a,b,c){
                        //     return Container();
                        //   }),
                        //   // package: 'intl_phone_number_input',
                        // ),
                        // SizedBox(width: 12.0),
                        Text(
                          country.dialCode,
                          style: widget.dropDownTextStyle,
                        )
                      ],
                    )
                  : widget.onBuildDropDownCountry(
                      context,
                      country,
                    ),
            ),
          )
          .toList();
}
