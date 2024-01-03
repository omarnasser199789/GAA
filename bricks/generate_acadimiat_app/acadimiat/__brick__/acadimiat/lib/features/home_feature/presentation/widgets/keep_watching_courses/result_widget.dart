import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../../Locale/locale.dart';
import '../../../../../../Theme/style.dart';
import '../../../../../../core/functions.dart';
import '../../../../../../core/globals.dart';
import '../../../../my_courses_feature/domain/entities/my_courses_entity.dart';
import '../../../../my_courses_feature/presentation/pages/my_course/course_page/course_page.dart';
import 'item_list.dart';

class ResultWidget extends StatefulWidget {
  const ResultWidget({super.key,required this.myCoursesEntity});
 final List<MyCoursesEntity> myCoursesEntity;

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  List<MyCoursesEntity> storedData = [];
  TextEditingController searchTextController = TextEditingController();

  List<Widget> widgetList =[];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    Size size =MediaQuery.of(context).size;

    int count=0;
    if(widget.myCoursesEntity.length<5){
      count = widget.myCoursesEntity.length;
    }else{
      count=5;
    }

    widgetList=[];

    for(int i=0; i<count;i++){
      widgetList.add(
          ItemList(
            onTap: (){
              courseId=widget.myCoursesEntity[i].id;
              goTo(context, (context) =>
                  CoursePage(
                    userId: userId(),
                    courseId:widget.myCoursesEntity[i].id,
                    imageUrl:widget.myCoursesEntity[i].image,
                  )
              );
            },
            enableBroadcast: ! widget.myCoursesEntity[i].isCourse,
            typeCourse: locale.courses!,
            imageUrl:  widget.myCoursesEntity[i].image,
            header: widget.myCoursesEntity[i].header,
            trainer: widget.myCoursesEntity[i].trainer,
            percent:widget.myCoursesEntity[i].percent,
            total: widget.myCoursesEntity[i].total,
            courseId:widget.myCoursesEntity[i].id,
          )
      );
    }

    widgetList.add(GestureDetector(
      onTap: (){
        bottomNavigationKey.currentState!.setPage(2);
        // goTo(context, (context) => ConsultingPage(consultanciesEntity:state.consultanciesEntity));
      },
      child: Container(
          alignment: Alignment.center,
          color: Theme.of(context).scaffoldBackgroundColor,
          height: 200,
          width: 200,
          child: Text("مشاهدة المزيد",style: blackBoldTextStyle(fontSize: 15, context: context,color: Theme.of(context).primaryColor),)),
    ));

    return Padding(
      padding: const EdgeInsets.only(right: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.only(top:18,bottom: 8),
            child: Text("تابع مشاهدة دوراتك",style: blackBoldTextStyle(fontSize: 15, context: context),),
          ),

          SizedBox(
            height: 200,
            width: size.width,
            child: SingleChildScrollView(
              scrollDirection:Axis.horizontal,
              child: Row(
                  children: widgetList
              ),
            ),
          ),
        ],
      ),
    );
  }


}