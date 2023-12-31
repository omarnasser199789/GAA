import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../../Locale/locale.dart';
import '../../../../../../Theme/style.dart';
import '../../../../../../core/widgets/waiting_widget.dart';
import '../../../../../../injection_container.dart';
import '../../../../domain/use_cases/local_db_usecase/update_consultancies_in_local_db_usecase.dart';
import '../../../bloc/home_bloc.dart';
import '../../../bloc/home_event.dart';
import '../../../bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../consulting_page.dart';
import 'consulting_list_item.dart';
class ConsultingWidget extends StatefulWidget {
  const ConsultingWidget({Key? key}) : super(key: key);


  @override
  State<ConsultingWidget> createState() => _ConsultingWidgetState();
}

class _ConsultingWidgetState extends State<ConsultingWidget> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;


    return BlocProvider(
        create: (BuildContext context) => sl<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (kDebugMode) {
                print("ConsultingState:$state");
              }

              if (state is Empty ) {
                ///1-Get data from locale DB
                ///2-Get data from server.
                ///3-View the data we have collected from locale DB.
                ///4-When data come from server,will will hide data from locale DB and
                ///show data from server
                // BlocProvider.of<HomeBloc>(context).add(GetConsultancies()); /// => ConsultanciesIsLoaded
                BlocProvider.of<HomeBloc>(context).add(GetConsultanciesFromLocaleDBEvent()); /// => SuccessGetConsultanciesFromLocalDB


              }

              if(state is SuccessGetConsultanciesFromLocalDB){
                ///2-Get data from server.
                BlocProvider.of<HomeBloc>(context).add(GetConsultancies()); /// => ConsultanciesIsLoaded
                ///If there is no item store in local db, we should view loading widget
                ///while the data is fetched.
                if(state.consultanciesFromLocalDbEntity.isEmpty){
                  return const WaitingWidget();
                }
                ///If there is data in local db
                ///3-View the data we have collected from locale DB.
                ///

                List<Widget> widgetList=[];

                if(state.consultanciesFromLocalDbEntity.isNotEmpty){
                  if(state.consultanciesFromLocalDbEntity.length>=5){
                    for(int i=0; i<5 ; i++){
                      widgetList.add(Padding(
                        padding: const EdgeInsets.only(left: 17),
                        child: ConsultingListItem(index: i,
                          consultantImage: state.consultanciesFromLocalDbEntity[i].image,
                          consultantName: state.consultanciesFromLocalDbEntity[i].trainerName,
                          consultancyName: state.consultanciesFromLocalDbEntity[i].name,
                          id: state.consultanciesFromLocalDbEntity[i].apiId,),
                      ));
                    }
                  }else{
                    for(int i=0; i<state.consultanciesFromLocalDbEntity.length ; i++){
                      widgetList.add(Padding(
                        padding: const EdgeInsets.only(left: 17),
                        child: ConsultingListItem(index: i,
                          consultantImage: state.consultanciesFromLocalDbEntity[i].image,
                          consultantName: state.consultanciesFromLocalDbEntity[i].trainerName,
                          consultancyName: state.consultanciesFromLocalDbEntity[i].name,
                          id: state.consultanciesFromLocalDbEntity[i].apiId,),
                      ));
                    }
                  }

                }





                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18, bottom: 8,top: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            locale.bookYourConsultationWithTheExperts!,
                            style: blackBoldTextStyle(context: context, fontSize: 15),
                          ),
                          // const ShowMoreButton(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: widgetList,)),
                      ),
                    ),
                  ],
                );

              }


              if(state is ConsultanciesIsLoaded){

                ///4-When data come from server,will will hide data from locale DB and
                ///show data from server


                ///Update diplomas and packages in locale DB.
                ///1-Generate diplomas anf packages list.
                List<UpdateConsultanciesParams> list=[];

                if(state.consultanciesEntity.length>5){
                  for(int i=0;5>i;i++)
                  {
                    list.add(UpdateConsultanciesParams(
                      apiId: state.consultanciesEntity[i].consultancyId,
                      image: state.consultanciesEntity[i].image,
                      trainerName: state.consultanciesEntity[i].consultantName,
                      name: state.consultanciesEntity[i].name,
                    ));
                  }
                }else{
                  for(var item in state.consultanciesEntity){
                    list.add(UpdateConsultanciesParams(
                      apiId: item.consultancyId,
                      image: item.image,
                      trainerName: item.consultantName,
                      name: item.name,
                    ));
                  }
                }


                ///Store data in locale DB event

                BlocProvider.of<HomeBloc>(context).add(UpdateConsultanciesFromLocaleDBEvent(params: list));


                List<Widget> widgetList=[];
                if(state.consultanciesEntity.length>5){
                  for(int i=0; 5>i ; i++){
                    widgetList.add(Padding(
                      padding: const EdgeInsets.only(left: 17),
                      child: ConsultingListItem(index: i,
                        consultantImage: state.consultanciesEntity[i].image,
                        consultantName: state.consultanciesEntity[i].consultantName,
                        consultancyName: state.consultanciesEntity[i].name,
                        id: state.consultanciesEntity[i].consultancyId,),
                    ));
                  }
                }else{
                  for(int i=0; state.consultanciesEntity .length>i ; i++){
                    widgetList.add(Padding(
                      padding: const EdgeInsets.only(left: 17),
                      child: ConsultingListItem(index: i,
                        consultantImage: state.consultanciesEntity[i].image,
                        consultantName: state.consultanciesEntity[i].consultantName,
                        consultancyName: state.consultanciesEntity[i].name,
                        id: state.consultanciesEntity[i].consultancyId,),
                    ));
                  }
                }



                widgetList.add(GestureDetector(
                  onTap: (){
                    goTo(context, (context) => ConsultingPage(consultanciesEntity:state.consultanciesEntity));
                  },
                  child: Container(
                      alignment: Alignment.center,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      height: 210,
                      width: 200,
                      child: Text("مشاهدة المزيد",style: blackBoldTextStyle(fontSize: 15, context: context,color: Theme.of(context).primaryColor),)),
                ));

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18, bottom: 8,top: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            locale.bookYourConsultationWithTheExperts!,
                            style: blackBoldTextStyle(context: context, fontSize: 15),
                          ),
                          // const ShowMoreButton(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: widgetList,)),
                      ),
                    ),
                  ],
                );
              }


              return const WaitingWidget();

            }));





  }
}




