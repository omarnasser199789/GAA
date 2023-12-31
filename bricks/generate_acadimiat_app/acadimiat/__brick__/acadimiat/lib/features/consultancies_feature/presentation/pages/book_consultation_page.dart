import 'dart:async';
import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Theme/style.dart';
import '../../../../core/functions.dart';
import '../../../../core/globals.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/room_hour_entity.dart';
import '../../domain/use_cases/present_section/get_room_hours_usecase.dart';
import '../../domain/use_cases/present_section/reserve_meeting_usecase.dart';
import '../bloc/consultancies_bloc.dart';
import '../bloc/consultancies_event.dart';
import '../bloc/consultancies_state.dart';
import 'package:jiffy/jiffy.dart';
class FromTo{
FromTo({required this.from,required this.to});
  DateTime from;
      DateTime to;
}
class BookConsultationPage extends StatelessWidget {
  BookConsultationPage({Key? key,required this.consultancyId,required this.takenDate}) : super(key: key);
  final int consultancyId;
  final List<DateTime> takenDate;

  DateTime fromDate = DateTime.now();

  List<FromTo> times=[];
  String timezone="";
  String day="";
  String dayy="";
  var hour=-1;
  bool loading=false;
  bool loadingBTN=false;
  List<RoomHourEntity> timeList=[];
  List<String> days = [];
  CustomDate customDate =CustomDate(date: [], dateTime: []);





  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery
        .of(context)
        .platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final _debouncer = Debouncer(milliseconds: 500);
    Size size = MediaQuery.of(context).size;






    return BlocProvider(
        create: (BuildContext context) => sl<ConsultanciesBloc>(),
        child:BlocBuilder<ConsultanciesBloc, ConsultanciesState>(//ConsultanciesEvent
            builder: (context, state) {
              if (kDebugMode) {
                print("Book Consultation State :$state");
              }

              if (state is Empty) {

                BlocProvider.of<ConsultanciesBloc>(context).add(
                    GetRoomCalendarEvent(id:40)); /// => SuccessGetRoomCalendar
              }
              if(state is SuccessGetTimezone){
                timezone= state.time;

              }
              if(state is SuccessGetRoomCalendar){
                /**
                 * (state.roomCalendar):The data fetched in this list as this [2,4,5,6]
                 * generateDates():  This method generates dates according to the list<int> passed to it
                 */
                customDate = generateDates(state.roomCalendar,24);
                days = customDate.date;

                /// Fetch the available times on the first day in the list
                BlocProvider.of<ConsultanciesBloc>(context).add(
                    GetRoomHoursEvent(params: RoomHoursParams(
                        consultancyId: consultancyId, date: customDate.dateTime[0].toString())));
              }
              if(state is Loading){
                loading = true;

              }else{
                loading = false;
              }
              if(state is  LoadingBTN){
                loadingBTN = true;
              }else{
                loadingBTN = false;
              }
              if(state is SuccessBookMeeting){
                Future.delayed(const Duration(milliseconds: 100), () {
                  if(state.statusCode == 200){ Navigator.pop(context,200);}
                  else{Navigator.pop(context,501);}
                });
              }

              if(state is SuccessGetRoomHours){
                timeList= state.list;
                for(var item in state.list){
                  List<TimeOfDay> fromTo= fromToTime(item.startFrom,item.endAt);
                  DateTime today = DateTime.now();
                  DateTime fromDate = DateTime(today.year, today.month, today.day, fromTo[0].hour, fromTo[0].minute);
                  DateTime toDate = DateTime(today.year, today.month, today.day, fromTo[1].hour, fromTo[1].minute);

                  times.add(FromTo(from:fromDate,to:toDate ));

                }
                BlocProvider.of<ConsultanciesBloc>(context).add(
                    GetRoomTimezoneEvent(id:40)); /// => SuccessGetTimezone
              }



              return StatefulBuilder(
                builder: (BuildContext context, StateSetter mystate) {

                  return Padding(
                    padding:const EdgeInsets.only(left: 17,right: 17),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding: const EdgeInsets.only(top:30,bottom: 10),
                          child: Text("الأيام المتاحة",style: blackBoldTextStyle(fontSize: 14, context: context),),
                        ),

                        (state is Loading && days.isEmpty)?
                        const WaitingWidget():
                        CustomCupertinoPicker(times: days,onSelectedItemChanged: (index){
                          day= customDate.dateTime[index].toString();
                          _debouncer.run(() {
                            times = [];
                            BlocProvider.of<ConsultanciesBloc>(context).add(
                                GetRoomHoursEvent(params: RoomHoursParams(
                                    consultancyId: consultancyId, date: customDate.dateTime[index].toString())));
                          });
                        },),



                        Padding(
                          padding: const EdgeInsets.only(bottom: 10,top:10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("الاوقات المتاحة",style: blackBoldTextStyle(fontSize: 14, context: context),),
                              Text(timezone.replaceAll('"', ''),style: blackBoldTextStyle(fontSize: 14, context: context),),

                            ],
                          ),
                        ),

                        (state is Loading && times.isEmpty)?
                        const WaitingWidget():
                        Builder(
                          builder: (context) {
                            List <String> stringTime=[];

                            for(var item in times){

                                stringTime.add("من الساعة ${Jiffy(item.from).jm} الى ${Jiffy(item.to).jm}");


                            }




                            return CustomCupertinoPicker(times: stringTime,onSelectedItemChanged: (index){



                              hour=timeList[index].startFrom.toInt();
                              DateTime dateTime = DateTime.parse(day);
                              dateTime = dateTime.add(Duration(hours: times[index].from.hour));
                              dayy=dateTime.toString();


                            },);
                          }
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:30),
                          child: CustomButton(title: "حجز استشارة",loading: (loadingBTN&&times.isNotEmpty&&day.isNotEmpty),onTap: (){


                            if(dayy==""){Navigator.pop(context,500);}
                            BlocProvider.of<ConsultanciesBloc>(context).add(BookMeetingEvent(params:
                            ReserveMeetingParams(
                              roomId: consultancyId,
                              day: dayy,
                              hour: hour,
                              timezone: timezone.replaceAll('"', ''),
                              userId: userId().toString(),

                            ))); /// => SuccessBookMeeting

                          },),
                        )
                      ],
                    ),
                  );


                },
              );

            })
    );




  }


}


