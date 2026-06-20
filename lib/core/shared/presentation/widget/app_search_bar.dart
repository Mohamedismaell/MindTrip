import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    this.hintText = 'Search...',
    this.controller,
    this.onTap,
    this.onVoiceResult,
    this.onChanged,
    this.onClear,
    this.leadingIcon = Icons.search_rounded,
    this.trailingIcon = Icons.mic_rounded,
    this.showVoiceButton = true,
    this.enabled = true,
    this.heroTag,
    this.autofocus = false,
    this.focusNode,
  });

  final String hintText;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final ValueChanged<String>? onVoiceResult;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final bool showVoiceButton;
  final bool enabled;
  final String? heroTag;
  final bool autofocus;
  final FocusNode? focusNode;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late final TextEditingController _controller;
  bool _internalController = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController();
      _internalController = true;
    } else {
      _controller = widget.controller!;
    }
  }

  @override
  void dispose() {
    if (_internalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isReadOnly = widget.controller == null && widget.onTap != null;

    Widget searchBar = Row(
      children: [
        Expanded(
          child: Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: context.colorTheme.surface,
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                color: context.colorTheme.outline.withValues(alpha: 0.45),
                width: 0.8,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  widget.leadingIcon,
                  size: 20.sp,
                  color: context.colorTheme.outline,
                ),
                10.horizontalSpace,
                Expanded(
                  child: isReadOnly
                      ? Text(
                          widget.hintText,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 13.sp,
                            color: context.colorTheme.outline,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : TextField(
                          controller: _controller,
                          focusNode: widget.focusNode,
                          autofocus: widget.autofocus,
                          onChanged: (val) {
                            widget.onChanged?.call(val);
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: widget.hintText,
                            hintStyle: context.textTheme.bodyMedium?.copyWith(
                              fontSize: 13.sp,
                              color: context.colorTheme.outline,
                            ),
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 13.sp,
                          ),
                        ),
                ),
                if (!isReadOnly)
                  ListenableBuilder(
                    listenable: _controller,
                    builder: (context, _) {
                      if (_controller.text.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: GestureDetector(
                          onTap: () {
                            _controller.clear();
                            widget.onClear?.call();
                            widget.onChanged?.call("");
                            setState(() {});
                          },
                          child: Icon(
                            Icons.close_rounded,
                            size: 20.sp,
                            color: context.colorTheme.outline,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
        if (widget.showVoiceButton)
          ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: _controller.text.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(left: 12.w),
                        child: GestureDetector(
                          onTap: () async {
                            widget.focusNode?.unfocus();
                            final result = await context.push<String>(
                              AppRoutes.voiceSearch,
                            );
                            if (result != null && result.isNotEmpty) {
                              _controller.text = result;
                              _controller
                                  .selection = TextSelection.fromPosition(
                                TextPosition(offset: _controller.text.length),
                              );
                              widget.onChanged?.call(result);
                              widget.onVoiceResult?.call(result);
                              setState(() {});
                            } else if (widget.autofocus) {
                              widget.focusNode?.requestFocus();
                            }
                          },
                          child: Container(
                            width: 50.w,
                            height: 50.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.blueLightGradient,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              widget.trailingIcon,
                              color: AppColors.pureWhite,
                              size: 22.sp,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              );
            },
          ),
      ],
    );

    if (widget.heroTag != null) {
      searchBar = Hero(
        tag: widget.heroTag!,
        child: Material(color: Colors.transparent, child: searchBar),
      );
    }

    if (isReadOnly) {
      return GestureDetector(
        onTap: widget.enabled ? widget.onTap : null,
        child: AbsorbPointer(child: searchBar),
      );
    }

    return searchBar;
  }
}
