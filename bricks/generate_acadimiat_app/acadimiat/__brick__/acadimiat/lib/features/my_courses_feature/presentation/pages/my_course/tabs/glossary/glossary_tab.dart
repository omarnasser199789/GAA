import 'package:acadmiat/core/widgets/empty_state_widget.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../../Locale/locale.dart';
import '../../../../../../../../Theme/style.dart';
import 'package:jiffy/jiffy.dart';
import '../../../../../../../../core/widgets/custom_botton.dart';
import '../../../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../../core/functions.dart';
import '../../../../../../../core/util/assets_manager.dart';
import '../../../../../../../injection_container.dart';
import '../../../../../data/models/my_course_model.dart';
import '../../../../../domain/use_cases/post_concept_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'index_widget.dart';
import 'item_list.dart';

class GlossaryTab extends StatefulWidget {
  const GlossaryTab({super.key, required this.glossary});
  final Glossary glossary;
  @override
  State<GlossaryTab> createState() => _GlossaryTabState();
}

class _GlossaryTabState extends State<GlossaryTab> {
  double sizeI = 0;
  List<Widget> widgetList = [];
  List<String> carList = [];
  List<List<Concept>> lists = [];

  bool firstTime=true;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    Jiffy.locale("ar");
    if(firstTime){
      firstTime=false;
      sortList();
    }
    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
            builder: (context, state) {
          if (kDebugMode) {
            print("Glossary State:$state");
          }
          if (state is SuccessPostConceptEntityState) {
            showMessage(message: "تم اضافة المصطلح بنجاح", context: context,bgColor: percentIndicatorColor);

            int h=0;
            for(var item in widget.glossary.concepts) {
              if(item.conceptId==state.conceptEntity.id){h++;}}
            if(h==0){widget.glossary.concepts.add(
                  Concept(conceptId: state.conceptEntity.id,
                      addedBy:"",
                      concept: state.conceptEntity.concept, file: null,
                      definition: state.conceptEntity.definition,
                      keywords: state.conceptEntity.keywords,
                      attachment: null, date: state.conceptEntity.date));
            }
            sortList();
          }
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                onPressed: () async {
                  TextEditingController titleController = TextEditingController();
                  TextEditingController definitionController = TextEditingController();
                  TextEditingController keywordsController = TextEditingController();
                  bool definitionEmpty=false;
                  bool titleEmpty=false;
                  final result = await showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) {
                        return Material(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: StatefulBuilder(builder:
                              (BuildContext context, StateSetter mystate) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 17, right: 17),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 3,
                                          color: Theme.of(context).canvasColor,
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(locale.addANewTerm!,
                                            style: blackBoldTextStyle(context: context, fontSize: 15)),
                                      ],
                                    ),
                                  ),
                                  CustomTextField(
                                    title: locale.termTitle!,
                                    hint: locale.enterTheTitleOfTheTerm!,
                                    controller: titleController,
                                    keyboardType: TextInputType.text,
                                    titleColor: titleEmpty?Colors.red:null,
                                    onTap: () {},
                                  ),
                                  CustomTextField(
                                    title: "كلمات مفتاحية",
                                    hint: locale.enterTheTitleOfTheTerm!,
                                    controller: keywordsController,
                                    keyboardType: TextInputType.text,
                                    onTap: () {},
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 0,
                                        bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: CustomTextField(
                                      title: locale.definitionOfTheTerm!,
                                      hint: locale.enterTheDefinition!,
                                      controller: definitionController,
                                      keyboardType: TextInputType.text,
                                      titleColor:definitionEmpty? Colors.red:null,
                                      maxLength: 250,
                                      maxLines: 5,
                                      onTap: () {},
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 25, left: 35, right: 35),
                                    child: SafeArea(
                                        child: CustomButton(
                                            title: "اضافة مصطلح",
                                            onTap: () {

                                              if(titleController.text != ""&&definitionController.text != "") {
                                                Navigator.pop(context, 200);
                                              }else  if (titleController.text == "") {
                                                mystate(() {
                                                  titleEmpty=true;
                                                });
                                              }else{
                                                mystate(() {
                                                  titleEmpty=false;
                                                });
                                              }
                                                if (definitionController.text == "") {
                                                mystate(() {
                                                  definitionEmpty=true;
                                                });
                                              }else{
                                                  mystate(() {
                                                    definitionEmpty=false;
                                                  });
                                                }
                                            })),
                                  )
                                ],
                              ),
                            );
                          }),
                        );//
                      }).whenComplete(() {

                  });

                  if (result == 200) {
                    BlocProvider.of<MyCoursesBloc>(context).add(
                        PostConceptEvent(
                            params: PostConceptParams(
                                approved: true,
                                attachment: '',
                                concept: titleController.text,
                                date: DateTime.now(),
                                definition: definitionController.text,
                                fileId: null,
                                glossaryId: widget.glossary.glossaryId,
                                id: null,
                                isPublic: '',
                                keywords: keywordsController.text,
                                userId: userId())));
                  }

                },
                backgroundColor: kMainColor,
                child: SvgPicture.asset(
                  ImgAssets.add,
                  color: Colors.white,
                ),
              ),
            ),
            body:( widgetList.isNotEmpty)? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 17, right: 17, top: 10,bottom: 60),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widgetList,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: TextFormField(
                        style: TextStyle(color: Theme.of(context).canvasColor),
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:  'عن ماذا تريد أن تبحث؟',
                          hintStyle: blackBoldTextStyle(context: context,fontSize: 12,color: hintTextColor),
                          filled: true,
                          fillColor: textFormFieldFillColor,
                          prefixIcon:Icon(Icons.search,color: hintTextColor,),
                          contentPadding: const EdgeInsets.all(8),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).cardColor),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),

                        onChanged: (value) {
                          if(value!=""){
                            widgetList = [];
                            for (int i = 0; lists.length > i; i++) {
                              for (int j = 0; lists[i].length > j; j++) {
                                if(lists[i][j].concept.contains(value)){
                                  widgetList.add(IndexWidget(litter: carList[i]));
                                  widgetList.add(ItemList(concept: lists[i][j]));
                                }
                              }
                            }
                          }else{
                            firstTime=true;
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ): SingleChildScrollView(child: Padding(
              padding: const EdgeInsets.only(top:50),
              child: EmptyStateWidget(svg: ImgAssets.glossary, text1: "لا يوجد مصطلحات!", text3: "قم باضافة اول مصطلح"),
            )),
          );
        }));
  }

  void sortList() {
    widgetList = [];
    /// The first letter of the terms is collected and placed in this list
    carList = [];
    for (var item in widget.glossary.concepts) {
      int i = 0;
      for (var cat in carList) {
        if (cat== item.concept[0]) {
          i++;
        }
      }
      if (i == 0) {
        carList.add(item.concept[0]);
      }
    }
    carList.sort();
    ///A list containing lists of words is prepared according to the number of letters present
    lists = [];
    for (var _ in carList) {
      lists.add([]);
    }
    /// The list of terms is scrolled
    for (var item in widget.glossary.concepts) {
      for (int j = 0; lists.length > j; j++) {
        ///If the first element of the list of letters is equal to the first letter of the list of terms, it is added to the list of this letter
        if (carList[j] == item.concept[0]) {
          lists[j].add(item);
        }
      }
    }

    for (int i = 0; lists.length > i; i++) {
      widgetList.add(IndexWidget(
        litter: carList[i],
      ));
      for (int j = 0; lists[i].length > j; j++) {
        widgetList.add(ItemList(
          concept: lists[i][j],
        ));
      }
    }
  }
}



