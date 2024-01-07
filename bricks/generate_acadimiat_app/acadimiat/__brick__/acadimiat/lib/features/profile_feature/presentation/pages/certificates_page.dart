import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_folding_card/flutter_folding_card.dart';
import '../../../../Theme/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/functions.dart';
import '../../../../core/globals.dart';
import '../../../../core/util/assets_manager.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../../core/widgets/cached_net_work_image.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/my_certificates_entity.dart';
import '../../domain/use_cases/my_certificate_folder/export_certificate_to_pdf_usecase.dart';
import '../bloc/bloc.dart';
import 'package:flutter/services.dart';


class CertificatesPage extends StatefulWidget {
  const CertificatesPage({super.key});

  @override
  State<CertificatesPage> createState() => _CertificatesPageState();
}

class _CertificatesPageState extends State<CertificatesPage> {
  final itemCount = 3;
  final foldOutList = <bool>[];
  bool firstOne = true;
  int selectedItem = 0;
  bool loadingFile = false;
  List<MyCertificatesEntity> myCertificatesListEntity=[];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
        create: (BuildContext context) => sl<ProfileBloc>(),
        child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (kDebugMode) {
            print("State:$state");
          }
          if (state is Empty) {
            BlocProvider.of<ProfileBloc>(context)
                .add(GetMyCertificates(userId: userId()));
          }
          if(state is ExportCertificateToPDFEntity){
              loadingFile = false;
              BlocProvider.of<ProfileBloc>(context).add(GetMyCertificates(userId: userId()));
          }
          if (state is SuccessGetMyCertificatesEntity) {
            if (firstOne) {
              firstOne = false;
              for (var _ in state.myCertificatesListEntity) {
                foldOutList.add(false);
              }
              if(foldOutList.isNotEmpty) {
                foldOutList[0] = true;
              }
            }
            myCertificatesListEntity=state.myCertificatesListEntity;

          }

