import 'package:get_it/get_it.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/data/data_source/proposal_approved_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/data/repository/proposal_approved_repositiory_impl.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/domain/repository/proposal_approved_repository.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/presentation/manager/proposal_search/proposal_bloc.dart';

class ProposalAndSearchInjection {
  static void init(GetIt sl) {
    sl.registerLazySingleton<ProposalApprovedRemoteDataSource>(
      () => ProposalApprovedRemoteDataSourceImpl(sl()),
    );

    //repository
    sl.registerLazySingleton<ProposalApprovedRepository>(
      () => ProposalApprovedRepositoryImpl(sl()),
    );

    // cubit search

    sl.registerFactory<ProposalSearchBloc>(
      () => ProposalSearchBloc(sl<ProposalApprovedRepository>()),
    );
  }
}
