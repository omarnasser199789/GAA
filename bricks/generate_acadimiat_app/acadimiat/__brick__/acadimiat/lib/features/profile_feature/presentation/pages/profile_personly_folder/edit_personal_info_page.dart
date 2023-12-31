import 'package:acadmiat/Theme/style.dart';
import 'package:acadmiat/core/globals.dart';
import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:acadmiat/injection_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../Locale/locale.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/classes/countries.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../domain/entities/user_info_entity.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_event.dart';
import '../../bloc/profile_state.dart';
import 'package:country_code_picker/country_code_picker.dart';

class EditPersonalInfoPage extends StatefulWidget {
  const EditPersonalInfoPage({Key? key, required this.userInfoEntity})
      : super(key: key);
  final UserInfoEntity userInfoEntity;
  @override
  State<EditPersonalInfoPage> createState() => _EditPersonalInfoPageState();
}

class _EditPersonalInfoPageState extends State<EditPersonalInfoPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String countryCodePicker = "";

  @override
  void initState() {
    emailController.text = widget.userInfoEntity.email;
    nameController.text = widget.userInfoEntity.name;
    // phoneNumberController.text = widget.userInfoEntity.phone;

    if (seperatePhoneAndDialCode(widget.userInfoEntity.phone).length == 2) {
      countryCodePicker =
          seperatePhoneAndDialCode(widget.userInfoEntity.phone)[0];
      phoneNumberController.text =
          seperatePhoneAndDialCode(widget.userInfoEntity.phone)[1];
    }
  }

  bool loading = false;
  bool loadingBtn = false;

  List<String> seperatePhoneAndDialCode(String phoneWithDialCode) {
    Map<String, String> foundedCountry = {};

    for (var country in Countries.allCountries) {
      String dialCode = country["dial_code"].toString();

      if (phoneWithDialCode.contains(dialCode)) {
        foundedCountry = country;
      }
    }

    if (foundedCountry.isNotEmpty) {
      var dialCode = phoneWithDialCode.substring(
        0,
        foundedCountry["dial_code"]!.length,
      );
      var newPhoneNumber = phoneWithDialCode.substring(
        foundedCountry["dial_code"]!.length,
      );
      print({dialCode, newPhoneNumber});
      return [dialCode, newPhoneNumber];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    // countryCodePicker="+964";

    var locale = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
        create: (BuildContext context) => sl<ProfileBloc>(),
        child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (kDebugMode) {
            print("state:$state");
          }
          if (state is Loading) {
            loading = true;
          } else {
            loading = false;
          }
          if (state is SuccessUpdateUserInfoEntity) {
            widget.userInfoEntity.phone = state.updateUserInfoEntity.phone;
            widget.userInfoEntity.name = state.updateUserInfoEntity.name;
            widget.userInfoEntity.email = state.updateUserInfoEntity.email;

            if (widget.userInfoEntity.phone ==
                countryCodePicker + phoneNumberController.text) {
              loadingBtn = false;
              showMessage(
                  message: "تم تعديل المعلومات الشخصية",
                  context: context,
                  bgColor: Colors.green);
            }
          }
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: appBarWidget(
                locale.editPersonalInformation!,
                context,
                true,
                [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: SizedBox(
                  //       width: 40,
                  //       height: 40,
                  //       child: CachedNetWorkImage(
                  //         borderRadius: BorderRadius.circular(200),
                  //       )),
                  // ),
                ],
                null),
            body: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: defaultPadding,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          // CustomTextField(
                          //   title: locale.email!,
                          //   maxLines: 1,
                          //   hint: widget.userInfoEntity.email,
                          //   onTap: () {},
                          //   controller: emailController,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: CustomTextField(
                              title: locale.name!,
                              hint: widget.userInfoEntity.name,
                              maxLines: 1,
                              onTap: () {},
                              controller: nameController,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: size.width * 0.6,
                                  child: CustomTextField(
                                    title: locale.mobileNumber!,
                                    keyboardType: TextInputType.phone,
                                    textAlign: TextAlign.left,
                                    controller: phoneNumberController,
                                    hint: '000 000 0000',
                                    onTap: () {},
                                  ),
                                ),
                                Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                      color: textFormFieldFillColor,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Directionality(
                                    textDirection: isEnglish(context)
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.red,
                                        cardColor: Colors.red,
                                        canvasColor: Colors.red,
                                        textTheme: isLight()
                                            ? Typography(
                                                    platform:
                                                        TargetPlatform.iOS)
                                                .black
                                            : Typography(
                                                    platform:
                                                        TargetPlatform.iOS)
                                                .white,
                                        cardTheme: CardTheme(color: Colors.red),
                                      ),
                                      child: CountryCodePicker(
                                        onChanged: (value) {
                                          setState(() {
                                            countryCodePicker =
                                                value.toString();
                                          });
                                        },
                                        textStyle: blackBoldTextStyle(
                                            fontSize: 12, context: context),
                                        searchStyle: blackBoldTextStyle(
                                            fontSize: 12, context: context),
                                        boxDecoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                        ),
                                        closeIcon: Icon(
                                          Icons.close,
                                          color: iconsColor,
                                        ),
                                        searchDecoration: InputDecoration(
                                          border: InputBorder.none,
                                          // hintText: widget.hint,

                                          hintStyle: blackBoldTextStyle(
                                              context: context,
                                              fontSize: 12,
                                              color: hintTextColor),
                                          filled: true,
                                          fillColor: textFormFieldFillColor,

                                          // suffixIcon: (widget.isPassword!=null&&widget.isPassword==true)? GestureDetector(
                                          //     onTap: (){
                                          //
                                          //       setState((){
                                          //         widget.isPassword=false;
                                          //       });
                                          //
                                          //     },
                                          //     child: const Icon(Icons.remove_red_eye_outlined,color: Colors.grey,)):null,

                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: hintTextColor,
                                          ),

                                          contentPadding:
                                              const EdgeInsets.all(8),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .cardColor),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        initialSelection: countryCodePicker,
                                        favorite: [
                                          "+963",
                                          "+971",
                                          "+20",
                                          "+974",
                                          '+973',
                                          '+964',
                                        ], // 'IQ','BH',
                                        // optional. Shows only country name and flag
                                        showCountryOnly: false,
                                        // optional. Shows only country name and flag when popup is closed.
                                        showOnlyCountryWhenClosed: false,
                                        // optional. aligns the flag and the Text left
                                        alignLeft: false,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: size.height * 0.85,
                      alignment: Alignment.bottomCenter,
                      child: SafeArea(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: bottomPadding),
                          child: Hero(
                            tag: "otpBtn",
                            child: CustomButton(
                                title: locale.updateMyDetails!,
                                loading: loadingBtn,
                                onTap: () async {
                                  if (widget.userInfoEntity.phone !=
                                      countryCodePicker +
                                          phoneNumberController.text) {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus &&
                                        currentFocus.focusedChild != null) {
                                      currentFocus.focusedChild!.unfocus();
                                    }

                                    setState(() {
                                      loadingBtn = true;
                                    });
                                  } else {
                                    if (widget.userInfoEntity.name !=
                                        nameController.text) {
                                      setState(() {
                                        loadingBtn = true;
                                      });
                                      BlocProvider.of<ProfileBloc>(context)
                                          .add(UpdateUserInfo(
                                        email: emailController.text,
                                        id: widget.userInfoEntity.id,
                                        name: nameController.text,
                                        phone: countryCodePicker +
                                            phoneNumberController.text,
                                        birthdate: DateTime.now().toString(), //
                                      ));
                                    } else {
                                      showMessage(
                                          message: "لم تقم بتعديل اي معلومات",
                                          context: context,
                                          bgColor: Colors.red);
                                      setState(() {});
                                    }
                                  }
                                }),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
