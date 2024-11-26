import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';

class PlacesCardWidgetWidget extends StatefulWidget {
  const PlacesCardWidgetWidget({super.key, required this.text});

  final String text;

  @override
  State<PlacesCardWidgetWidget> createState() => _PlacesCardWidgetWIdgetState();
}

class _PlacesCardWidgetWIdgetState extends State<PlacesCardWidgetWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage("assets/images/wolken_card.jpeg"),
                fit: BoxFit.fill,
                opacity: 0.9),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 13, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      widget.text,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          height: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 200,
                    child: widget.text == "Mein Standort"
                        ? const Text(
                            "Cupertino",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                height: 0,
                                fontWeight: FontWeight.w600),
                          )
                        : const Row(
                            children: [
                              SFIcon(
                                SFIcons.sf_clock_arrow_2_circlepath,
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              Text(
                                " N/A",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    height: 0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                  ),
                  const Expanded(child: SizedBox()),
                  const SizedBox(
                    width: 200,
                    child: Text(
                      "N/A",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          height: 0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "N/A°",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                          height: 0,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      "H: N/A° T: N/A°",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_sficon/flutter_sficon.dart';

// class PlacesCardWidgetWIdget extends StatefulWidget {
//   const PlacesCardWidgetWIdget({
//     super.key,
//     required this.text,
//     required this.placeName,
//     required this.time,
//     required this.condition,
//     required this.currentTemp,
//     required this.maxTemp,
//     required this.minTemp,
//   });

//   final String text;
//   final String placeName;
//   final String time;
//   final String condition;
//   final double currentTemp;
//   final double maxTemp;
//   final double minTemp;

//   @override
//   State<PlacesCardWidgetWIdget> createState() => _PlacesCardWidgetWIdgetState();
// }

// class _PlacesCardWidgetWIdgetState extends State<PlacesCardWidgetWIdget> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 10),
//       child: Container(
//         width: double.infinity,
//         height: 100,
//         decoration: BoxDecoration(
//             image: const DecorationImage(
//                 image: AssetImage("assets/images/wolken_card.jpeg"),
//                 fit: BoxFit.fill),
//             borderRadius: BorderRadius.circular(20)),
//         child: Padding(
//           padding:
//               const EdgeInsets.only(top: 10, bottom: 10, left: 13, right: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   SizedBox(
//                     width: 200,
//                     child: Text(
//                       widget.text,
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 15,
//                           height: 0,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   SizedBox(
//                     width: 200,
//                     child: widget.text == "Mein Standort"
//                         ? Text(
//                             widget.placeName,
//                             style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 10,
//                                 height: 0,
//                                 fontWeight: FontWeight.w600),
//                           )
//                         : Row(
//                             children: [
//                               const SFIcon(
//                                 SFIcons.sf_clock_arrow_2_circlepath,
//                                 color: Colors.white,
//                                 fontSize: 10,
//                               ),
//                               Text(
//                                 " ${widget.time}",
//                                 style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 10,
//                                     height: 0,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           ),
//                   ),
//                   const Expanded(child: SizedBox()),
//                   SizedBox(
//                     width: 200,
//                     child: Text(
//                       widget.condition,
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 10,
//                           height: 0,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: 100,
//                     child: Text(
//                       "${widget.currentTemp}°",
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 33,
//                           height: 0,
//                           fontWeight: FontWeight.w300),
//                       textAlign: TextAlign.end,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 100,
//                     child: Text(
//                       "H: ${widget.maxTemp}° T: ${widget.minTemp}°",
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600),
//                       textAlign: TextAlign.end,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