          return Scaffold(
            appBar: appBarWidget("شهاداتي", context, true, null, null),
            body:
            (myCertificatesListEntity.isNotEmpty)?
            ListView.builder(
              itemCount: myCertificatesListEntity.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 17, right: 17, top: 13),
                  child: FoldingCard(
                    foldOut: foldOutList[index],
                    curve: foldOutList[index] == true
                        ? Curves.easeInCubic
                        : Curves.easeOutCubic,
                    duration: const Duration(milliseconds: 1400),
                    coverBackground: GestureDetector(
                      onTap: () {
                        setState(() {
                          foldOutList[index] = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 12, right: 12, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                ImgAssets.certificate,
                              ),
                              const SizedBox(
                                width: 11,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                  myCertificatesListEntity[index]
                                        .certificateName,
                                    style:
                                    blackRegularTextStyle(fontSize: 12),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, bottom: 12),
                                    child: Text(
                                      myCertificatesListEntity[index]
                                          .courseName,
                                      style: blackBoldTextStyle(
                                          fontSize: 12, context: context),
                                    ),
                                  ),
                                  Text(
                                    'عرض الشهادة',
                                    style: blackBoldTextStyle(
                                        fontSize: 12,
                                        context: context,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    expandedCard: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 11),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: size.width - 58,
                                    height: 225,
                                    child: CachedNetWorkImage(
                                      borderRadius: BorderRadius.circular(10),
                                      boxFit: BoxFit.cover,
                                      url: myCertificatesListEntity[index]
                                          .image,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: SizedBox(
                                    width: 130,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Button(
                                          svg: "assets/svgs/linkedin-icon.svg",
                                          padding: 7,
                                          onTap: () async {

                                            final result = await showModalBottomSheet(
                                                context: context,
                                                backgroundColor:
                                                Colors.transparent,
                                                isScrollControlled: true,
                                                builder: (context) {
                                                  return Material(
                                                    color: Theme.of(
                                                        context)
                                                        .scaffoldBackgroundColor,
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        topRight: Radius.circular(10)),
                                                    child: StatefulBuilder(
                                                        builder: (BuildContext
                                                        context, StateSetter mystate) {
                                                          return Padding(
                                                            padding:
                                                            const EdgeInsets.only(left: 17, right: 17),
                                                            child: Column(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .min,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 15),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.center,
                                                                    children: [
                                                                      Container(width: 50,
                                                                        height: 3,
                                                                        color: Theme.of(context).canvasColor,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      bottom: 17,
                                                                      top: 33),
                                                                  child: Text(
                                                                    "إضافة الشهادة على حساب لينكد ان",
                                                                    style: blackBoldTextStyle(
                                                                        fontSize: 13,
                                                                        context: context),
                                                                  ),
                                                                ),
                                                                TextToCopy(
                                                                  title:
                                                                  "الاسم (Name)",
                                                                  textToCopy:
                                                                  myCertificatesListEntity[index].certificateName, mystate: mystate, index: 0,
                                                                ),
                                                                 TextToCopy(
                                                                 mystate: mystate,
                                                                  title:
                                                                  "جهة الاصدار (Issuing orgnazation)",
                                                                  textToCopy:
                                                                  "Emastery", index: 1,
                                                                ),
                                                                 TextToCopy(
                                                                  mystate: mystate,
                                                                  title:
                                                                  "تاريخ الاصدار (Issue Date)",
                                                                  releaseMonth:
                                                                  "Novamber",
                                                                  releaseYear:
                                                                  "2020", index: 2,
                                                                ),
                                                                TextToCopy(
                                                                 mystate: mystate,
                                                                  title:
                                                                  "معرف الاعتماد  (Credential ID)",
                                                                  textToCopy:
                                                                  myCertificatesListEntity[index].id.toString(), index: 3,
                                                                ),
                                                                 TextToCopy(
                                                                  mystate: mystate,
                                                                  title:
                                                                  "رابط الشهادة  (Credential  URL)",
                                                                  textToCopy:
                                                                  "الرابط", index: 4,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(
                                                                      top: 40,
                                                                      bottom:
                                                                      20),
                                                                  child:
                                                                  SafeArea(
                                                                    child:
                                                                    CustomButton(
                                                                      title:
                                                                      "    إضافة على حساب لينكد ان",
                                                                      svg:
                                                                      "assets/svgs/linkedin-icon.svg",
                                                                      onTap:
                                                                          () async {

                                                                        // <a target="_blank" onclick="window._paq.push(['trackEvent', 'Learning Activity', 'User clicks the button “Add to LinkedIn Profile” at the instruction (how to add certificate) page', 'Blend', 'Core']);" href="https://www.linkedin.com/profile/add?startTask=CERTIFICATION_NAME">Add to LinkedIn Profile</a>

                                                                        final Uri
                                                                        url =
                                                                        Uri.parse("https://www.linkedin.com/profile/add?startTask=CERTIFICATION_NAME");
                                                                        if (!await launchUrl(
                                                                            url)) {
                                                                          throw 'Could not launch $url';
                                                                        }
                                                                      },
                                                                      borderRadius:
                                                                      5,
                                                                      color: const Color.fromRGBO(10, 102, 194, 1),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                  ); //
                                                }).whenComplete(() {});

                                            if (result == 200) {}
                                          },
                                        ),
                                        Button(
                                          svg: "assets/svgs/share.svg",
                                          padding: 7,
                                          onTap: () {

                                          },
                                        ),
                                        ValueListenableBuilder(
                                            valueListenable: counterNotifier,
                                            builder: (context, value, _) {

                                                if (loadingFile && index == selectedItem) {
                                                return SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child:
                                                  CircularProgressIndicator(
                                                    backgroundColor:
                                                    Colors.grey,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                );
                                              }
                                              else {
                                                return Button(
                                                  svg:
                                                  "assets/svgs/download-icon.svg",
                                                  padding: 1,
                                                  onTap: () {
                                                    setState(() {
                                                      loadingFile = true;

                                                      selectedItem = index;

                                                    });

                                                    BlocProvider.of<ProfileBloc>(
                                                        context).add(ExportCertificateToPdfEvent(
                                                        params: ExportCertificatesToPdfParams(
                                                            courseId:myCertificatesListEntity[index].courseId,
                                                            id: myCertificatesListEntity[index].id,
                                                            userId: userId().toString(),
                                                            certificateName:
                                                            '')));
                                                  },
                                                );
                                              }
                                            }),

                                        //
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    cover: GestureDetector(
                      onTap: () {
                        setState(() {
                          foldOutList[index] = false;

                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: (foldOutList[index] == false)
                                ? BorderRadius.circular(10)
                                : const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 12, right: 12, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/svgs/certificate.svg",
                              ),
                              const SizedBox(
                                width: 11,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(myCertificatesListEntity[index]
                                        .certificateName,
                                    style:
                                    blackRegularTextStyle(fontSize: 12),
                                  ),
                                  Text(myCertificatesListEntity[index]
                                        .courseName,
                                    style: blackBoldTextStyle(
                                        fontSize: 12, context: context),
                                  ),
                                  Text(
                                    'إغلاق',
                                    style: blackBoldTextStyle(
                                        fontSize: 10,
                                        context: context,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    foldingHeight: 100,
                    expandedHeight: 300,
                  ),
                );
              },
            ):
            const EmptyStateWidget(svg:"assets/svgs/certificate_empty.svg",
              text1:"لم تحصل على شهادة بعد!",
              text3: "عند حصولك على شهادة جديدة، سوف تجدها هنا",

            ),
          );
        }));
  }
}

class TextToCopy extends StatefulWidget {
   const TextToCopy(
      {super.key,
      required this.title,
      required this.mystate,
        required this.index,

      this.textToCopy,
      this.releaseMonth,
      this.releaseYear});
  final String title;
  final String? textToCopy;
  final String? releaseMonth;
  final String? releaseYear;
  final StateSetter mystate;
  final int index;

  @override
  State<TextToCopy> createState() => _TextToCopyState();
}

class _TextToCopyState extends State<TextToCopy> {
  bool successCopy=false;

  int  selectedIndex=-1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: blackBoldTextStyle(fontSize: 13, context: context),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (widget.textToCopy != null)
            Container(
              width: size.width - 34,
              height: 44,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 19, right: 19),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.textToCopy!,
                      style: blackBoldTextStyle(fontSize: 11, context: context),
                    ),
                    GestureDetector(
                      onTap: (){
                        Clipboard.setData(ClipboardData(text: widget.textToCopy!));

                        successCopy=true;
                        selectedIndex= widget.index;
                        widget.mystate((){

                        });
                      },
                      child: Text(
                        (selectedIndex==widget.index)?
                        "تم النسخ":"نسخ",
                        style: blackBoldTextStyle(
                            fontSize: 11, context: context, color: (selectedIndex==widget.index)?Colors.green:Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (widget.releaseMonth != null && widget.releaseYear != null)
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 19, right: 19),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.releaseMonth!,
                            style: blackBoldTextStyle(
                                fontSize: 11, context: context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 17,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 19, right: 19),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.releaseYear!,
                            style: blackBoldTextStyle(
                                fontSize: 11, context: context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button(
      {super.key, required this.svg, required this.onTap, required this.padding});

  final String svg;
  final Function() onTap;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: SvgPicture.asset(
            svg,
            color: Theme.of(context).canvasColor,
          ),
        ),
      ),
    );
  }
}
