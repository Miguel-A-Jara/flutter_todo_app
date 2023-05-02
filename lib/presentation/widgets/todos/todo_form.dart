// Libraries

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Project
import 'package:todo_app/config/routes/routes.dart';
import 'package:todo_app/presentation/widgets/common/snackbar.dart';
import 'package:todo_app/presentation/provider/todos/todos_provider.dart';
import 'package:todo_app/presentation/widgets/todos/todo_form_input.dart';

enum _FormValues {
  title('Title'),
  description('Description');

  final String name;
  const _FormValues(this.name);
}

class TodoForm extends StatefulWidget {
  const TodoForm({super.key});

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isFormValid = false;

  void handleFormSubmit(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    if (_formKey.currentState == null) {
      const errorMessage = 'Error: The form hasn\'t been initalized';
      debugPrint(errorMessage);
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackbar(errorMessage: errorMessage, color: colors.error),
      );
    }

    final formValues = _formKey.currentState!.value;
    final todosProvider = context.read<TodosProvider>();

    todosProvider.addTodo(
      title: formValues[_FormValues.title.name],
      description: formValues[_FormValues.description.name],
      priority: 5,
    );

    context.go(MainRoutesTypes.todosPage.value);
    ScaffoldMessenger.of(context).showSnackBar(
      errorSnackbar(
        errorMessage: 'Your todo was added successfully!',
        color: colors.secondary,
      ),
    );
  }

  void handleFormChange(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    if (_formKey.currentState != null) {
      _formKey.currentState!.save();
      _isFormValid = _formKey.currentState?.isValid ?? false;
      setState(() {});
      return;
    }

    const errorMessage = 'Error: formKey not initialized';
    debugPrint(errorMessage);
    ScaffoldMessenger.of(context).showSnackBar(
      errorSnackbar(errorMessage: errorMessage, color: colors.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      onChanged: () => handleFormChange(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: _FormItems(
            onSubmit: () => handleFormSubmit(context),
            isFormValid: _isFormValid,
          ),
        ),
      ),
    );
  }
}

class _FormItems extends StatelessWidget {
  final VoidCallback onSubmit;
  final bool isFormValid;

  const _FormItems({
    required this.onSubmit,
    required this.isFormValid,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TodoFormInput(
          label: _FormValues.title.name,
          isRequired: true,
          validation: (value) {
            return (value == null || value.length < 2)
                ? 'The value should be at least 2 characters long'
                : null;
          },
        ),
        const SizedBox(height: 10),
        TodoFormInput(
          multiline: true,
          isRequired: true,
          label: _FormValues.description.name,
          validation: (value) {
            return (value == null || value.length < 2)
                ? 'The value should be at least 2 characters long'
                : null;
          },
        ),
        const SizedBox(height: 50),
        ElevatedButton.icon(
          onPressed: isFormValid ? onSubmit : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primary,
            foregroundColor: Colors.white,
          ),
          icon: const Icon(Icons.add),
          label: const Text('Submit'),
        )
      ],
    );
  }
}
