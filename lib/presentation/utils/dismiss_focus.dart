import 'package:flutter/material.dart';

/// Function to unfocus a widget by its given context.
///
/// [context] The widget to be dismissed context.
/// Ex:
/// ```
/// TextFieldInput(
///   onTapOutside: (_) => dismissFocus(context),
/// );
/// ```
void dismissFocus(BuildContext context) {
  final currentFocus = FocusScope.of(context);

  /// This check is necessary so flutter doesn't throw an exception
  /// when there's no focused child.
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
