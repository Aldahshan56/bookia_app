import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Expanded(child: Divider(color: Theme.of(context).colorScheme.onSurface,)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Or Login with",
            style: getFont14TextStyle(context, color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        const Expanded(child: Divider())
      ],
    );
  }
}
