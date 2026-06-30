import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/add_to_trip_sheet.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/create_trip_planner_sheet.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/select_day_sheet.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

class AddToTripFlowWrapper extends StatefulWidget {
  const AddToTripFlowWrapper({super.key});

  @override
  State<AddToTripFlowWrapper> createState() => _AddToTripFlowWrapperState();
}

class _AddToTripFlowWrapperState extends State<AddToTripFlowWrapper> {
  static const _selectTripRoute = '/select-trip';
  static const _createTripRoute = '/create-trip';
  static const _selectDayRoute = '/select-day';

  final _navigatorKey = GlobalKey<NavigatorState>();
  bool _canPopInternal = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddToTripCubit>().loadTrips();
    });
  }

  void _refreshCanPop() {
    final nextCanPop = _navigatorKey.currentState?.canPop() ?? false;
    if (_canPopInternal != nextCanPop && mounted) {
      setState(() => _canPopInternal = nextCanPop);
    }
  }

  void _scheduleRefreshCanPop() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshCanPop());
  }

  void _popInternal() {
    final navigator = _navigatorKey.currentState;
    if (navigator?.canPop() ?? false) {
      navigator!.pop();
      _scheduleRefreshCanPop();
      return;
    }
    Navigator.of(context).maybePop();
  }

  void _push(String routeName) {
    _navigatorKey.currentState?.pushNamed(routeName);
    _scheduleRefreshCanPop();
  }

  Future<void> _selectTrip(Trip trip) async {
    context.read<AddToTripCubit>().selectTrip(trip);
    _push(_selectDayRoute);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_canPopInternal,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _popInternal();
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 29.h,
          bottom: 24.h,
        ),
        decoration: BoxDecoration(
          color: context.colorTheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        ),
        child: Navigator(
          key: _navigatorKey,
          initialRoute: _selectTripRoute,
          observers: [_SheetNavigatorObserver(_scheduleRefreshCanPop)],
          onGenerateRoute: (settings) {
            return PageRouteBuilder<void>(
              settings: settings,
              pageBuilder: (_, animation, _) {
                final child = switch (settings.name) {
                  _createTripRoute => CreateTripPlannerSheet(
                      onBack: _popInternal,
                      onClose: () => Navigator.of(context).pop(),
                    ),
                  _selectDayRoute => SelectDaySheet(
                      onBack: _popInternal,
                      onClose: () => Navigator.of(context).pop(),
                    ),
                  _ => AddToTripSheet(
                      onBack: _popInternal,
                      onCreateNew: () => _push(_createTripRoute),
                      onTripSelected: _selectTrip,
                    ),
                };
                return child;
              },
              transitionsBuilder: (_, animation, _, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 180),
              reverseTransitionDuration: const Duration(milliseconds: 140),
            );
          },
        ),
      ),
    );
  }
}

class _SheetNavigatorObserver extends NavigatorObserver {
  _SheetNavigatorObserver(this.onStackChanged);

  final VoidCallback onStackChanged;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onStackChanged();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onStackChanged();
  }
}
