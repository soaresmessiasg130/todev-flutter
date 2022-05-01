import 'package:flutter/material.dart';
import 'package:to_dev/app/components/date_input.dart';
import 'package:to_dev/app/components/time_input.dart';

class CreateTodoForm extends StatefulWidget {
  const CreateTodoForm({Key? key}) : super(key: key);

  @override
  State<CreateTodoForm> createState() => _CreateTodoFormState();
}

class _CreateTodoFormState extends State<CreateTodoForm> {
  final _formKey = GlobalKey<FormState>();
  final descController = TextEditingController();
  late FocusNode descFocusNode;

  @override
  void initState() {
    super.initState();

    descFocusNode = FocusNode();

    descFocusNode.requestFocus();
  }

  @override
  void dispose() {
    descFocusNode.dispose();

    descController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Todo',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              const Text('Description'),
              const SizedBox(height: 8),
              TextFormField(
                controller: descController,
                focusNode: descFocusNode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This input is empty...';
                  }

                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Todo\'s description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Start'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          DateInput(restorationId: 'date_input'),
                          TimeInput(restorationId: 'time_input'),
                        ],
                      ),
                      const Text('End'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          DateInput(restorationId: 'date_input'),
                          TimeInput(restorationId: 'time_input'),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Status'),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pop();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Done'),
                          ),
                        );
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
