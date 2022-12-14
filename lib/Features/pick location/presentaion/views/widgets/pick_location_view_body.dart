import 'package:flutter/material.dart';

import '../../../../../core/widgets/space_box.dart';
import '../../../../../styles.dart';
import 'choices_builder.dart';

class PickLocationViewBody extends StatelessWidget {
  const PickLocationViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceBox(
              height: 7,
            ),
            Text(
              'Pick your Location',
              style: Styles.bodyText5,
            ),
            const SpaceBox(
              height: 10,
            ),
            const ChoicesBuilder(),
          ],
        ),
      ),
    );
  }
}
