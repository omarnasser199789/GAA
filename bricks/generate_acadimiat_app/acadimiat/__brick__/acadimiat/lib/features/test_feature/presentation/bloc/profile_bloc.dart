
import 'package:acadmiat/features/test_feature/presentation/bloc/success_error/either_success_or_error.dart';

import '../../domain/use_cases/my_plans/get_post_by_id_usecase.dart';
import '../../domain/use_cases/my_plans/post_my_plan_usecase.dart';
import 'bloc.dart';



const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class TestBloc extends Bloc<TestEvent, TestState> {

  final GetTestUseCase getTestUseCase;
  final GetPostByIdUseCase getPostByIdUseCase;


  TestBloc({

    required GetTestUseCase concreteGetTestUseCase,
    required GetPostByIdUseCase concreteGetPostByIdUseCase,
  })  :
        assert(concreteGetTestUseCase != null),

        getTestUseCase = concreteGetTestUseCase,
        getPostByIdUseCase = concreteGetPostByIdUseCase,
        super(Empty());

  @override
  Stream<TestState> mapEventToState(TestEvent event) async* {

    if(event is GetEvent){
      yield Loading();
      final failureOrPhysician = await getTestUseCase("");
      yield* GetTestSuccessOrErrorState(failureOrPhysician);
    }

    if(event is GetPost){
      yield Loading();
      final failureOrPhysician = await getPostByIdUseCase(event.id);
      yield* SuccessGetPostOrErrorState(failureOrPhysician);
    }

  }


}
