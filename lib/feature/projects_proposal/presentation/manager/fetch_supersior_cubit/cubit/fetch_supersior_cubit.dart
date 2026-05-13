import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/supervisor_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_supersior_state.dart';

class FetchSupersiorCubit extends Cubit<FetchSupersiorState> {
  final SupabaseClient supabase;

  FetchSupersiorCubit(this.supabase) : super(FetchSupersiorInitial());

  Future<void> fetchAvailableSupersior() async {
    emit(FetchSupersiorLoading());

    try {
      /// 1) get app setting
      final setting = await supabase
          .from('app_settings')
          .select('max_group')
          .eq('id', 1)
          .single();

      final int maxGroup = setting['max_group'] ?? 0;

      /// 2) get supervisors
      final response = await supabase.from('supervisors_details').select('''
            id,
            current_groups_count,
            users!supervisors_details_id_fkey(
              id,
              name
            )
          ''');

      final supervisors = (response as List)
          .map((e) {
            final user = e['users'];

            return SupervisorEntity(
              id: user['id'].toString(),
              name: user['name'] ?? '',
              currentGroups: e['current_groups_count'] ?? 0,
              maxGroups: maxGroup,
            );
          })
          .where((e) => e.currentGroups < e.maxGroups)
          .toList();

      emit(FetchSupersiorLoaded(supervsiorAvailable: supervisors));
    } catch (e) {
      emit(FetchSuperiorError(message: e.toString()));
    }
  }
}
