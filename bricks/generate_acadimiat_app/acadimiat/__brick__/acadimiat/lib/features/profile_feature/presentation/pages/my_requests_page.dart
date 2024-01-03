import 'package:acadmiat/core/widgets/waiting_widget.dart';
import 'package:acadmiat/features/profile_feature/presentation/bloc/profile_bloc.dart';
import 'package:acadmiat/features/profile_feature/presentation/bloc/profile_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/style.dart';
import '../../../../core/functions.dart';
import '../../../../core/globals.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import '../bloc/profile_event.dart';


class MyRequestsPage extends StatefulWidget {
  const MyRequestsPage({super.key});
  @override
  State<MyRequestsPage> createState() => _MyRequestsPageState();
}

class _MyRequestsPageState extends State<MyRequestsPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    Jiffy.locale("ar");
    return BlocProvider(
        create: (BuildContext context) => sl<ProfileBloc>(),
        child:
        BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (kDebugMode) {
            print("state:$state");
          }
          if (state is Empty ) {
            BlocProvider.of<ProfileBloc>(context)
                .add(GetMyPayments(userId: userId().toString()));
          }
          if(state is SuccessgetMyPaymentsEntity){
            return Scaffold(
              appBar:appBarWidget("طلباتي",context,true,null,null),
              body: Padding(
                padding: defaultPadding,
                child:Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ListView.builder(
                      itemCount: state.myPaymentListEntity.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context,index){
                        return Container(
                          // color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 17,),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 18,right: 18,top:20,bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("رقم الطلب",style: blackBoldTextStyle(context: context,fontSize: 12,color:   hintTextColor),),
                                            const SizedBox(width: 20,),

                                            Text("${state.myPaymentListEntity[index].orderId}#",style: blackBoldTextStyle(context: context,fontSize: 12,color:   hintTextColor),),
                                          ],
                                        ),
                                        Text( Jiffy(state.myPaymentListEntity[index].orderDate).yMMMdjm,style: blackBoldTextStyle(context: context,fontSize: 12,color:   hintTextColor),)
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(state.myPaymentListEntity[index].courseName,style: blackBoldTextStyle(context: context,fontSize: 10),),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top:11),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${state.myPaymentListEntity[index].price}\$",style: blackBoldTextStyle(context: context,fontSize: 14),)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );}),
                ),
              ),
            );
          }
          return const WaitingWidget();

        }));

  }
}
