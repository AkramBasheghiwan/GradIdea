import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/utils/app_role.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/supervisor_entity.dart'
    show SupervisorEntity;
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_supervisor_state.dart';

class FetchSupervisorCubit extends Cubit<FetchSupervisorState> {
  SupabaseClient supabase;
  FetchSupervisorCubit(this.supabase) : super(FetchSupervisorInitial());

  Future<void> fetchAvailableSupersior() async {
    emit(FetchSupersiorLoading());

    try {
      final response = await supabase
          .from('users')
          .select()
          .eq('role', AppRoles.supervisor);

      final supervisors = (response as List).map((e) {
        return SupervisorEntity(id: e['id'], name: e['name'] ?? '');
      }).toList();

      emit(FetchSupersiorLoaded(supervsiorAvailable: supervisors));
    } catch (e) {
      emit(FetchSuperiorError(message: e.toString()));
    }
  }
}
