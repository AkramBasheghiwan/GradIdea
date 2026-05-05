import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/di/injection_container.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/presentation/manager/proposal_search/proposal_bloc.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/presentation/view/widgets/search_proposal_view_body.dart';

class SearchProposalView extends StatelessWidget {
  const SearchProposalView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProposalSearchBloc>(),
      child: const SearchProposalViewBody(),
    );
  }
}
