// Libraries
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Project

class TodoFormInput extends StatelessWidget {
  final String label;
  final bool multiline;
  final bool isRequired;
  final String? Function(String? value) validation;

  const TodoFormInput({
    required this.label,
    required this.validation,
    this.isRequired = false,
    super.key,
    this.multiline = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return IntrinsicHeight(
      child: FormBuilderTextField(
        name: label,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: multiline ? null : 1,
        expands: multiline,
        validator: validation,
        keyboardType: multiline ? TextInputType.multiline : TextInputType.text,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: colors.secondary,
            ),
          ),
          label: Text(isRequired ? '$label *' : label),
          filled: true,
          labelStyle: const TextStyle(color: Colors.white),
          fillColor: colors.secondary.withOpacity(0.25),
        ),
      ),
    );
  }
}
