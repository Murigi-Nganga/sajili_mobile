import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/utils/attendance_utils.dart' show padZeros;

class CheckinWidget extends StatelessWidget {
  const CheckinWidget({
    super.key,
    required this.lowerTimeBound,
    required this.upperTimeBound,
    required this.buttonText,
    required this.onPressed,
  });

  final DateTime lowerTimeBound;
  final DateTime upperTimeBound;
  final String buttonText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    final isInPeriod =
        now.isAfter(lowerTimeBound) && now.isBefore(upperTimeBound);

    return Column(children: [
      const Text('Button can be tapped between'),
      Text(
          '${padZeros(lowerTimeBound.hour)}:${padZeros(lowerTimeBound.minute)} - '
          '${padZeros(upperTimeBound.hour)}:${padZeros(upperTimeBound.minute)} hrs'),
      const SizedBox(height: 10),
      SizedBox(
        width: Get.mediaQuery.size.width * .8,
        child: ElevatedButton(
                onPressed: isInPeriod ? () async => await onPressed() : null,
                child: Text(buttonText),
              ),
      ),
    ]);
  }
}
