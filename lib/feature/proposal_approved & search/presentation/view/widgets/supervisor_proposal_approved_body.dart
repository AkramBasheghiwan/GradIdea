import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/router/app_routes.dart';

import 'package:graduation_management_idea_system/core/widgets/custom_build_card_projects_approved.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/presentation/manager/proposal_approved/proposal_approve_cubit.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/presentation/manager/proposal_approved/proposal_approved_state.dart';

class ProposalApprovedBody extends StatefulWidget {
  const ProposalApprovedBody({super.key});

  @override
  State<ProposalApprovedBody> createState() => _ProposalApprovedBodyState();
}

class _ProposalApprovedBodyState extends State<ProposalApprovedBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<ProposalApprovedCubit>().fetchFirstPage();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= 200) {
      context.read<ProposalApprovedCubit>().fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<ProposalApprovedCubit>().fetchFirstPage();
      },
      child: BlocBuilder<ProposalApprovedCubit, ProposalApprovedState>(
        builder: (context, state) {
          if (state is ProposalApprovedLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProposalApprovedError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ProposalApprovedCubit>().fetchFirstPage(),
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          } else if (state is ProposalApprovedLoaded) {
            final projects = state.users;
            final hasReachedMax = state.hasReachedMax;

            if (projects.isEmpty) {
              return const Center(
                child: Text(
                  'لا توجد مشاريع معتمدة في هذا القسم بعد 📚',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            // رسم القائمة اللانهائية
            return ListView.builder(
              controller: _scrollController,

              itemCount: hasReachedMax ? projects.length : projects.length + 1,
              itemBuilder: (context, index) {
                if (index >= projects.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  );
                }

                final project = projects[index];
                return CustomBuildCardProjectsApproved(
                  project: project,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.proposalDetail,
                      arguments: project,
                    );
                  },
                );
              },
            );
          }

          // الحالة الابتدائية الصامتة
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
