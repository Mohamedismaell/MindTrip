// import 'package:mindtrip/core/helper/size_provider/sized_helper_extension.dart';
// import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../theme/cubit/theme_cubit.dart';

// class ThemeIcon extends StatelessWidget {
//   const ThemeIcon({super.key, this.top, this.right});
//   final double? top;
//   final double? right;
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeCubit, ThemeState>(
//       builder: (context, state) {
//         return Positioned(
//           top: top ?? MediaQuery.sizeOf(context).height * 0.05,
//           right: right ?? MediaQuery.sizeOf(context).width * 0.05,
//           child: Container(
//             width: context.setMinSize(70),
//             height: context.setMinSize(35),

//             color: Colors.transparent,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               // crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => context.read<ThemeCubit>().toggleTheme(),
//                     style: ElevatedButton.styleFrom(
//                       elevation: 10,
//                       backgroundColor: context.colorTheme.surface.withOpacity(
//                         0.7,
//                       ),
//                       // backgroundColor: Colors.transparent,
//                       padding: EdgeInsets.all(6),
//                     ),
//                     child: AnimatedAlign(
//                       duration: Duration(milliseconds: 300),
//                       alignment: state.isDark
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Icon(
//                         state.isDark
//                             ? Icons.light_mode_outlined
//                             : Icons.dark_mode_outlined,
//                         color: context.colorTheme.onSurface,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
