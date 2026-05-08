import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_search_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_search_state.dart';

class MapSearchOverlay extends StatefulWidget {
  const MapSearchOverlay({super.key});

  @override
  State<MapSearchOverlay> createState() => _MapSearchOverlayState();
}

class _MapSearchOverlayState extends State<MapSearchOverlay> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    context.read<MapSearchCubit>().search(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  //Todo Edit ui later
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: context.colorTheme.onSurface,
                    ),
                    onTap: () {
                      context.read<MapSearchCubit>().clearSearch();
                      context.pop();
                    },
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Looking for a place...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: context.colorTheme.surfaceContainerHighest
                            .withValues(alpha: 0.5),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: context.colorTheme.outline,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: context.colorTheme.outline,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  context.read<MapSearchCubit>().clearSearch();
                                },
                              )
                            : null,
                      ),
                      style: context.textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),

            // Search Results
            Expanded(
              child: BlocBuilder<MapSearchCubit, MapSearchState>(
                buildWhen: (previous, current) =>
                    previous.autocompletePredictions !=
                        current.autocompletePredictions ||
                    previous.isSearchLoading != current.isSearchLoading ||
                    previous.searchError != current.searchError,
                builder: (context, state) {
                  if (state.isSearchLoading &&
                      state.autocompletePredictions.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.searchError != null) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Text(
                          state.searchError!,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorTheme.error,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  if (state.autocompletePredictions.isEmpty &&
                      _searchController.text.isNotEmpty &&
                      !state.isSearchLoading) {
                    return Center(
                      child: Text(
                        'No places found.',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorTheme.outline,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.autocompletePredictions.length,
                    itemBuilder: (context, index) {
                      final suggestion = state.autocompletePredictions[index];
                      return ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: context.colorTheme.primaryContainer
                                .withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: context.colorTheme.primary,
                          ),
                        ),
                        title: Text(
                          suggestion.primaryText,
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: suggestion.secondaryText.isNotEmpty
                            ? Text(
                                suggestion.secondaryText,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorTheme.outline,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : null,
                        onTap: () async {
                          final cubit = context.read<MapSearchCubit>();
                          final place = await cubit.resolveAutocompleteResult(
                            suggestion.placeId,
                          );

                          if (place != null && context.mounted) {
                            context.pop(); // close overlay
                          } else if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Failed to retrieve place details',
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
