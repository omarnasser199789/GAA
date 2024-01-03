import 'package:acadmiat/features/home_feature/presentation/pages/consulting/widgets/consulting_list_item.dart';
import 'package:acadmiat/features/home_feature/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:flutter/foundation.dart';
import '../../../../../Theme/style.dart';
import '../../../../../core/util/assets_manager.dart';
import '../../../../../core/widgets/waiting_widget.dart';
import '../../../../../injection_container.dart';
import '../../../../consultancies_feature/domain/entities/consultancies_entity.dart';
import '../../../domain/use_cases/local_db_usecase/update_consultancies_in_local_db_usecase.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';
import '../../bloc/home_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConsultingPage extends StatefulWidget {
  ConsultingPage({super.key,required this.consultanciesEntity});
   List<ConsultanciesEntity> consultanciesEntity;

  @override
  State<ConsultingPage> createState() => _ConsultingPageState();
}

class _ConsultingPageState extends State<ConsultingPage> {
  Size itemSize =  Size(0, 100);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => sl<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (kDebugMode) {
            print("ConsultingState:$state");
          }

          if (widget.consultanciesEntity.isEmpty) {
            ///1-Get data from locale DB
            ///2-Get data from server.
            ///3-View the data we have collected from locale DB.
            ///4-When data come from server,will will hide data from locale DB and
            ///show data from server
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

            for(var item in state.consultanciesFromLocalDbEntity){
              widget.consultanciesEntity.add(
                  ConsultanciesEntity(
                  consultancyId: item.apiId,
                      name: item.name,
                      body: null,
                      image: item.image,
                      consultantName: item.trainerName,
                      numberOfSessions: 0,
                      subscriptionLimit: null,
                      squareImage: null,
                      consultantImage: item.image,
                      consultantInfo: '',
                      consultantId: -1,
                      typeOfSession: null,
                      consultancyPrice: 0,
                      timeLimit: 0,
                      info: null));
            }

          }

          if(state is ConsultanciesIsLoaded){

            ///4-When data come from server,will will hide data from locale DB and
            ///show data from server


            ///Update diplomas and packages in locale DB.
            ///1-Generate diplomas anf packages list.
            List<UpdateConsultanciesParams> list=[];
            for(int i=0;5>i;i++)
            {
              list.add(UpdateConsultanciesParams(
                apiId: state.consultanciesEntity[i].consultancyId,
                image: state.consultanciesEntity[i].image,
                trainerName: state.consultanciesEntity[i].consultantName,
                name: state.consultanciesEntity[i].name,
              ));
            }
            ///Store data in locale DB event

            BlocProvider.of<HomeBloc>(context).add(UpdateConsultanciesFromLocaleDBEvent(params: list));


            widget.consultanciesEntity=[];

            for(int i=0; i<state.consultanciesEntity.length ; i++){
              widget.consultanciesEntity.add(
                  ConsultanciesEntity(
                      consultancyId: state.consultanciesEntity[i].consultancyId,
                      name: state.consultanciesEntity[i].name,
                      body: state.consultanciesEntity[i].body,
                      image: state.consultanciesEntity[i].image,
                      consultantName: state.consultanciesEntity[i].consultantName,
                      numberOfSessions: state.consultanciesEntity[i].numberOfSessions,
                      subscriptionLimit: state.consultanciesEntity[i].subscriptionLimit,
                      squareImage: state.consultanciesEntity[i].squareImage,
                      consultantImage: state.consultanciesEntity[i].image,
                      consultantInfo: state.consultanciesEntity[i].consultantInfo,
                      consultantId: state.consultanciesEntity[i].consultantId,
                      typeOfSession: state.consultanciesEntity[i].typeOfSession,
                      consultancyPrice: state.consultanciesEntity[i].consultancyPrice,
                      timeLimit: state.consultanciesEntity[i].timeLimit,
                      info: state.consultanciesEntity[i].info)

              );
            }
          }

          return Scaffold(

            appBar: appBarWidget("احجز استشارتك مع الخبراء",context,true,[
              GestureDetector(
                onTap: (){goTo(context, (context) =>  const SearchPage());},
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(width: 30, height: 30,
                    child: SvgPicture.asset(ImgAssets.search, color:iconsColor),
                  ),
                ),
              ),
            ],null),
            body: GridView.builder(
                padding:  const EdgeInsets.only(bottom: 17,left: 17,right: 17,top:17),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1, //3 / 2,
                    crossAxisSpacing: 17,
                    mainAxisSpacing: 17),
                itemCount: widget.consultanciesEntity.length,
                itemBuilder: (BuildContext ctx, index) {
                  return ConsultingListItem(index: index,
                    consultantImage: widget.consultanciesEntity[index].image,
                    consultantName: widget.consultanciesEntity[index].consultantName,
                    consultancyName: widget.consultanciesEntity[index].name,
                    id: widget.consultanciesEntity[index].consultancyId,);

                }),
          );
        }));

  }
}
