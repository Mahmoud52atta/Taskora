import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/presentation/manage/edit_cubit/cubit/edit_cubit.dart';

class TaskDetailsSaveButton extends StatelessWidget {
  const TaskDetailsSaveButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCubit, EditState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              backgroundColor: WidgetStateProperty.all(kPrimaryColor),
            ),
            onPressed: state is EditLoading ? null : onPressed,
            child: state is EditLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Save Changes',
                    style: FontStyles.fontStyleBold16(context).copyWith(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
