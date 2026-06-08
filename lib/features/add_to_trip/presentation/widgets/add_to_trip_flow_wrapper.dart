import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/add_to_trip_sheet.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/create_trip_planner_sheet.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/manage_place_sheet.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/select_day_sheet.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

class AddToTripFlowWrapper extends StatefulWidget {
  const AddToTripFlowWrapper({super.key});

  @override
  State<AddToTripFlowWrapper> createState() => _AddToTripFlowWrapperState();
}

class _AddToTripFlowWrapperState extends State<AddToTripFlowWrapper> {
  static const _manageRoute = '/manage';
  static const _selectTripRoute = '/select-trip';
  static const _selectDayRoute = '/select-day';
  static const _createTripRoute = '/create-trip';

  final _navigatorKey = GlobalKey<NavigatorState>();
  late final String _initialRoute;
  bool _canPopInternal = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<AddToTripCubit>();
    final startsInManage = cubit.state.hostTripId != null;
    _initialRoute = startsInManage ? _manageRoute : _selectTripRoute;
    cubit.clearSelection();
    if (!startsInManage) {
      cubit.loadTrips();
    }
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

  void _pushSelectTrip() {
    context.read<AddToTripCubit>().clearSelection();
    context.read<AddToTripCubit>().loadTrips();
    _push(_selectTripRoute);
  }

  Future<void> _selectTrip(Trip trip) async {
    final didLoad = await context.read<AddToTripCubit>().selectTrip(trip);
    if (mounted && didLoad) _push(_selectDayRoute);
  }

  Future<void> _pushHostTripDays() async {
    final didLoad = await context
        .read<AddToTripCubit>()
        .loadHostTripItinerary();
    if (mounted && didLoad) _push(_selectDayRoute);
  }

  void _closeFlow() {
    Navigator.of(context).pop();
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
          left: 30.w,
          right: 30.w,
          top: 29.h,
          bottom: 24.h,
        ),
        decoration: BoxDecoration(
          color: context.colorTheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Navigator(
          key: _navigatorKey,
          initialRoute: _initialRoute,
          observers: [_SheetNavigatorObserver(_scheduleRefreshCanPop)],
          onGenerateRoute: (settings) {
            return PageRouteBuilder<void>(
              settings: settings,
              pageBuilder: (_, animation, _) {
                final child = switch (settings.name) {
                  _manageRoute => ManagePlaceSheet(
                    onMoveToDay: _pushHostTripDays,
                    onMoveToTrip: _pushSelectTrip,
                    onClose: _closeFlow,
                  ),
                  _selectDayRoute => SelectDaySheet(
                    onBack: _popInternal,
                    onClose: _closeFlow,
                  ),
                  _createTripRoute => CreateTripPlannerSheet(
                    onBack: _popInternal,
                    onClose: _closeFlow,
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

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onStackChanged();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    onStackChanged();
  }
}
