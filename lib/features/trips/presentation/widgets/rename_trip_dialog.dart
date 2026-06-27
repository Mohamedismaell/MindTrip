import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_cubit.dart';

Future<void> showRenameTripDialog(
  BuildContext context, {
  required String tripId,
  required String currentTitle,
}) {
  final controller = TextEditingController(text: currentTitle);

  void confirm() {
    final newTitle = controller.text.trim();

    if (newTitle.isEmpty) return;

    context.read<TripsCubit>().renameTrip(tripId, newTitle);
  }

  return AppDialog.show(
    context: context,

    providerBuilder: (context, child) {
      return BlocProvider.value(
        value: context.read<TripsCubit>(),
        child: child,
      );
    },

    title: 'Rename Trip',

    primaryText: 'Rename',

    secondaryText: 'Cancel',

    onPrimary: confirm,
    icon: Icons.edit,

    child: _RenameTripDialog(controller: controller, onSubmitted: confirm),
  );
}

class _RenameTripDialog extends StatelessWidget {
  const _RenameTripDialog({
    required this.controller,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      style: context.textTheme.labelLarge?.copyWith(
        color: context.colorTheme.onSurface,
      ),
      decoration: InputDecoration(
        hintText: 'Enter trip name',
        hintStyle: AppTextStyles.h9Regular.copyWith(
          color: context.colorTheme.outline,
        ),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: context.colorTheme.primary, width: 1.5),
        ),

        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      ),

      onSubmitted: (_) => onSubmitted(),
    );
  }
}
