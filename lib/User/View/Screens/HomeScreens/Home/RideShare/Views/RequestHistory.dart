import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../Controller/bloc/RideShare/requestHistory/requestModel.dart';
import '../../../../../../Controller/bloc/RideShare/requestHistory/requestRepository.dart';


class RequestHistory extends StatefulWidget {
  RequestHistory({super.key});

  @override
  State<RequestHistory> createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  RequestModel? requestModel;
  getData() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    String? userId = userData.getString('user_id');
    RequestRepository repo = new RequestRepository();
    requestModel = await repo.getrequestData(userId!);
    print(requestModel!.data?.length);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Request History',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
        leading: const BackButton(color: Colors.black),
      ),
      body: loading == true
          ? const Center(child: CupertinoActivityIndicator())
          :  Container(
              height: height - 130,
              child: requestModel!.data != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: requestModel?.data?.length,
                      itemBuilder: (context, index) {
                       String? cancelValue = requestModel?.data![index].cancel.toString();
                       double? meterDistance = requestModel?.data![index].distance;
                       double kilometerDistance = meterDistance!/1000;
                       double roundOffDistance=  double.parse(kilometerDistance.toStringAsFixed(2));
                        return Container(
                          color: Colors.white,
                          width: width,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Text(
                                    "From : ${requestModel?.data![index].pickupLocation}",
                                    // "hi",
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "To : ${requestModel?.data![index].detinationLocation}",
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "Rs. ${requestModel?.data![index].amount}",
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Remarks : ${requestModel?.data![index].remarks}",
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      cancelValue =='0' ?const Text(
                                        "Status : Accepted",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.green,
                                        ),
                                      ) 
                                      : Text(
                                        "Status : Rejecteed",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Distance : ${roundOffDistance} KM ",
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  thickness: 1,
                                )
                              ]),
                        );
                      })
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('No Request History Found')],
                      ),
                    )),
    );
  }
}
