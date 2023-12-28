import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Driver/Model/DriverBankDetailModel.dart';
import 'package:get/get.dart';

import '../../../User/View/widgets/button.dart';
import '../../Controller/bloc/Account/sign_up/sign_up_bloc.dart';
import '../../Controller/repository/Bank Details/BankDetails.dart';
import '../components/colors.dart';
String bankName ='';
String branchName='';
class BankDetails extends StatefulWidget {
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  TextEditingController firstNameController = TextEditingController();
  bool? firstNameValid;
  TextEditingController phonenumberController = TextEditingController();
  bool? phoneValid;
  final FocusNode _focusNode = FocusNode();
  bool loading =false;
  bool Pageloading =false;
  
  getBankingDetails()async{
    setState(() {
      Pageloading =true;
    });
    DriverBankRepository repo = DriverBankRepository();
    DriverBankDetailModel model = await repo.GetDriverBankDetails();
    setState(() {
      print("The account name is ${model.bankData?.accountName}");
    firstNameController.text = model.bankData?.accountName??'';
    print("The account name is ${model.bankData?.accountNumber}");
    phonenumberController.text = model.bankData?.accountNumber??'';
    bankName = model.bankData?.bankName??'';
    branchName = model.bankData?.bankBranch??'';
    Pageloading=false;
    });
    
    
  }
  UpdateBankingDetails(){
      setState(() {
      loading =true;
    });
    DriverBankRepository repo = DriverBankRepository();
    if(firstNameController.text =='' && phonenumberController.text ==''&& bankName ==''&&branchName ==''){
       print("post");
       repo.PostDriverBankDetails(firstNameController.text, phonenumberController.text, bankName, branchName);

    }
    else{
       print("put");
    repo.PutDriverBankDetails(firstNameController.text, phonenumberController.text, bankName, branchName);
    }setState(() {
      loading =false;
    });
  }
  
  @override
  void initState() {
    getBankingDetails();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
     double screenWidth = Get.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
          padding: const EdgeInsets.only(left: 9.0),
          child: Container(
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          ),
          elevation: 0,
          title: Text("Banking Details",style: TextStyle(color: Colors.black),),
        ),
      body:Pageloading==true?
      Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ): 
      Padding(
       padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
           BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          Color borderColor = Colours.primarybrown;
                          if (state is SignUpFirstNameValidState) {
                            //firstNameValid = true;
                          }
                          if (state is SignUpFirstNameInValidState) {
                            //firstNameValid = false;
                          }
                          if (firstNameValid == true) {
                            //borderColor = Colours.primarygreen;
                          } else if (firstNameValid == false) {
                           // borderColor = Colors.red;
                          } else {
                            //borderColor = Colours.primarybrown;
                          }
                          return Container(
                            width: Get.width * 0.85,
                            
                            child: TextField(
                              focusNode: _focusNode,
                              onEditingComplete: (){
                                // FocusScope.of(context).requestFocus(_focusNode1);
                            
                              },
                              onChanged: (value) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                    FirstNameChangedEvent(
                                        firstNameController.text));
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                                floatingLabelStyle: TextStyle(color: borderColor),
                                labelText: "Account Holder’s Name",
                                hintStyle:
                                    const TextStyle(color: Colours.primarybrown),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: borderColor,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                ),
                              ),
                              controller: firstNameController,
                              obscureText: false,
                            ),
                            // InputTextBox(
                            //   select: false,
                            //   hinttext: 'First Name',
                            //   icon: Icon(Icons.person, color: Colours.primarygreen),
                            // ),
                          );
                        },
                      ),
           SizedBox(
              height: 15,
            ),
            BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        Color borderColor = Colours.primarybrown;
                        if (state is SignUpPhoneValidState) {
                          phoneValid = true;
                        }
                        if (state is SignUpPhoneInValidState) {
                          phoneValid = false;
                        }
                        if (phoneValid == true) {
                          borderColor = Colours.primarygreen;
                        } else if (phoneValid == false) {
                          borderColor = Colors.red;
                        } else {
                          borderColor = Colours.primarybrown;
                        }
                        return SizedBox(
                          width: screenWidth * 0.85,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              // BlocProvider.of<SignUpBloc>(context).add(
                              //     PhoneNoChangedEvent(
                              //         phonenumberController.text));
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                              counterText: '',
                              floatingLabelStyle: TextStyle(color: borderColor),
                              labelText: "Account Number",
                              hintStyle:
                                  const TextStyle(color: Colours.primarybrown),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: borderColor,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                            ),
                            controller: phonenumberController,
                            obscureText: false,
                            // maxLength: 10,
                          ),
                        );
                      },
                    ),
             SizedBox(
              height: 15,
            ),
            DropdownExample(bank: bankName,branch: branchName,),                   
        ]),
      ),
        bottomNavigationBar: 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: CustomButton(
            label: loading == false ?"Update":"loading",
            color: Colours.primarygreen,
            onpressed: (){
              // setState(() {
              //   loading=true;
              // });
              //if(citizenshipName != 'null' || LicenseFileName != 'null'){
                UpdateBankingDetails();
              //   setState(() {
              //   loading=false;
              // });
              //}
              
            },
          ),
        ),
    );
  }
}


class DropdownExample extends StatefulWidget {
  String? bank;
  String? branch;

  DropdownExample({this.bank,this.branch});
  @override
  _DropdownExampleState createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  String? selectedBank;
  String? selectedBranch;
  List<String> banks = [
    'Siddhartha Bank',
    'Sanima Bank',
    'Shangrilla Bank',
  ];

  Map<String, List<String>> branches = {
    'Siddhartha Bank': ['Pokhara', 'Kathmandu', 'Birgunj'],
    'Sanima Bank': ['Kathmandu', 'Pokhara', 'Nepalgunj'],
    'Shangrilla Bank': ['Pokhara', 'Kathmandu', 'Lalitpur'],
  };

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Bank Name")),
            SizedBox(height: 5,),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(0.0),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0),
              
            ),
            child: DropdownButton<String>(
              isExpanded: true, // Make the dropdown full width
              hint: Text(widget.bank.toString()==''? 'Select a Bank':widget.bank.toString()),
              value: selectedBank,
              underline: Container(), 
              onChanged: (newValue) {
                setState(() {
                  selectedBank = newValue;
                  bankName = newValue!;
                  selectedBranch = null; // Reset the branch selection
                });
              },
              items: banks.map((bank) {
                return DropdownMenuItem<String>(
                  value: bank,
                  child: Text(bank),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 15,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Branch Name')),
            SizedBox(height: 5,),
          // if (selectedBank != null)
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: DropdownButton<String>(
                isExpanded: true, // Make the dropdown full width
                hint: Text(widget.branch.toString()==''? 'Select a Branch':widget.branch.toString()
                  // widget.branch ?? 'Select a Branch'
                   ),
                underline: Container(), 
                value: selectedBranch,
                onChanged: (newValue) {
                  setState(() {
                   branchName = newValue!;
                    selectedBranch = newValue;
                  });
                },
                items: branches[selectedBank]?.map((branch) {
                  return DropdownMenuItem<String>(
                    value: branch,
                    child: Text(branch),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
