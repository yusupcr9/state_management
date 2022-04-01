import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_management/domain/core/user/model/user_response.dart';
import 'package:state_management/infrastructure/profile/profile_repository.dart';

part 'profileb_event.dart';
part 'profileb_state.dart';
part 'profileb_bloc.freezed.dart';

class ProfilebBloc extends Bloc<ProfilebEvent, ProfilebState> {
  ProfilebBloc() : super(_Initial()) {
    ProfileRepository _profileRepository = ProfileRepository();

    on<ProfilebEvent>((event, emit) async {
      await event.map(
        started: (value) {},
        getUsersData: (value) async {
          emit(ProfilebState.isLoading());
          // get data from API
          final _result = await _profileRepository.getUsersData();
          // if error yield error state
          // if success yield success state with data

          _result.fold(
            (l) => emit(ProfilebState.isError(l)),
            (r) => emit(ProfilebState.isSuccess(r)),
          );
        },
      );
    });
  }
}
