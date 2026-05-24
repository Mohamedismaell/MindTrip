import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

class EditableInfo extends StatelessWidget {
  const EditableInfo({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.isPhone = false,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? hintText;
  final bool isPhone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //! Label
        Text(
          label,
          style: context.textTheme.labelLarge?.copyWith(
            color: context.colorTheme.onSurface,
          ),
        ),

        SizedBox(height: 8.h),

        //! Input Container
        Container(
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: context.colorTheme.outline.withValues(alpha: 0.25),
            ),
          ),

          child: isPhone
              ? CountryPicker(controller: controller, hintText: hintText)
              : TextField(
                  controller: controller,

                  keyboardType: keyboardType,

                  textAlign: TextAlign.left,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  style: AppTextStyles.h9Medium.copyWith(
                    color: context.colorTheme.onSurface,
                  ),

                  decoration: InputDecoration(
                    hintText: hintText,

                    hintStyle: AppTextStyles.h9Regular.copyWith(
                      color: context.colorTheme.onSurfaceVariant,
                    ),

                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,

                    isDense: true,

                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class CountryPicker extends StatefulWidget {
  const CountryPicker({
    super.key,
    this.initialIsoCode = 'EG',
    this.controller,
    this.hintText,
    this.enabled = true,
    this.onChanged,
    this.validator,
  });

  final String initialIsoCode;

  final TextEditingController? controller;

  final String? hintText;

  final bool enabled;

  final ValueChanged<PhoneNumber>? onChanged;

  final String? Function(String?)? validator;

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  late PhoneNumber initialPhoneNumber;
  bool isValidNumber = false;

  @override
  void initState() {
    super.initState();
    initialPhoneNumber = PhoneNumber(isoCode: widget.initialIsoCode);
  }

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      isEnabled: widget.enabled,
      initialValue: initialPhoneNumber, // Use fixed initial value
      textFieldController: widget.controller,
      formatInput:
          false, // Set to false to prevent parse crashes when invalid characters are typed
      ignoreBlank: true, // IMPORTANT: Avoids crash when parsing empty strings
      autoValidateMode: AutovalidateMode.onUserInteraction,

      keyboardType: const TextInputType.numberWithOptions(
        signed: false,
        decimal: false,
      ),
      onInputValidated: (bool value) {
        if (mounted) {
          setState(() {
            isValidNumber = value;
          });
        }
      },
      //! SELECTOR
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,
        useEmoji: false,
        showFlags: true,
        trailingSpace: false,
        setSelectorButtonAsPrefixIcon: true,
      ),
      spaceBetweenSelectorAndTextField: 0,

      //! COUNTRY CODE TEXT
      selectorTextStyle: AppTextStyles.h9Medium.copyWith(
        color: context.colorTheme.onSurface,
      ),

      //! PHONE TEXT
      textStyle: AppTextStyles.h9Medium.copyWith(
        color: context.colorTheme.onSurface,
      ),
      cursorColor: context.colorTheme.primary,
      //! INPUT DECORATION
      inputDecoration: InputDecoration(
        hintText: widget.hintText ?? 'Phone number',

        hintStyle: AppTextStyles.h9Regular.copyWith(
          color: context.colorTheme.onSurfaceVariant,
        ),

        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,

        isDense: true,

        //! PICKER WIDTH
        prefix: Container(
          width: 1,
          height: 24.h,
          color: context.colorTheme.outline.withValues(alpha: 0.25),
        ),
        //! TEXT FIELD PADDING
        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
      ),

      //! PHONE CHANGED
      onInputChanged: (phoneNumber) {
        try {
          // DO NOT update initialPhoneNumber here, it causes the widget to re-initialize and crash
          widget.onChanged?.call(phoneNumber);
        } catch (_) {}
      },

      //! VALIDATION
      validator:
          widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Phone number required';
            }

            if (!isValidNumber) {
              return 'Invalid phone number';
            }

            return null;
          },
    );
  }
}
