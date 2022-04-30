import 'package:flutter/material.dart';

class DateTimeInput extends StatefulWidget {
  final String restorationId;

  const DateTimeInput({Key? key, required this.restorationId})
      : super(key: key);

  @override
  State<DateTimeInput> createState() => _DateTimeInputState();
}

class _DateTimeInputState extends State<DateTimeInput> with RestorationMixin {
  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime.now().toUtc());

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
      _restorableDatePickerRouteFuture,
      'date_picker_route_future',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlinedButton(
        onPressed: () {
          _restorableDatePickerRouteFuture.present();
        },
        child: const Text('Click to select date'),
      ),
    );
  }

  void _selectDate(DateTime? value) {
    if (value != null) {
      setState(() {
        _selectedDate.value = value;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Selected: ${_selectedDate.value.year}',
            ),
          ),
        );
      });
    }
  }

  static Route<DateTime?> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2022),
          lastDate: DateTime(2023),
        );
      },
    );
  }
}
