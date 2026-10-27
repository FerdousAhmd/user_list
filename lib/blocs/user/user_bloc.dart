
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(const UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(const UserLoading());

      try {
        final users = await _userRepository.getUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
