import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../Theme/style.dart';
// import 'package:pdftron_flutter/pdftron_flutter.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/globals.dart';
import 'package:http/http.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';

import '../../../../../core/widgets/waiting_widget.dart';
import '../../../domain/entities/assignment_entity.dart';
import '../../../domain/entities/files_entity.dart';
import '../../../domain/use_cases/Assignment/get_assignment.dart';
import '../../../domain/use_cases/Assignment/post_new_assignment_usecase.dart';
import '../../../domain/use_cases/local_db_usecase/add_file_in_local_db_usecase.dart';
import '../../../domain/use_cases/local_db_usecase/get_file_by_name_usecase.dart';
import '../../bloc/my_courses_bloc.dart';
import '../../bloc/my_courses_event.dart';
import '../../bloc/my_courses_state.dart';
import '../../../../../injection_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_folding_card/flutter_folding_card.dart';

class ActivityByPageId extends StatefulWidget {
  const ActivityByPageId(
      {Key? key,
      required this.assignmentId,
      required this.toDate,
      required this.fromDate,
      required this.courseId})
      : super(key: key);

  final int assignmentId;
  final int courseId;
  final DateTime fromDate;
  final DateTime toDate;
  @override
  State<ActivityByPageId> createState() => ActivityByPageIdState();
}

class ActivityByPageIdState extends State<ActivityByPageId> {
  final itemCount = 3;
  final foldOutList = <bool>[];
  bool firstOne = true;
  int listHight = 0;
  int selectedItem = 0;
  bool loading = false;
  bool allowUP = true;
  bool loadingFile = false;
  dynamic file;
  String path = "";
  int durationForAnimatedContainer = 500;
  bool getFile = false;
  late AssignmentEntity assignmentEntity = AssignmentEntity(
      assignmentId: -1,
      assignment: '',
      body: '',
      courseName: null,
      courseId: -1,
      isAccepted: false,
      canAttend: false,
      allPending: -1,
      allAccepted: -1,
      allDeclined: -1,
      attempts: []);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Jiffy.locale("ar");

    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
            builder: (context, state) {
          if (kDebugMode) {
            print("State:$state");
          }

          if (state is Empty || state is SuccessPostNewAssignmentEntityState) {
            BlocProvider.of<MyCoursesBloc>(context).add(GetAssignmentEvent(
                getAssignmentParams: GetAssignmentParams(
                    userId: userId(),
                    courseId: widget.courseId,
                    assignmentId: widget.assignmentId)));
            file;
            path = "";
            firstOne = true;
            listHight = 0;
            if (state is SuccessPostNewAssignmentEntityState) {
              allowUP = true;
              showMessage(
                  message: "تم رفع الملف بنجاح",
                  context: context,
                  bgColor: Colors.green);
            }
          }

          if (state is SuccessGetFileEntityState) {
            if (getFile) {
              ///The openOrDownloadFile() function does not allow recursion
              getFile = false;
              openOrDownloadFile(state.filesEntity, context);
            }
          }

          if (state is Error) {
            showMessage(
                message: "لم يتم ترفيع الملف العمليه فشلت", context: context);
          }
          if (state is Loading) {
            loading = true;
          } else {
            loading = false;
          }

          if (state is SuccessAssignmentEntityState) {
            assignmentEntity = state.assignmentEntity;
            if (firstOne) {
              firstOne = false;
              for (var item in assignmentEntity.attempts) {
                foldOutList.add(false);
                listHight += 133;
              }
            }
          }

          if (assignmentEntity.assignmentId != -1) {
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: appBarWidget("", context, true, null, null),
              body: Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 19),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 16, bottom: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  assignmentEntity.assignment,
                                  style: blackBoldTextStyle(
                                      context: context, fontSize: 14),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text(
                                    parseHtmlString(assignmentEntity.body),
                                    style: blackBoldTextStyle(
                                        fontSize: 12,
                                        height: 2,
                                        context: context),
                                  ),
                                ),

