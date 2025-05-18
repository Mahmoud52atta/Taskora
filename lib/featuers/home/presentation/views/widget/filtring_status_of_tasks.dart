import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class AllCategoryTasks extends StatefulWidget {
  const AllCategoryTasks({
    super.key,
  });

  @override
  State<AllCategoryTasks> createState() => _AllCategoryTasksState();
}

List<bool> isSelected = [true, false, false, false];

class _AllCategoryTasksState extends State<AllCategoryTasks> {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderWidth: 8,
      borderRadius: BorderRadius.circular(8),
      disabledColor: kSecondColor,
      isSelected: isSelected,
      // highlightColor: kSecondColor,
      splashColor: kPrimaryColor,
      selectedColor: Colors.white,
      fillColor: kPrimaryColor,
      color: Colors.black,
      borderColor: kSecondColor,
      selectedBorderColor: kPrimaryColor,
      onPressed: (index) {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == index;
          }
        });
      },
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text("All", style: FontStyles.fontStyleBold16(context)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text("Inprogress"),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text("Waiting"),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text("Finished"),
        ),
      ],
    );
  }
}
