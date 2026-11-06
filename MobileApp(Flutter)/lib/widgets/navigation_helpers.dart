import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

Widget surfaceCard({required Widget child, EdgeInsets? padding}) {
  return Container(
    padding: padding ?? const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
    ),
    child: child,
  );
}

void pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
}