List<TimeOfDay> fromToTime(startFrom,endAt){



  int hour = startFrom.round();
  int minute = ((startFrom - hour) * 60).round();
  TimeOfDay timeOfDay = TimeOfDay(hour: hour, minute: minute);


  int endHour = endAt.round();
  int endMinute = ((endAt - hour) * 60).round();
  TimeOfDay endTimeOfDay = TimeOfDay(hour: endHour, minute: endMinute);
  return [timeOfDay,endTimeOfDay];
}
class CustomDate{
  List<String> date;
  List<DateTime> dateTime;
  CustomDate({required this.date,required this.dateTime});
}


class Debouncer {
  final int milliseconds;
  VoidCallback? action;
   Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class CustomCupertinoPicker extends StatelessWidget {
   CustomCupertinoPicker({Key? key,required this.times,required this.onSelectedItemChanged}) : super(key: key);
   List<String> times;
   ValueChanged<int>? onSelectedItemChanged;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return         Padding(
      padding:const EdgeInsets.only(left: 17,right: 17),
      child: SizedBox(
        width:double.infinity,
        height: size.height*0.2,
        child: CupertinoPicker(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          itemExtent: 32.0,
          onSelectedItemChanged: onSelectedItemChanged,

          children: List<Widget>.generate(times.length, (index) {
            final day = times[index];
            return Text(day,style: blackBoldTextStyle(fontSize: 14,context: context),);
          }),
        ),
      ),
    );
  }



}

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Theme.of(context).cardColor,
      highlightColor: const Color.fromRGBO(119, 118, 118, 0.5490196078431373),
      child: Container(
        width: double.infinity,
        height:size.height*0.2,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}

