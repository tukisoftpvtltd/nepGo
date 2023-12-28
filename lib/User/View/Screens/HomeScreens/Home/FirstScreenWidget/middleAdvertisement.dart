import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../../../Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../Controller/bloc/Home/location/bloc/location_bloc.dart';
import '../../../../../Controller/bloc/Home/service_provider_detail/bloc/service_provider_detail_bloc.dart';
import '../Restaurants/screens/view_restaurant.dart';

class MiddleAdvertisement extends StatefulWidget {
  var advertdata;
  int index;
   MiddleAdvertisement({super.key,
  required this.advertdata,
  required this.index});

  @override
  State<MiddleAdvertisement> createState() => _MiddleAdvertisementState();
}

class _MiddleAdvertisementState extends State<MiddleAdvertisement> {
  var stateData;

  initState(){
    stateData = widget.advertdata;
    loadingFirstTime =true;
  }

   bool? loadingFirstTime ;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(loadingFirstTime);
    return Container(
      height: 200,
      color: Colors.blueGrey,
      width: width,
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if(widget.advertdata.toString() =="[]"){
          if(loadingFirstTime == true){
          if(state is HomePageLoaded){
            if(widget.index == 1){
             stateData = state.advertisement;
            }
            else if(widget.index == 2){
             stateData = state.middleAdvertisement;
            }
            else if(widget.index == 3){
             stateData = state.bottomAdvertisement;
            }
             loadingFirstTime = false;
          return 
          GestureDetector(
            onTap: (){
              print("Hello");
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //   builder:
              //   (context) =>
              //        BlocProvider(
              //           create: (context) =>
              //           ServiceProviderDetailBloc(),
              //           child:
              //           BlocProvider(
              //             create: (context) =>
              //             LocationBloc(),
              //             child:
              //             ViewRestautant(
              //             callback:(){},
              //             sid: 'rDxw7RAldyAjsyHD4pMt202306376665',
              //             ),
              //             ),
              //             )));
            },
            child: 
            Image.network("https://meroato.tukisoft.com.np/advertisment/" +
                                  
                                    state.middleAdvertisement.adSlider![0].adBanner
                                        .toString(),
                                        fit: BoxFit.cover,
                            )
            // CarouselSlider.builder(
            //     itemCount: 1,
            //     options: CarouselOptions(
            //         // height: 0.16*height,
            //         autoPlay: false,
            //         viewportFraction: 1,
            //         onPageChanged: (index, reason) {}),
            //     itemBuilder: (context, index, realIndex) {
            //       // final blockColor = Colors.grey;
            //               return Container(
            //                 color: Colors.white,
            //                 child: Image.network(
            //                    "https://meroato.tukisoft.com.np/advertisment/" +
            //                         state.advertisement.adSlider![0].adBanner
            //                             .toString(),
            //                             fit: BoxFit.cover,
            //                 ),
            //               );
            //             }
            // ),
          );
        }
        else{
           return 
           
            CarouselSlider.builder(
              itemCount: 1,
              options: CarouselOptions(
                  // height: 0.16*height,
                  autoPlay: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {}),
              itemBuilder: (context, index, realIndex) {
                // final blockColor = Colors.grey;
                        return Container(
                          width: width,
                          color: Colors.blueGrey,
                          child: Center(child: CircularProgressIndicator())

                        );
                      }
          );
        }
          }
        else{
          return 
          Image.network(
                               "https://meroato.tukisoft.com.np/advertisment/" +
                                    stateData.adSlider![0].adBanner.toString(),
                                        fit: BoxFit.cover,
                            );
          
          // CarouselSlider.builder(
          //     itemCount: 1,
          //     options: CarouselOptions(
          //         // height: 0.16*height,
          //         autoPlay: false,
          //         viewportFraction: 1,
          //         onPageChanged: (index, reason) {}),
          //     itemBuilder: (context, index, realIndex) {
          //       // final blockColor = Colors.grey;
          //               return Container(
          //                  color: Colors.white,
          //                 child: FadeInImage.memoryNetwork(
          //         placeholder: kTransparentImage, // Placeholder using KTransparentImage
          //         image:  "https://meroato.tukisoft.com.np/advertisment/" +
          //                         stateData.adSlider![0].adBanner
          //                             .toString(),
          //         fit: BoxFit.cover,
          //       )
          //               );
          //             }
          // );
        }
          }
          else{
            return  Image.network(
                               "https://meroato.tukisoft.com.np/advertisment/" +
                                  widget.advertdata.adSlider[0].adBanner
                                      .toString(),
                                        fit: BoxFit.cover,
                            );
          //    CarouselSlider.builder(
          //     itemCount: 1,
          //     options: CarouselOptions(
          //         // height: 0.16*height,
          //         autoPlay: true,
          //         viewportFraction: 1,
          //         onPageChanged: (index, reason) {}),
          //     itemBuilder: (context, index, realIndex) {
          //       // final blockColor = Colors.grey;
          //               return Container(
          //                  color: Colors.black,
          //                 width:width,
          //                 child: FadeInImage(
          //                   placeholder: MemoryImage(kTransparentImage),
          //                   image: NetworkImage(
          //                     "https://meroato.tukisoft.com.np/advertisment/" +
          //                         widget.advertdata.adSlider[0].adBanner
          //                             .toString(),
          //                   ),
          //                   fit: BoxFit.cover,
          //                   fadeInDuration: Duration(milliseconds: 100), 
          //                 ),
          //               );
          //             }
          // );
          }}
        
      ),
    );
  }
}
