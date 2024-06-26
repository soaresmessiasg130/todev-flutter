import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/todo_service.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoService>(
      builder: (_, todoService, __) {
        final count = todoService.count.toString();

        return Center(
          child: Row(
            children: [
              Text('$count Todo Services'),
            ],
          ),
        );
      },
    );
  }
}