                                // Padding(
                                //   padding: const EdgeInsets.only(top: 15,left: 30,right: 30),
                                //   child: CustomButton(
                                //       color: Theme.of(context).primaryColor.withOpacity(0.1),//Theme.of(context).primaryColor.withOpacity(0.1),
                                //       textColor: Theme.of(context).primaryColor,
                                //       title: "قراءة المزيد", onTap: (){
                                //
                                //   }),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svgs/vuesax-linear-calendar.svg",
                                        color: iconsColor,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        // DateFormat("yyyy/MM/dd").format(widget.assignments[index].fromDate)
                                        Jiffy(widget.fromDate).yMMMMd,
                                        style: blackBoldTextStyle(
                                          fontSize: 12,
                                          context: context,
                                          color: iconsColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "-",
                                        style: blackBoldTextStyle(
                                            fontSize: 12, context: context),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        // DateFormat("yyyy/MM/dd").format(widget.assignments[index].toDate)
                                        Jiffy(widget.toDate).yMMMMd,
                                        style: blackBoldTextStyle(
                                            fontSize: 12,
                                            context: context,
                                            color: iconsColor),
                                      ),
                                    ],
                                  ),
                                ),
                                if (assignmentEntity.canAttend == true)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 13, bottom: 15),
                                    child: GestureDetector(
                                      onTap: () async {
                                        final result = await FilePicker.platform
                                            .pickFiles(allowMultiple: true);
                                        if (result == null) return;
                                        file = await _readFileByte(
                                            result.files[0].path!);
                                        path = result.files[0].path!;
                                        setState(() {});
                                      },
                                      child: Container(
                                        // height: 100,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30, bottom: 30),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  if (path == "")
                                                    SvgPicture.asset(
                                                      "assets/svgs/file-upload.svg",
                                                      width: 40,
                                                      color: (path != "")
                                                          ? Theme.of(context)
                                                              .primaryColor
                                                          : iconsColor,
                                                    ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5,
                                                            left: 10,
                                                            right: 10),
                                                    child: Text(
                                                      (path != "")
                                                          ? path.split("/").last
                                                          : "اختر ملف"
//
                                                      ,
                                                      style: blackBoldTextStyle(
                                                        context: context,
                                                        fontSize: 11,
                                                        height: 1.5,
                                                        color: iconsColor,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  if ((path == ""))
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 17),
                                                      child: Text(
                                                        "يمكن اختيار اي نوع من الملفات",
                                                        style: blackBoldTextStyle(
                                                            context: context,
                                                            fontSize: 10,
                                                            color:
                                                                hintTextColor),
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ),
                                            Container(
                                                width: double.infinity,
                                                height:
                                                    (path == "") ? 150 : 100,
                                                child: DashedRect(
                                                  color: (path == "")
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Colors.grey
                                                          .withOpacity(0.5),
                                                  strokeWidth: 2.0,
                                                  gap: 5.0,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                if (assignmentEntity.canAttend == false)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 13, bottom: 15),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 50, bottom: 50),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/svgs/expiry.svg",
                                                  // width: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5,
                                                          left: 10,
                                                          right: 10),
                                                  child: Text(
                                                    "نأسف! انتهت مدة المشاركة في الواجب",
                                                    style: blackBoldTextStyle(
                                                        context: context,
                                                        fontSize: 11,
                                                        height: 1.5,
                                                        color: iconsColor),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Container(
                                          //     width: double.infinity,
                                          //     height: 150,
                                          //     child: DashedRect(
                                          //       color: Colors.grey
                                          //           .withOpacity(0.5),
                                          //       strokeWidth: 2.0,
                                          //       gap: 5.0,
                                          //     )),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (path != "")
                                  ValueListenableBuilder(
                                    valueListenable: counterNotifier,
                                    builder: (context, value, _) {
                                      return CustomButton(
                                        title: "رفع الملف",
                                        width: 150,
                                        loading: loading,
                                        loadingTitle: "$value",
                                        height: 35,
                                        borderRadius: 8,
                                        onTap: () {
                                          if (allowUP) {
                                            allowUP = false;
                                            List<int> flieSize = file;
                                            if (flieSize.length < 11000000) {
                                              BlocProvider.of<MyCoursesBloc>(
                                                      context)
                                                  .add(PostNewAssignmentEvent(
                                                      postNewAssignmentParams:
                                                          PostNewAssignmentParams(
                                                userId: userId(),
                                                file: file,
                                                fileName: path.split("/").last,
                                                assignmentId:
                                                    widget.assignmentId,
                                              )));
                                            } else {
                                              allowUP = true;
                                              showMessage(
                                                  message: "هذا الملف كبير",
                                                  context: context);
                                            }
                                            setState(() {});
                                          }
                                        },
                                      );
                                    },
                                  ),
                                if (assignmentEntity.attempts.isNotEmpty)
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              "ملفات الواجب  (${assignmentEntity.attempts.length})",
                                              style: blackBoldTextStyle(
                                                  fontSize: 14,
                                                  context: context),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 11),
                                        child: AnimatedContainer(
                                          duration: Duration(
                                              milliseconds:
                                                  durationForAnimatedContainer),
                                          height: listHight / 1,
                                          child: ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: assignmentEntity
                                                  .attempts.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20),
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Stack(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 2),
                                                            child: FoldingCard(
                                                              foldOut:
                                                                  foldOutList[
                                                                      index],
                                                              curve: foldOutList[
                                                                          index] ==
                                                                      true
                                                                  ? Curves
                                                                      .easeInCubic
                                                                  : Curves
                                                                      .easeOutCubic,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          900),
                                                              coverBackground:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  ///If the assignment still waiting, Don't open more data
                                                                  if (assignmentEntity
                                                                          .attempts[
                                                                              index]
                                                                          .status !=
                                                                      4) {
                                                                    setState(
                                                                        () {
                                                                      durationForAnimatedContainer =
                                                                          500;
                                                                      foldOutList[
                                                                              index] =
                                                                          true;
                                                                      listHight +=
                                                                          270;
                                                                    });
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .scaffoldBackgroundColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12)),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            14,
                                                                        right:
                                                                            14,
                                                                        top: 14,
                                                                        bottom:
                                                                            14),
                                                                    child:
                                                                        Column(
                                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () async {

                                                                            ///allow to openOrDownloadFile() function to work.
                                                                            getFile = true;

                                                                            ///Test the file had been downloaded before or not using file url
                                                                            ///because when the file is downloaded, the file URl and PATH are stored in Locale DB
                                                                            ///The result is returned in  SuccessGetFileEntityState
                                                                            BlocProvider.of<MyCoursesBloc>(context).add(GetFileByUrlEvent(params: GetFileParams(
                                                                                // url: assignmentEntity.attempts[index].file,
                                                                                url: assignmentEntity.attempts[index].file.split("/").last..split(".").last,
                                                                                index: index)));



                                                                            ///To show waiting indicator to user.
                                                                            selectedItem = index;
                                                                            setState(() {
                                                                              loadingFile = true;
                                                                            });

                                                                          },
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Theme.of(context).scaffoldBackgroundColor,
                                                                            height:
                                                                                40,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                SvgPicture.asset(
                                                                                  "assets/svgs/attachment.svg",
                                                                                  // width: 0,
                                                                                ),
                                                                                Container(
                                                                                  width: size.width * 0.45,
                                                                                  // color: Colors.red,
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Container(
                                                                                        constraints: const BoxConstraints(minWidth: 0, maxWidth: 55), //
                                                                                        child: Text(
                                                                                          assignmentEntity.attempts[index].file.split("/").last.split(".").last + "...",
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: blackBoldTextStyle(fontSize: 12, context: context, color: Colors.blue),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: size.width * 0.28,
                                                                                        child: Text(
                                                                                          assignmentEntity.attempts[index].file.split("/").last..split(".").last,
                                                                                          // overflow: TextOverflow.ellipsis,
                                                                                          maxLines: 1,
                                                                                          style: blackBoldTextStyle(fontSize: 12, context: context, color: Colors.blue),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  Jiffy(assignmentEntity.attempts[index].date).yMMMMd,
                                                                                  style: blackBoldTextStyle(
                                                                                    fontSize: 12,
                                                                                    context: context,
                                                                                    color: iconsColor,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 10),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              if (assignmentEntity.attempts[index].status == 2)
                                                                                Row(
                                                                                  children: [
                                                                                    SvgPicture.asset(
                                                                                      "assets/svgs/Icon feather-check-circle.svg",
                                                                                      width: 20,
                                                                                      color: percentIndicatorColor,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Text(
                                                                                      "تم قبول الحل",
                                                                                      style: blackBoldTextStyle(fontSize: 11, context: context, color: percentIndicatorColor),
                                                                                    ),
                                                                                  ],
                                                                                ),

                                                                              if (assignmentEntity.attempts[index].status == 3) //
                                                                                Row(
                                                                                  children: [
                                                                                    SvgPicture.asset(
                                                                                      "assets/svgs/warning-2.svg",
                                                                                      width: 20,
                                                                                      color: Colors.red,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Text(
                                                                                      "تم رفض الحل",
                                                                                      style: blackBoldTextStyle(fontSize: 11, context: context, color: Colors.red),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              if (assignmentEntity.attempts[index].status == 4) //
                                                                                Row(
                                                                                  children: [
                                                                                    SvgPicture.asset(
                                                                                      "assets/svgs/clock.svg",
                                                                                      width: 20,
                                                                                      color: Colors.orange,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Text(
                                                                                      "بالانتظار",
                                                                                      style: blackBoldTextStyle(fontSize: 11, context: context, color: Colors.orange),
                                                                                    ),
                                                                                  ],
                                                                                ),

                                                                              // Text(state.assignmentEntity.attempts[index].status.toString()),

                                                                              ValueListenableBuilder(
                                                                                  valueListenable: counterNotifier,
                                                                                  builder: (context, value, _) {
                                                                                    if (index == selectedItem && _progress != 0) {
                                                                                      return Stack(
                                                                                        alignment: Alignment.center,
                                                                                        children: [
                                                                                          Center(
                                                                                            child: SizedBox(
                                                                                              width: 30,
                                                                                              height: 30,
                                                                                              child: CircularProgressIndicator(
                                                                                                strokeWidth: 3,
                                                                                                value: _progress,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Text(
                                                                                            (_progress * 100).toString().split(".")[0],
                                                                                            style: const TextStyle(fontSize: 12),
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    } else if (loadingFile && index == selectedItem) {
                                                                                      return SizedBox(
                                                                                        width: 30,
                                                                                        height: 30,
                                                                                        child: CircularProgressIndicator(
                                                                                          backgroundColor: Colors.grey,
                                                                                          color: Theme.of(context).primaryColor,
                                                                                        ),
                                                                                      );
                                                                                    } else {
                                                                                      return Container(
                                                                                        width: 30,
                                                                                        height: 30,
                                                                                      );
                                                                                    }
                                                                                  }),

                                                                              if (assignmentEntity.attempts[index].status != 4)
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "تفاصيل",
                                                                                      style: blackBoldTextStyle(fontSize: 11, context: context, color: Theme.of(context).primaryColor),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Container(
                                                                                      width: 20,
                                                                                      height: 20,
                                                                                      alignment: Alignment.center,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(2000),
                                                                                        color: Theme.of(context).primaryColor,
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.only(right: 3),
                                                                                        child: Icon(
                                                                                          Icons.arrow_forward_ios,
                                                                                          size: 14,
                                                                                          color: Colors.white,
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              expandedCard:
                                                                  Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius: const BorderRadius
                                                                          .only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              8),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              8)),
                                                                  color: Theme.of(
                                                                          context)
                                                                      .scaffoldBackgroundColor,
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                                  child: Column(
                                                                    children: [
                                                                      if (assignmentEntity
                                                                              .attempts[index]
                                                                              .evaluation !=
                                                                          "")
                                                                        Container(
                                                                          height:
                                                                              150,
                                                                          child:
                                                                              SingleChildScrollView(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(top: 16),
                                                                                  child: Row(
                                                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        "ملاحظة المدرب :",
                                                                                        style: blackBoldTextStyle(fontSize: 13, context: context),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(top: 11, bottom: 11),
                                                                                  child: Text(
                                                                                    parseHtmlString(assignmentEntity.attempts[index].evaluation),
                                                                                    style: blackBoldTextStyle(fontSize: 12, height: 1.5, context: context),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      if (assignmentEntity
                                                                              .attempts[index]
                                                                              .fileBack !=
                                                                          "")
                                                                        Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(top: 16),
                                                                              child: Row(
                                                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    "ملف المدرب :",
                                                                                    style: blackBoldTextStyle(fontSize: 13, context: context),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                // selectedItem = index;
                                                                                // setState(() {
                                                                                //   loadingFile = true;
                                                                                // });
                                                                                //
                                                                                // await downloadFile(
                                                                                //   assignmentEntity.attempts[index].fileBack,
                                                                                //   assignmentEntity.attempts[index].fileBack.split("/").last,
                                                                                //
                                                                                //   (List<int> newBytes) {
                                                                                //     bytes.addAll(newBytes);
                                                                                //     final downloadedLength = bytes.length;
                                                                                //     _progress = downloadedLength / contentLength!;
                                                                                //
                                                                                //     counterNotifier.value = "$_progress%";
                                                                                //   },
                                                                                // );
                                                                                // setState(() {
                                                                                //   loadingFile = false;
                                                                                // });

                                                                                getFile = true;
                                                                                BlocProvider.of<MyCoursesBloc>(context).add(GetFileByUrlEvent(params: GetFileParams(url: assignmentEntity.attempts[index].file.split("/").last, index: index)));

                                                                                selectedItem = index;
                                                                                setState(() {
                                                                                  loadingFile = true;
                                                                                });
                                                                              },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(top: 11),
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    SvgPicture.asset(
                                                                                      "assets/svgs/attachment.svg",
                                                                                      width: 20,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    // Container(
                                                                                    //     width: size.width * 0.7,
                                                                                    //     // color: Colors.red,
                                                                                    //     child: Text(
                                                                                    //       assignmentEntity.attempts[index].fileBack.split("/").last,
                                                                                    //       overflow: TextOverflow.ellipsis,
                                                                                    //       style: blackBoldTextStyle(fontSize: 12, context: context, color: Colors.blue),
                                                                                    //     )),

                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Container(
                                                                                          constraints: const BoxConstraints(minWidth: 0, maxWidth: 55), //
                                                                                          child: Text(
                                                                                            assignmentEntity.attempts[index].fileBack.split("/").last.split(".").last + "...",
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            style: blackBoldTextStyle(fontSize: 12, context: context, color: Colors.blue),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: size.width * 0.6,
                                                                                          child: Text(
                                                                                            assignmentEntity.attempts[index].fileBack.split("/").last..split(".").last,
                                                                                            // overflow: TextOverflow.ellipsis,
                                                                                            maxLines: 1,
                                                                                            style: blackBoldTextStyle(fontSize: 12, context: context, color: Colors.blue),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              cover:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    durationForAnimatedContainer =
                                                                        1500;
                                                                    foldOutList[
                                                                            index] =
                                                                        false;
                                                                    listHight -=
                                                                        270;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .scaffoldBackgroundColor,
                                                                      borderRadius: BorderRadius.only(
                                                                          bottomLeft: Radius.circular(
                                                                              8),
                                                                          bottomRight:
                                                                              Radius.circular(8))),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            14,
                                                                        right:
                                                                            14,
                                                                        top: 14,
                                                                        bottom:
                                                                            14),
                                                                    child:
                                                                        Column(
                                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        SvgPicture
                                                                            .asset(
                                                                          "assets/svgs/Icon ionic-ios-arrow-back.svg",
                                                                          width:
                                                                              20,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 10), //
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              // selectedItem = index;
                                                                              // setState(() {
                                                                              //   loadingFile = true;
                                                                              // });
                                                                              // await downloadFile(
                                                                              //   assignmentEntity.attempts[index].file,
                                                                              //   assignmentEntity.attempts[index].file.split("/").last,
                                                                              //
                                                                              //   (List<int> newBytes) {
                                                                              //     bytes.addAll(newBytes);
                                                                              //     final downloadedLength = bytes.length;
                                                                              //     _progress = downloadedLength / contentLength!;
                                                                              //     counterNotifier.value = "$_progress%";
                                                                              //   },
                                                                              // );
                                                                              // setState(() {
                                                                              //   loadingFile = false;
                                                                              // });
                                                                              getFile = true;
                                                                              BlocProvider.of<MyCoursesBloc>(context).add(GetFileByUrlEvent(params: GetFileParams(url: assignmentEntity.attempts[index].file.split("/").last, index: index)));

                                                                              selectedItem = index;
                                                                              setState(() {
                                                                                loadingFile = true;
                                                                              });
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                SvgPicture.asset(
                                                                                  "assets/svgs/attachment.svg",
                                                                                  // width: 0,
                                                                                ),
                                                                                // Container(
                                                                                //     width: size.width * 0.45,
                                                                                //     // color: Colors.red,
                                                                                //     child: Text(
                                                                                //       assignmentEntity.attempts[index].file.split("/").last,
                                                                                //       overflow: TextOverflow.ellipsis,
                                                                                //       style: blackBoldTextStyle(fontSize: 12, context: context, color: Colors.blue),
                                                                                //     )),

                                                                                Container(
                                                                                  width: size.width * 0.45,
                                                                                  // color: Colors.red,
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Container(
                                                                                        constraints: const BoxConstraints(minWidth: 0, maxWidth: 55), //
                                                                                        child: Text(
                                                                                          assignmentEntity.attempts[index].file.split("/").last.split(".").last + "...",
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: blackBoldTextStyle(fontSize: 12, context: context, color: Colors.blue),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: size.width * 0.3,
                                                                                        child: Text(
                                                                                          assignmentEntity.attempts[index].file.split("/").last..split(".").last,
                                                                                          // overflow: TextOverflow.ellipsis,
                                                                                          maxLines: 1,
                                                                                          style: blackBoldTextStyle(fontSize: 12, context: context, color: Colors.blue),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),

                                                                                Text(
                                                                                  Jiffy(assignmentEntity.attempts[index].date).yMMMMd,
                                                                                  style: blackBoldTextStyle(
                                                                                    fontSize: 12,
                                                                                    context: context,
                                                                                    color: iconsColor,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 12),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              if (assignmentEntity.attempts[index].isAccepted == true)
                                                                                Row(
                                                                                  children: [
                                                                                    SvgPicture.asset(
                                                                                      "assets/svgs/Icon feather-check-circle.svg",
                                                                                      width: 20,
                                                                                      color: percentIndicatorColor,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Text(
                                                                                      "تم قبول الحل",
                                                                                      style: blackBoldTextStyle(fontSize: 11, context: context, color: percentIndicatorColor),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              if (assignmentEntity.attempts[index].isAccepted == false)
                                                                                Row(
                                                                                  children: [
                                                                                    SvgPicture.asset(
                                                                                      "assets/svgs/warning-2.svg",
                                                                                      width: 20,
                                                                                      color: Colors.red,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Text(
                                                                                      "تم رفض الحل",
                                                                                      style: blackBoldTextStyle(fontSize: 11, context: context, color: Colors.red),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ValueListenableBuilder(
                                                                                  valueListenable: counterNotifier,
                                                                                  builder: (context, value, _) {
                                                                                    if (index == selectedItem && _progress != 0) {
                                                                                      return Stack(
                                                                                        alignment: Alignment.center,
                                                                                        children: [
                                                                                          Center(
                                                                                            child: SizedBox(
                                                                                              width: 30,
                                                                                              height: 30,
                                                                                              child: CircularProgressIndicator(
                                                                                                strokeWidth: 3,
                                                                                                value: _progress,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Text(
                                                                                            (_progress * 100).toString().split(".")[0],
                                                                                            style: const TextStyle(fontSize: 12),
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    } else if (loadingFile && index == selectedItem) {
                                                                                      return SizedBox(
                                                                                        width: 30,
                                                                                        height: 30,
                                                                                        child: CircularProgressIndicator(
                                                                                          backgroundColor: Colors.grey,
                                                                                          color: Theme.of(context).primaryColor,
                                                                                        ),
                                                                                      );
                                                                                    } else {
                                                                                      return Container(
                                                                                        width: 30,
                                                                                        height: 30,
                                                                                      );
                                                                                    }
                                                                                  }),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              foldingHeight:
                                                                  111,
                                                              expandedHeight:
                                                                  270,
                                                            ),
                                                          ),
                                                          // if(foldOutList[index]==false)
                                                          //
                                                          // Container(height: 5,width: double.infinity,decoration: BoxDecoration(
                                                          //     color: Theme.of(context).scaffoldBackgroundColor,
                                                          //     borderRadius: BorderRadius.circular(12)
                                                          // ),
                                                          // )
                                                        ],
                                                      ),
                                                      // if (loadingFile &&
                                                      //     index == selectedItem)
                                                      //   WaitingWidget(),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                          child: SizedBox(
                        height: 30,
                      )),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return WaitingWidget();
          }
        }));
  }

  double _progress = 0;
  late int contentLength;
  List<int> bytes = [];
  Future<dynamic> downloadFile(String url, String fileName,
      Function(List<int> newBytes) listenFunction, BuildContext context) async {

    bytes = [];
    final request = Request('GET', Uri.parse(url));
    final StreamedResponse response = await Client().send(request);
    contentLength = response.contentLength!;


    response.stream.listen(
      listenFunction,
      onDone: () async {
        _progress = 0;
        String dir = (await getApplicationDocumentsDirectory()).path;
        File file = File('$dir/$fileName');
        await file.writeAsBytes(bytes);

        ///After the file has been downloaded and taken into the device files,
        /// the file path is now stored in the database by URL
        BlocProvider.of<MyCoursesBloc>(context).add(AddFileEvent(
            params: AddFileParams(name: fileName, path: file.path, url: url)));

        ///Trying open the file.
        try {
          OpenFilex.open(file.path);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
        ///To show waiting indicator to user.
        setState(() {
          loadingFile = false;
        });
      },
      onError: (e) {
        if (kDebugMode) {
          print(e);
        }
      },
      cancelOnError: true,
    );

    return "";
  }

  Future<void>  openOrDownloadFile(FilesEntity filesEntity, BuildContext context) async {

    ///If the file has already been set in Locale DB, the filesEntity.items list will not be empty.
    if (filesEntity.items.isNotEmpty) {
      ///Open file
      if (kDebugMode) {
        print("Open File:${filesEntity.items.last.path}");
      }


      /// Checks whether the file system entity with this path exists.
      bool fileExists = await File(filesEntity.items.last.path).exists();

      ///If file exists
      if (fileExists) {
        ///Open file
        try {
          OpenFilex.open(filesEntity.items.last.path);
        } catch (e) {
          if (kDebugMode) {
            print("ERROR");
            print(e);
          }
        }
        setState(() {
          loadingFile = false;
        });
      }

      ///If file (NOT) exists
      else {
        if (kDebugMode) {
          print("File (NOT) exists");
        }
        ///download the file and open it.
        downloadAndOpenFile(filesEntity, context);
      }


    }
    ///The file was not previously downloaded because it does not have an URL in Locale DB
    else {
      ///The file is being downloaded for the first time.
      downloadAndOpenFile(filesEntity, context);
    }
  }

  void downloadAndOpenFile(FilesEntity filesEntity, BuildContext context) {

    downloadFile(
      assignmentEntity.attempts[filesEntity.index].file,
      assignmentEntity.attempts[filesEntity.index].file.split("/").last,
      (List<int> newBytes) {
        bytes.addAll(newBytes);
        final downloadedLength = bytes.length;
        _progress = downloadedLength / contentLength;
        counterNotifier.value = "$_progress%";
      },
      context,
    );
  }
}

Future<Uint8List> _readFileByte(String filePath) async {
  Uri myUri = Uri.parse(filePath);
  File audioFile = new File.fromUri(myUri);
  Uint8List bytes = Uint8List(0);
  await audioFile.readAsBytes().then((value) {
    bytes = Uint8List.fromList(value);
    print('reading of bytes is completed');
  }).catchError((onError) {
    print(
        'Exception Error while reading audio from path:' + onError.toString());
  });

  return bytes;
}

Future<File> _getFile(String filename) async {
  final dir = await getApplicationDocumentsDirectory();
  return File("${dir.path}/$filename");
}

// Future<dynamic> downloadFile(String url, String fileName, String dir) async {
//   HttpClient httpClient = new HttpClient();
//   File file;
//   String filePath = '';
//
//   try {
//
//
//
//     var request = await httpClient.getUrl(Uri.parse(url));
//     var response = await request.close();
//
//     if (response.statusCode == 200) {
//       var bytes = await consolidateHttpClientResponseBytes(response);
//       String dir = (await getApplicationDocumentsDirectory()).path;
//       File file = File('$dir/$fileName');
//       await file.writeAsBytes(bytes);
//       print("kjfdnvjkdfnjkvndfv");
//       try {
//         OpenFilex.open(file.path);
//         print("fvosfdbnkfjbnfdkjbnd");
//       } catch (e) {
//         print(e);
//       }
//       return file;
//     } else
//       filePath = 'Error code: ' + response.statusCode.toString();
//   } catch (ex) {
//     filePath = 'Can not fetch url';
//   }
//   print("fcfdcvfvfd");
//   print(filePath);
//
//   return filePath;
//     return "";
// }

class DashedRect extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedRect(
      {this.color = Colors.black, this.strokeWidth = 1.0, this.gap = 5.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(strokeWidth / 2),
        child: CustomPaint(
          painter:
              DashRectPainter(color: color, strokeWidth: strokeWidth, gap: gap),
        ),
      ),
    );
  }
}

class DashRectPainter extends CustomPainter {
  double strokeWidth;
  Color color;
  double gap;

  DashRectPainter(
      {this.strokeWidth = 5.0, this.color = Colors.red, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(x, 0),
      gap: gap,
    );

    Path _rightPath = getDashedPath(
      a: math.Point(x, 0),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _bottomPath = getDashedPath(
      a: math.Point(0, y),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _leftPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(0.001, y),
      gap: gap,
    );

    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({
    required math.Point<double> a,
    required math.Point<double> b,
    required gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    math.Point currentPoint = math.Point(a.x, a.y);

    num radians = math.atan(size.height / size.width);

    num dx = math.cos(radians) * gap < 0
        ? math.cos(radians) * gap * -1
        : math.cos(radians) * gap;

    num dy = math.sin(radians) * gap < 0
        ? math.sin(radians) * gap * -1
        : math.sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x.toDouble(), currentPoint.y.toDouble())
          : path.moveTo(currentPoint.x.toDouble(), currentPoint.y.toDouble());
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
