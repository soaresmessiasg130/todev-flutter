import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BottomBar extends StatelessWidget {
  BottomBar({Key? key}) : super(key: key);

  final List<Widget> buttons = [
    IconButton(
      onPressed: () => Modular.to.navigate('dashboard'),
      color: Colors.white,
      padding: EdgeInsets.all(16),
      icon: Icon(
        Icons.dashboard,
      ),
    ),
    IconButton(
      onPressed: () => Modular.to.navigate('todos'),
      color: Colors.white,
      padding: EdgeInsets.all(16),
      icon: Icon(
        Icons.format_list_bulleted,
      ),
    ),
    SizedBox(
      width: 24,
    ),
    IconButton(
      onPressed: () => Modular.to.navigate('search'),
      color: Colors.white,
      padding: EdgeInsets.all(16),
      icon: Icon(
        Icons.search,
      ),
    ),
    IconButton(
      onPressed: () => Modular.to.navigate('profile'),
      color: Colors.white,
      padding: EdgeInsets.all(16),
      icon: Icon(
        Icons.person,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Theme.of(context).primaryColor,
      child: IconTheme(
        data: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: buttons,
        ),
      ),
    );
  }
}
