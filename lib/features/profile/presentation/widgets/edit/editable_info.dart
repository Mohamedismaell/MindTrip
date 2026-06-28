import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/profile/presentation/manager/edit_profile_cubit.dart';
import 'package:mindtrip/features/profile/presentation/manager/edit_profile_state.dart';

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
        Text(
          label,
          style: context.textTheme.labelLarge?.copyWith(
            color: context.colorTheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: context.colorTheme.outline.withValues(alpha: 0.25),
            ),
          ),
          child: isPhone
              ? CountryPhoneField(controller: controller, hintText: hintText)
              : TextFormField(
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

class CountryPhoneField extends StatelessWidget {
  const CountryPhoneField({
    super.key,
    required this.controller,
    this.hintText,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String? hintText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      buildWhen: (previous, current) =>
          previous.draftPhoneCountryCode != current.draftPhoneCountryCode ||
          previous.draftPhoneDialCode != current.draftPhoneDialCode,
      builder: (context, state) {
        final selectedCountry =
            Country.tryParse(state.draftPhoneCountryCode) ??
            Country.parse('EG');

        return Row(
          children: [
            InkWell(
              onTap: enabled
                  ? () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        favorite: const ['EG', 'SA', 'AE', 'US', 'GB'],
                        moveAlongWithKeyboard: true,
                        countryListTheme: CountryListThemeData(
                          backgroundColor: context.colorTheme.surface,
                          textStyle: AppTextStyles.h9Medium.copyWith(
                            color: context.colorTheme.onSurface,
                          ),
                          searchTextStyle: AppTextStyles.h9Medium.copyWith(
                            color: context.colorTheme.onSurface,
                          ),
                          flagSize: 22,
                          bottomSheetHeight: 0.72.sh,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24.r),
                          ),
                          padding: EdgeInsets.all(16.w),
                          inputDecoration: InputDecoration(
                            hintText: 'Search country',
                            hintStyle: AppTextStyles.h9Regular.copyWith(
                              color: context.colorTheme.onSurfaceVariant,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: context.colorTheme.onSurfaceVariant,
                            ),
                            filled: true,
                            fillColor: context.colorTheme.surface,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.r),
                              borderSide: BorderSide(
                                color: context.colorTheme.outline.withValues(
                                  alpha: 0.25,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.r),
                              borderSide: BorderSide(
                                color: context.colorTheme.outline.withValues(
                                  alpha: 0.25,
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.r),
                              borderSide: BorderSide(
                                color: context.colorTheme.primary,
                              ),
                            ),
                          ),
                        ),
                        onSelect: (Country country) {
                          context.read<EditProfileCubit>().updatePhoneCountry(
                            countryCode: country.countryCode,
                            dialCode: country.phoneCode,
                          );
                        },
                      );
                    }
                  : null,
              borderRadius: BorderRadius.circular(12.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedCountry.flagEmoji,
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '+${state.draftPhoneDialCode}',
                      style: AppTextStyles.h9Medium.copyWith(
                        color: context.colorTheme.onSurface,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: context.colorTheme.onSurfaceVariant,
                      size: 20.sp,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 1,
              height: 24.h,
              color: context.colorTheme.outline.withValues(alpha: 0.25),
            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                enabled: enabled,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.left,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\s()-]')),
                ],
                style: AppTextStyles.h9Medium.copyWith(
                  color: context.colorTheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: hintText ?? 'Phone number',
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
                    horizontal: 12.w,
                    vertical: 14.h,
                  ),
                ),
                validator: (value) {
                  final normalized = (value ?? '').replaceAll(
                    RegExp(r'[^0-9]'),
                    '',
                  );

                  if (normalized.isEmpty) {
                    return 'Phone number required';
                  }

                  if (normalized.length < 8) {
                    return 'Invalid phone number';
                  }

                  return null;
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
