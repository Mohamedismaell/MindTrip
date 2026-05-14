import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';

Future<void> showRenameTripDialog(
  BuildContext context, {
  required String tripId,
  required String currentTitle,
}) {
  return showDialog(
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<TripsCubit>(),
      child: _RenameTripDialog(tripId: tripId, currentTitle: currentTitle),
    ),
  );
}

class _RenameTripDialog extends StatefulWidget {
  const _RenameTripDialog({
    required this.tripId,
    required this.currentTitle,
  });

  final String tripId;
  final String currentTitle;

  @override
  State<_RenameTripDialog> createState() => _RenameTripDialogState();
}

class _RenameTripDialogState extends State<_RenameTripDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentTitle);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _confirm() {
    final newTitle = _controller.text.trim();
    if (newTitle.isEmpty) return;
    context.read<TripsCubit>().updateTripTitle(widget.tripId, newTitle);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colorTheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      title: Text(
        'Rename Trip',
        style: AppTextStyles.h7Bold.copyWith(color: context.colorTheme.onSurface),
      ),
      content: TextField(
        controller: _controller,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        style: AppTextStyles.h9Regular.copyWith(
          color: context.colorTheme.onSurface,
        ),
        decoration: InputDecoration(
          hintText: 'Enter trip name',
          hintStyle: AppTextStyles.h9Regular.copyWith(
            color: context.colorTheme.outline,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: context.colorTheme.primary, width: 1.5),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        ),
        onSubmitted: (_) => _confirm(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: AppTextStyles.h9Medium.copyWith(
              color: context.colorTheme.outline,
            ),
          ),
        ),
        TextButton(
          onPressed: _confirm,
          child: Text(
            'Save',
            style: AppTextStyles.h9Medium.copyWith(
              color: context.colorTheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
