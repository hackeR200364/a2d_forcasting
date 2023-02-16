import 'package:a2d_app/providers/app_providers.dart';
import 'package:a2d_app/styles.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({
    required this.pageIndex,
  });

  int pageIndex = 0;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passController;
  late bool buttonStatus;
  String countryName = '';
  late bool isObscure = false, emailValid = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    buttonStatus = false;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void buttonEnabled() {
    buttonStatus = (_nameController.text.isNotEmpty &&
            _phoneController.text.isNotEmpty &&
            _passController.text.isNotEmpty &&
            _emailController.text.isNotEmpty &&
            countryName.isNotEmpty)
        ? true
        : false;
    print(buttonStatus);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColour,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: AppColors.scrollPhysics,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.height / 15,
                ),
                Image.asset("assets/auth-logo.png"),

                //SIGNUP FIELDS
                if (widget.pageIndex == 0)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 45,
                      left: 32,
                      right: 32,
                    ),
                    child: Column(
                      children: [
                        detailsField(
                          hint: "Full Name",
                          controller: _nameController,
                          keyboard: TextInputType.name,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        detailsField(
                          hint: "Phone Number",
                          controller: _phoneController,
                          keyboard: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Consumer<AppProviders>(
                          builder: (appProviderContext, appProvider,
                              appProviderChild) {
                            return GestureDetector(
                              onTap: (() {
                                showCountryPicker(
                                  context: context,
                                  countryListTheme: CountryListThemeData(
                                    inputDecoration: InputDecoration(
                                      hintText: "Search your country",
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                    ),
                                  ),
                                  onSelect: ((country) {
                                    appProvider.countryNameFunc(country.name);
                                    countryName = appProvider.countryName;
                                    buttonEnabled();
                                    setState(() {});
                                  }),
                                );
                              }),
                              child: Container(
                                width: size.width + 20,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    width: 1.5,
                                    color: AppColors.grey.withOpacity(0.3),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 23),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        (appProvider.countryName.isEmpty)
                                            ? "Country"
                                            : appProvider.countryName,
                                        style: TextStyle(
                                          color: (appProvider
                                                  .countryName.isEmpty)
                                              ? AppColors.black.withOpacity(0.7)
                                              : AppColors.black,
                                          fontWeight: (appProvider
                                                  .countryName.isNotEmpty)
                                              ? FontWeight.w600
                                              : null,
                                        ),
                                      ),
                                      Icon(
                                        Icons.expand_more_outlined,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        detailsField(
                          hint: "Email",
                          controller: _emailController,
                          keyboard: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        detailsField(
                          hint: "Password",
                          controller: _passController,
                          keyboard: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: (() {}),
                          child: Container(
                            width: size.width + 20,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient:
                                  (buttonStatus) ? AppColors.appGradient : null,
                              color: (!buttonStatus)
                                  ? AppColors.disableButtonColour
                                  : null,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 7,
                        ),
                      ],
                    ),
                  ),

                //LOGIN FIELDS
                if (widget.pageIndex == 1)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 45,
                      left: 32,
                      right: 32,
                    ),
                    child: Column(
                      children: [
                        detailsField(
                          hint: "Email",
                          controller: _emailController,
                          keyboard: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        detailsField(
                          hint: "Password",
                          controller: _passController,
                          keyboard: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: size.height / 3,
                        )
                      ],
                    ),
                  ),

                //SIGNUP BOTTOM TEXT
                if (widget.pageIndex == 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        child: InkWell(
                          onTap: (() {
                            setState(() {
                              _emailController.clear();
                              _passController.clear();
                              _nameController.clear();
                              _phoneController.clear();
                              widget.pageIndex = 1;
                            });
                          }),
                          child: Text(
                            " Login",
                            style: TextStyle(
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),

                //LOGIN BOTTOM TEXT
                if (widget.pageIndex == 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        child: InkWell(
                          onTap: (() {
                            setState(() {
                              _emailController.clear();
                              _passController.clear();
                              widget.pageIndex = 0;
                            });
                          }),
                          child: Text(
                            " SignUp",
                            style: TextStyle(
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField detailsField({
    required String hint,
    required TextEditingController controller,
    required TextInputType keyboard,
  }) {
    return TextFormField(
      obscuringCharacter: '*',
      obscureText: (hint == "Password") ? isObscure : false,
      controller: controller,
      keyboardType: keyboard,
      onChanged: ((text) {
        buttonEnabled();
        if (hint == "Email") {
          emailValid = RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(text);
        }
      }),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 25),
        errorText:
            (hint == "Email" && !emailValid && _emailController.text.isNotEmpty)
                ? "Please check your email"
                : null,
        hintText: hint,
        hintStyle: TextStyle(
          color: AppColors.black.withOpacity(0.7),
          fontSize: 14,
        ),
        suffixIcon: (hint == "Password")
            ? IconButton(
                splashRadius: 20,
                onPressed: (() {
                  setState(() {
                    isObscure = !isObscure;
                  });
                }),
                icon: Icon(
                  (isObscure)
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            width: 1.5,
            color: AppColors.grey.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            width: 1.5,
            color: AppColors.grey.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            width: 1.5,
            color: AppColors.grey.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
