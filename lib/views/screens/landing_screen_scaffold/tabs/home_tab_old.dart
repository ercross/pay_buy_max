// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../../../models/coin.dart';
// import '../../../../style_sheet.dart';
// import '../../../widgets/custom_text_field.dart';

// class HomeTabOld extends StatelessWidget {
//   const HomeTabOld();

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (_, constraints) {
//       final double renderWidth = constraints.maxWidth * 0.95;
//       return Center(
//         child: SizedBox(
//           width: renderWidth,
//           height: constraints.maxHeight,
//           child: Column(
//             children: [
//               SizedBox(
//                 height: constraints.maxHeight * 0.04,
//               ),
//               Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Text("Trending", style: StyleSheet.black14w500)),
//               SizedBox(
//                 height: constraints.maxHeight * 0.02,
//               ),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.asset("assets/images/trending2.jpeg",
//                     fit: BoxFit.fill,
//                     height: constraints.maxHeight * 0.3,
//                     width: renderWidth),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               _ProgressIndicators(constraints.maxWidth),
//               SizedBox(height: constraints.maxHeight * 0.04),
//               _ActionButtons(
//                 renderHeight: constraints.maxHeight * 0.08,
//                 renderWidth: constraints.maxWidth,
//               ),
//               _Calculator(
//                   boxHeight: constraints.maxHeight * 0.08,
//                   pageWidth: constraints.maxWidth),
//               SizedBox(height: constraints.maxHeight * 0.04),
//               Text("Top Coins", style: StyleSheet.black13w400),
//               Expanded(
//                 child: _TopCoins(
//                     renderHeight: constraints.maxHeight * 0.15,
//                     pageWidth: constraints.maxWidth),
//               )
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }

// class _TopCoins extends StatelessWidget {
//   final double renderHeight;
//   final double pageWidth;
//   const _TopCoins({required this.renderHeight, required this.pageWidth});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       scrollDirection: Axis.horizontal,
//       children: [
//         _TopCoin(
//             coin: Coin(
//                 name: "BTC",
//                 nairaAmount: "NGN21.93 million",
//                 dollarAmount: "\$43,000"),
//             height: renderHeight,
//             width: pageWidth * 0.4),
//         _TopCoin(
//             coin: Coin(
//                 name: "Ethereum",
//                 nairaAmount: "NGN1.52 million",
//                 dollarAmount: "\$3000"),
//             height: renderHeight,
//             width: pageWidth * 0.4),
//         _TopCoin(
//             coin: Coin(
//                 name: "BNB", nairaAmount: "NGN157.2k", dollarAmount: "\$300"),
//             height: renderHeight,
//             width: pageWidth * 0.4),
//       ],
//     );
//   }
// }

