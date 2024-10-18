import 'package:flutter/material.dart';

import '../../src/app_colors.dart';

class DayPicker extends StatefulWidget {
  const DayPicker({
    super.key,
  });

  @override
  State<DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 2.5),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          DayBall(
            hint: 'Saturday',
            onTap: () => onSelect('Saturday', context, setState),
            isSelected: isSelected('Saturday'),
          ),
          DayBall(
            hint: 'Sunday',
            onTap: () => onSelect('Sunday', context, setState),
            isSelected: isSelected('Sunday'),
          ),
          DayBall(
            hint: 'Monday',
            onTap: () => onSelect('Monday', context, setState),
            isSelected: isSelected('Monday'),
          ),
          DayBall(
            hint: 'Tuesday',
            onTap: () => onSelect('Tuesday', context, setState),
            isSelected: isSelected('Tuesday'),
          ),
          DayBall(
            hint: 'Wednesday',
            onTap: () => onSelect('Wednesday', context, setState),
            isSelected: isSelected('Wednesday'),
          ),
          DayBall(
            hint: 'Thursday',
            onTap: () => onSelect('Thursday', context, setState),
            isSelected: isSelected('Thursday'),
          ),
          DayBall(
            hint: 'Friday',
            onTap: () => onSelect('Friday', context, setState),
            isSelected: isSelected('Friday'),
          ),
        ],
      ),
    );
  }
}

List<String> selectedDays = [];
List<String> selectedHours = [];
isSelected(weekDay) {
  bool isSelected = false;
  for (var day in selectedDays) {
    if (day == weekDay) {
      isSelected = true;
    }
  }
  return isSelected;
}

onSelect(weekDay, context, setState) async {
  if (isSelected(weekDay)) {
    int timeIndex = selectedDays.indexWhere((e) => e == weekDay);
    selectedDays.removeAt(timeIndex);
    selectedHours.removeAt(timeIndex);
  } else {
    TimeOfDay? selectedTime;
    selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selectedTime != null) {
      selectedDays.add(weekDay);
      selectedHours.add('${selectedTime.hour}:${selectedTime.minute}');
    }
  }

  setState(() {});
}

class DayBall extends StatelessWidget {
  const DayBall(
      {super.key,
      required this.isSelected,
      required this.hint,
      required this.onTap});
  final String hint;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawMaterialButton(
        fillColor: isSelected ? AppColors.primary : null,
        shape: const CircleBorder(
            side: BorderSide(
          color: Colors.white,
          width: 2,
        )),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            hint.replaceRange(3, hint.length, ''),
            style: TextStyle(
              fontSize: MediaQuery.sizeOf(context).width * 0.035,
              fontWeight: FontWeight.bold,
              color: isSelected ? AppColors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
