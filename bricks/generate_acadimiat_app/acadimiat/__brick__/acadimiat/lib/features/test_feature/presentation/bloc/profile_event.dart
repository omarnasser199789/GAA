

import '../../domain/use_cases/my_plans/post_my_plan_usecase.dart';

abstract class TestEvent {}



class GetEvent extends TestEvent {
}


class GetPost extends TestEvent {
  int id;
  GetPost({required this.id});
}