// class _TopCoin extends StatelessWidget {
//   final double height;
//   final double width;
//   final Coin coin;
//   const _TopCoin(
//       {required this.coin, required this.height, required this.width});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: height,
//         width: width,
//         margin:
//             EdgeInsets.only(top: height * 0.13, bottom: 8, right: width * 0.09),
//         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//         decoration: BoxDecoration(
//             color: StyleSheet.background,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: kElevationToShadow[2]),
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text("1 " + coin.name,
//                 textAlign: TextAlign.center, style: StyleSheet.gold15w600),
//             Text(coin.dollarAmount,
//                 textAlign: TextAlign.center, style: StyleSheet.black13w400),
//             Text(coin.nairaAmount,
//                 textAlign: TextAlign.center, style: StyleSheet.black13w400),
//           ],
//         ));
//   }
// }

// class _ProgressIndicators extends StatelessWidget {
//   final double pageWidth;
//   const _ProgressIndicators(this.pageWidth);

//   @override
//   Widget build(BuildContext context) {
//     final double width = pageWidth * 0.05;
//     final double height = 3;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _ProgressIndicator(width: width, height: height, isActive: false),
//         _ProgressIndicator(width: width, height: height, isActive: false),
//         _ProgressIndicator(width: width, height: height, isActive: true),
//         _ProgressIndicator(width: width, height: height, isActive: false),
//         _ProgressIndicator(width: width, height: height, isActive: false),
//       ],
//     );
//   }
// }

// class _ProgressIndicator extends StatelessWidget {
//   final double width;
//   final double height;
//   final bool isActive;
//   const _ProgressIndicator(
//       {required this.width, required this.height, required this.isActive});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.symmetric(horizontal: 4),
//         height: height,
//         width: width,
//         color: isActive ? StyleSheet.primaryColor : Colors.grey[500]);
//   }
// }

// class _ActionButtons extends StatelessWidget {
//   final double renderHeight;
//   final double renderWidth;
//   const _ActionButtons({required this.renderHeight, required this.renderWidth});

//   @override
//   Widget build(BuildContext context) {
//     final Widget buyButton = Container(
//       height: renderHeight,
//       width: renderWidth * 0.45,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: Colors.greenAccent,
//           boxShadow: kElevationToShadow[2]),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.developer_board, color: StyleSheet.primaryColor),
//           SizedBox(
//             width: 8,
//           ),
//           Text("Buy",
//               textAlign: TextAlign.center, style: StyleSheet.white14w500)
//         ],
//       ),
//     );

//     final Widget sellButton = Container(
//       height: renderHeight,
//       width: renderWidth * 0.45,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: Colors.redAccent,
//           boxShadow: kElevationToShadow[2]),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.ballot_outlined, color: Colors.white),
//           SizedBox(
//             width: 8,
//           ),
//           Text("Sell",
//               textAlign: TextAlign.center, style: StyleSheet.white14w500)
//         ],
//       ),
//     );

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [buyButton, sellButton],
//     );
//   }
// }

// class _Calculator extends StatelessWidget {
//   final double boxHeight;
//   final double pageWidth;
//   const _Calculator({required this.boxHeight, required this.pageWidth});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: pageWidth,
//         alignment: Alignment.center,
//         padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.05),
//         child: Column(
//           children: [
//             SizedBox(
//               height: boxHeight * 0.4,
//             ),
//             _FirstRow(boxHeight: boxHeight, pageWidth: pageWidth * 0.9),
//             SizedBox(
//               height: boxHeight * 0.1,
//             ),
//             _SecondRow(boxHeight: boxHeight, pageWidth: pageWidth * 0.9)
//           ],
//         ));
//   }
// }

// class _FirstRow extends StatelessWidget {
//   final double boxHeight;
//   final double pageWidth;
//   const _FirstRow({required this.boxHeight, required this.pageWidth});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         CustomTextField(renderHeight: boxHeight, renderWidth: pageWidth * 0.55),
//         Container(
//           alignment: Alignment.bottomCenter,
//           height: boxHeight,
//           width: pageWidth * 0.35,
//           decoration: BoxDecoration(
//               color: Colors.transparent,
//               border: Border(bottom: BorderSide(color: Colors.grey, width: 2))),
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Text("Select Asset",
//                 textAlign: TextAlign.center, style: StyleSheet.grey13w300),
//             Icon(
//               Icons.keyboard_arrow_down_rounded,
//               color: Colors.grey,
//             )
//           ]),
//         )
//       ],
//     );
//   }
// }

// class _SecondRow extends StatelessWidget {
//   final double boxHeight;
//   final double pageWidth;
//   const _SecondRow({required this.boxHeight, required this.pageWidth});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           alignment: Alignment.bottomLeft,
//           height: boxHeight,
//           width: pageWidth * 0.55,
//           decoration: BoxDecoration(
//               color: Colors.transparent,
//               border: Border(bottom: BorderSide(color: Colors.grey, width: 2))),
//           child: Text("Equivalent cash",
//               textAlign: TextAlign.center, style: StyleSheet.black13w400),
//         ),
//         Container(
//             alignment: Alignment.bottomCenter,
//             height: boxHeight,
//             width: pageWidth * 0.35,
//             decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 border:
//                     Border(bottom: BorderSide(color: Colors.grey, width: 2))),
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Select Currency",
//                       textAlign: TextAlign.center,
//                       style: StyleSheet.grey13w300),
//                   Icon(
//                     Icons.keyboard_arrow_down_rounded,
//                     color: Colors.grey,
//                   )
//                 ])),
//       ],
//     );
//   }
// }
