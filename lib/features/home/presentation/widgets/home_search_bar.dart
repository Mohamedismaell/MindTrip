// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mindtrip/core/utils/extension.dart';
// import 'package:mindtrip/core/shared/routes/app_routes.dart';

// class HomeSearchBar extends StatelessWidget {
//   const HomeSearchBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: GestureDetector(
//         onTap: () => Navigator.pushNamed(context, AppRoutes.globalSearch),
//         child: Row(
//           children: [
//             Expanded(
//               child: Hero(
//                 tag: 'home_search_bar_hero',
//                 child: Material(
//                   color: Colors.transparent,
//                   child: Container(
//                     height: 46.h,
//                     padding: EdgeInsets.symmetric(horizontal: 14.w),
//                     decoration: BoxDecoration(
//                       color: context.colorTheme.surface,
//                       borderRadius: BorderRadius.circular(30.r),
//                       border: Border.all(
//                         color:
//                             context.colorTheme.outline.withValues(alpha: 0.55),
//                         width: 0.8,
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.search_rounded,
//                           size: 20.sp,
//                           color: context.colorTheme.outline,
//                         ),
//                         10.horizontalSpace,
//                         Text(
//                           'Destinations, trips, activities...',
//                           style: context.textTheme.bodyMedium?.copyWith(
//                             color: context.colorTheme.outline
//                                 .withValues(alpha: 0.6),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
