import 'package:flutter/material.dart';

import '../../src/app_colors.dart';

class DurationPicker extends StatefulWidget {
  const DurationPicker({
    super.key,
  });

  @override
  State<DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 2.5),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          DayBall(
            hint: '15',
            onTap: () => onDurationSelect('15', context, setState),
            isSelected: isDurationSelected('15'),
          ),
          DayBall(
            hint: '30',
            onTap: () => onDurationSelect('30', context, setState),
            isSelected: isDurationSelected('30'),
          ),
          DayBall(
            hint: '45',
            onTap: () => onDurationSelect('45', context, setState),
            isSelected: isDurationSelected('45'),
          ),
          DayBall(
            hint: '60',
            onTap: () => onDurationSelect('60', context, setState),
            isSelected: isDurationSelected('60'),
          ),
        ],
      ),
    );
  }
}

String selectedDuration = '';
isDurationSelected(duration) {
  bool isSelected = false;
  if (selectedDuration == duration) {
    isSelected = true;
  }
  return isSelected;
}

onDurationSelect(duration, context, setState) async {
  if (selectedDuration.isNotEmpty) {
    selectedDuration = '';
  } else {
    selectedDuration = duration;
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
            hint,
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
