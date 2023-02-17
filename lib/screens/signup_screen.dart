import 'dart:convert';

import 'package:a2d_app/models/auth_model.dart';
import 'package:a2d_app/providers/app_providers.dart';
import 'package:a2d_app/screens/home_screen.dart';
import 'package:a2d_app/screens/success_screen.dart';
import 'package:a2d_app/services/keys.dart';
import 'package:a2d_app/services/storage_services.dart';
import 'package:a2d_app/styles.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
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
  late bool buttonStatus, isChecked;
  String countryName = '';
  late bool isObscure = false, emailValid = false, isLoading = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    buttonStatus = false;
    isChecked = false;
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

  void signUpButtonEnabled() {
    buttonStatus = (_nameController.text.isNotEmpty &&
            _phoneController.text.isNotEmpty &&
            _passController.text.isNotEmpty &&
            _emailController.text.isNotEmpty &&
            countryName.isNotEmpty &&
            emailValid == true)
        ? true
        : false;
    print(buttonStatus);
    setState(() {});
  }

  void loginButtonEnabled() {
    buttonStatus = (_passController.text.isNotEmpty &&
            _emailController.text.isNotEmpty &&
            emailValid == true &&
            isChecked == true)
        ? true
        : false;
    print(buttonStatus);
    setState(() {});
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String inputtedCountry,
    required BuildContext context,
  }) async {
    setState(() {
      isLoading = true;
    });
    try {
      final reqBody = jsonEncode({
        Keys.name: name,
        Keys.email: email,
        Keys.phone: phone,
        Keys.password: password,
        Keys.country: inputtedCountry,
      });
      print(reqBody);
      final res = await http.post(
        Uri.parse("${Keys.apiURL}/create-user"),
        body: reqBody,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (res.statusCode == 201) {
        SignUpModel data = SignUpModel.fromJson(
          jsonDecode(res.body),
        );

        StorageServices.setName(data.name!);
        StorageServices.setEmail(data.email!);
        StorageServices.setPhone(data.phone!);
        StorageServices.setPassword(data.pass!);
        StorageServices.setCountry(data.country!);
        StorageServices.setId(data.id!);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (nextPageContext) => const SuccessScreen(),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.onBoardingColour1,
            content: Text(
              capitalize(jsonDecode(res.body)["message"]),
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required bool remember,
  }) async {
    setState(() {
      isLoading = true;
    });
    try {
      final reqBody = jsonEncode({
        Keys.email: email,
        Keys.password: password,
      });

      final res = await http.post(
        Uri.parse("${Keys.apiURL}/login"),
        body: reqBody,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (res.statusCode == 201) {
        LoginModel data = LoginModel.fromJson(jsonDecode(res.body));
        StorageServices.setToken(data.token!);
        StorageServices.setEmail(data.email!);
        StorageServices.setId2(data.id2!);
        StorageServices.setCityId(data.cityId!);

        StorageServices.setSignStatus(remember);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (nextPageContext) => HomeScreen(),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.onBoardingColour1,
            content: Text(
              capitalize(jsonDecode(res.body)[Keys.msg]),
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
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
                if (widget.pageIndex == 0 || widget.pageIndex == 1)
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
                        const SizedBox(
                          height: 25,
                        ),
                        detailsField(
                          hint: "Phone Number",
                          controller: _phoneController,
                          keyboard: TextInputType.phone,
                        ),
                        const SizedBox(
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
                                    signUpButtonEnabled();
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
                        const SizedBox(
                          height: 25,
                        ),
                        detailsField(
                          hint: "Email",
                          controller: _emailController,
                          keyboard: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        detailsField(
                          hint: "Password",
                          controller: _passController,
                          keyboard: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: (() async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            await signUp(
                              name: _nameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                              password: _passController.text,
                              inputtedCountry: countryName,
                              context: context,
                            );
                          }),
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
                            child: Center(
                              child: (isLoading)
                                  ? CircularProgressIndicator(
                                      color: AppColors.white,
                                    )
                                  : Text(
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
                        const SizedBox(
                          height: 25,
                        ),
                        detailsField(
                          hint: "Password",
                          controller: _passController,
                          keyboard: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                  width: 0.5,
                                ),
                              ),
                              value: isChecked,
                              onChanged: ((checked) {
                                StorageServices.setSignStatus(checked!);
                                setState(() {
                                  isChecked = checked;
                                });
                                loginButtonEnabled();
                              }),
                            ),
                            Text("Remember me"),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: (() {
                            FocusManager.instance.primaryFocus?.unfocus();
                            login(
                              email: _emailController.text,
                              password: _passController.text,
                              remember: isChecked,
                            );
                          }),
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
                            child: Center(
                              child: (isLoading)
                                  ? CircularProgressIndicator(
                                      color: AppColors.white,
                                    )
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 8,
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
                              buttonStatus = false;
                              isObscure = true;
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
                              emailValid = false;
                              isObscure = true;
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
                  height: size.height / 20,
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
        if (widget.pageIndex == 0) {
          signUpButtonEnabled();
        }
        if (widget.pageIndex == 1) {
          loginButtonEnabled();
        }
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
