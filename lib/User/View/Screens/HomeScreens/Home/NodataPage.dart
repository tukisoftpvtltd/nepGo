import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

import '../../../../Controller/bloc/map/bloc/map_bloc.dart';
import '../../../constants/colors.dart';
import 'Location/MapPage.dart';

class NoDataPage extends StatelessWidget {
  const NoDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(
              height: 150,
            ),
            Opacity(
              opacity: 0.4,
              child: Container(
                  width: screenWidth * 0.4,
                  child: Image.asset(
                    'assets/images/error.png',
                  )),
            ),
            const Text(
              "The Resturants are too far ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Your current location are out of service. Lets try from a different location",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: screenWidth * 0.8,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(BlocProvider(
                    create: (context) => MapBloc(),
                    child: MapPage(),
                  ));
                },
                child: Text("Change Location"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colours.primarygreen),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
