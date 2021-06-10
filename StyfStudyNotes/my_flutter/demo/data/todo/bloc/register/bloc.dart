import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../model/user_bean.dart';
import '../authentic/bloc.dart';
import '../../api/repositories/user_repository.dart';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';

part 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;

  RegisterBloc(RegisterState initialState, this.userRepository)
      : super(initialState);

  // RegisterBloc({
  //   @required this.userRepository,
  // })  : assert(userRepository != null),
  //       super(null);

  // @override
  // RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EventRegister) {
      yield RegisterLoading();
      try {
        var success = await userRepository.doRegister(event.user);
        print(success);
        if (success) {
          yield RegisterSuccess();
        } else {
          yield RegisterFailure(error: '注册失败!');
        }
        yield RegisterInitial();
      } catch (error) {
        yield RegisterFailure(error: error.toString());
      }
    }
  }
}
