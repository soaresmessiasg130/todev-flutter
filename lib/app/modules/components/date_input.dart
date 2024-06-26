import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_dev/app/utils/date.dart';

class DateInput extends StatefulWidget {
  final String restorationId;
  final Function(DateTime) onChange;

  const DateInput(
      {Key? key, required this.restorationId, required this.onChange})
      : super(key: key);

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> with RestorationMixin {
  late final RestorableDateTime _selectedDate = RestorableDateTime(getUtcNow());

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _onSelectDate,
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
          firstDate: DateTime(getUtcNow().year - 10),
          lastDate: DateTime(getUtcNow().year + 10),
        );
      },
    );
  }

  void _onSelectDate(DateTime? value) {
    if (value != null) {
      setState(() {
        final newSelectedDateValue =
            DateTime(value.year, value.month, value.day);

        _selectedDate.value = newSelectedDateValue;

        widget.onChange(value);
      });
    }
  }

  void _onOpenPicker() {
    _restorableDatePickerRouteFuture.present();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _onOpenPicker,
      child: Text(
        DateFormat.yMMMd().format(_selectedDate.value),
      ),
    );
  }
}
