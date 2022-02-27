import 'package:flutter/material.dart';

import '../../jobs/widgets/job_list_item_applied.dart';

class AppliedView extends StatelessWidget {
  const AppliedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        itemBuilder: (cxt, index) {
          return const JobListItemApplied();
        },
        separatorBuilder: (cxt, index) {
          return const SizedBox(height: 10.0);
        },
        itemCount: 3,
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
