import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../User/View/widgets/button.dart';
import '../../Controller/bloc/Account/sign_up/sign_up_bloc.dart';
import '../components/colors.dart';
import 'package:geocoding/geocoding.dart';


class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
   int? _selectedOption=2;
  bool obscureText1 = true;
  bool obscureText2 = true;
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController phonenumberController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController cityController = TextEditingController();
  List<String> items = ['Delivery', 'Ride Share'];
  
  // Define a variable to store the selected item
  String selectedItem = 'Delivery';

  bool? firstNameValid ;
  bool? lastNameValid;
  bool? phoneValid;
  bool? emailValid;
  bool? passwordValid;
  bool? confirmPasswordValid;
  bool? addressValid;
  bool? cityValid;
  //final _scrollKey = GlobalKey<ScrollableState>();
  //final _textFieldFocus = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();
  final FocusNode _focusNode7 = FocusNode();
  @override
  void initState() {
   _focusNode.addListener(_scrollToFocusedTextField);
    _getCurrentLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // _textFieldFocus.dispose();
    super.dispose();
  }

  void _scrollToFocusedTextField() {
    if (_focusNode.hasFocus) {
      Future.delayed(Duration(milliseconds: 200), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }
   String currentLocation = 'Address';
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks =
          await placemarkFromCoordinates(
              position.latitude, position.longitude);

      Placemark place = placemarks[0];
       Placemark currentPlacemark = placemarks.first;
       String locationName = currentPlacemark.name ?? '';
      String placeName = currentPlacemark.street ?? '';
      setState(() {
       
        currentLocation = '${place.locality}, ${place.country}';
        addressController.text = '${place.street}, ${place.locality}';
        cityController.text = '${place.locality}';
         addressValid =true;
    cityValid =true;
      });
    } catch (e) {
      print(e);
      setState(() {
        currentLocation = 'Error getting location';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // _textFieldFocus.addListener(() {
    //   if (_textFieldFocus.hasFocus) {
    //     Future.delayed(Duration(milliseconds: 300), () {
    //       final context = _scrollKey.currentContext;
    //       if (context != null) {
    //         Scrollable.ensureVisible(
    //           context,
    //           alignment: 0.0,
    //           duration: Duration(milliseconds: 200),
    //           curve: Curves.easeInOut,
    //         );
    //       }
    //     });
    //   }
    // });
    final screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
            onPressed: (){
              Get.back();
            },
          ),
          title: Text('Sign Up',style: TextStyle(color: Colors.black),),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const Logo(),
                  // const SizedBox(height: 5),
                  // const Text(
                  //   'SIGN UP',
                  //   style: TextStyle(
                  //     fontSize: 28,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colours.primarygreen,
                  //   ),
                  // ),
                  // const SizedBox(height: 5),
                  // const Text(
                  //   'Sign up to start ordering your food and groceries',
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      Color borderColor = Colours.primarybrown;
                      if (state is SignUpFirstNameValidState) {
                        firstNameValid = true;
                      }
                      if (state is SignUpFirstNameInValidState) {
                        firstNameValid = false;
                      }
                      if (firstNameValid == true) {
                        borderColor = Colours.primarygreen;
                      } else if (firstNameValid == false) {
                        borderColor = Colors.red;
                      } else {
                        borderColor = Colours.primarybrown;
                      }
                      return SizedBox(
                        width: screenWidth * 0.85,

                        child: TextField(
                          focusNode: _focusNode,
                          onEditingComplete: (){
                            FocusScope.of(context).requestFocus(_focusNode1);

                          },
                          onChanged: (value) {
                            BlocProvider.of<SignUpBloc>(context).add(
                                FirstNameChangedEvent(
                                    firstNameController.text));
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                            floatingLabelStyle: TextStyle(color: borderColor),
                            labelText: "First Name",
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
                  const SizedBox(height: 10),
                  BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      Color borderColor = Colours.primarybrown;
                      if (state is SignUpSecondNameValidState) {
                        lastNameValid = true;
                      }
                      if (state is SignUpSecondNameInValidState) {
                        lastNameValid = false;
                      }
                      if (lastNameValid == true) {
                        borderColor = Colours.primarygreen;
                      } else if (lastNameValid == false) {
                        borderColor = Colors.red;
                      } else {
                        borderColor = Colours.primarybrown;
                      }
                      return SizedBox(
                        width: screenWidth * 0.85,
                        child: TextField(
                          focusNode: _focusNode1,
                          onEditingComplete: (){
                            FocusScope.of(context).requestFocus(_focusNode2);
                          },

                          onChanged: (value) {
                            BlocProvider.of<SignUpBloc>(context).add(
                                SecondNameChangedEvent(
                                    lastNameController.text));
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                            floatingLabelStyle: TextStyle(color: borderColor),
                            labelText: "Last Name",
                            hintStyle:
                                const TextStyle(color: Colours.primarybrown),
                            prefixIcon: Icon(
                              Icons.person,
                              color: borderColor,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                            ),
                          ),
                          controller: lastNameController,
                          obscureText: false,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
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
                          focusNode: _focusNode2,
                          onEditingComplete: (){
                            FocusScope.of(context).requestFocus(_focusNode3);
                          },
                          onChanged: (value) {
                            BlocProvider.of<SignUpBloc>(context).add(
                                PhoneNoChangedEvent(
                                    phonenumberController.text));
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                            counterText: '',
                            floatingLabelStyle: TextStyle(color: borderColor),
                            labelText: "Phone Number",
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
                          maxLength: 10,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      Color borderColor = Colours.primarybrown;
                      if (state is SignUpEmailValidState) {
                        emailValid = true;
                      }
                      if (state is SignUpEmailInValidState) {
                        emailValid = false;
                      }
                      if (emailValid == true) {
                        borderColor = Colours.primarygreen;
                      } else if (emailValid == false) {
                        borderColor = Colors.red;
                      } else {
                        borderColor = Colours.primarybrown;
                      }
                      return SizedBox(
                        width: screenWidth * 0.85,
                        child: TextField(
                          onChanged: (value) {
                            BlocProvider.of<SignUpBloc>(context).add(
                                SignUpEmailChangedEvent(emailController.text));
                          },
                          focusNode: _focusNode3,
                          onEditingComplete: (){
                            FocusScope.of(context).requestFocus(_focusNode4);
                          },
                          // controller: email,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                            labelText: "Email",
                            floatingLabelStyle: TextStyle(color: borderColor),
                            labelStyle: TextStyle(color: Colours.primarybrown),
                            hintText: "",
                            hintStyle:
                                const TextStyle(color: Colours.primarybrown),
                            prefixIcon: Icon(
                              Icons.mail,
                              color: borderColor,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                            ),
                          ),
                          obscureText: false,

                          controller: emailController,
                        ),
                        // InputTextBox(
                        //   emailController: email,
                        //   passwordController: password,
                        //   select: false,
                        //   hinttext: 'Email*',
                        //   icon: Icon(Icons.mail, color: Colours.primarygreen),
                        // ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      Color borderColor = Colours.primarybrown;
                      if (state is SignUpPasswordValidState) {
                        passwordValid = true;
                      }
                      if (state is SignUpPasswordInValidState) {
                        passwordValid = false;
                      }
                      if (passwordValid == true) {
                        borderColor = Colours.primarygreen;
                      } else if (passwordValid == false) {
                        borderColor = Colors.red;
                      } else {
                        borderColor = Colours.primarybrown;
                      }
                      if (state is SignUpPasswordVisible) {
                        obscureText1 = true;
                      }
                      if (state is SignUpPasswordInVisible) {
                        obscureText1 = false;
                      }
                      return SizedBox(
                        width: screenWidth * 0.85,
                        child: TextField(
                          focusNode: _focusNode4,
                          onEditingComplete: (){
                            FocusScope.of(context).requestFocus(_focusNode5);
                          },
                            onChanged: (value) {
                              BlocProvider.of<SignUpBloc>(context).add(
                                  SignUpPasswordChangedEvent(
                                      passwordController.text));
                            },
                            // controller: password,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 8.0),
                              labelText: "Password",
                              floatingLabelStyle: TextStyle(color: borderColor),
                              labelStyle:
                                  TextStyle(color: Colours.primarybrown),
                              hintText: "",
                              hintStyle:
                                  const TextStyle(color: Colours.primarybrown),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: borderColor,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.visibility,
                                  color: obscureText1
                                      ? Colors.grey
                                      : Colours.primarygreen,
                                ),
                                onPressed: () {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                      SignUpVisibiltyPressed(obscureText1));
                                },
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                            ),
                            controller: passwordController,
                            obscureText: obscureText1),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      Color borderColor = Colours.primarybrown;
                      if (state is SignUpConfirmPasswordValidState) {
                        confirmPasswordValid = true;
                      }
                      if (state is SignUpConfirmPasswordInValidState) {
                        confirmPasswordValid = false;
                      }
                      if (confirmPasswordValid == true) {
                        borderColor = Colours.primarygreen;
                      } else if (confirmPasswordValid == false) {
                        borderColor = Colors.red;
                      } else {
                        borderColor = Colours.primarybrown;
                      }
                      if (state is SignUpConfirmPasswordVisible) {
                        obscureText2 = true;
                      }
                      if (state is SignUpConfirmPasswordInVisible) {
                        obscureText2 = false;
                      }
                      return SizedBox(
                        width: screenWidth * 0.85,
                        child: TextField(
                          focusNode: _focusNode5,
                          onEditingComplete: (){
                            FocusScope.of(context).requestFocus(_focusNode6);
                          },
                            onChanged: (value) {
                              BlocProvider.of<SignUpBloc>(context).add(
                                  ConfirmPasswordChangedEvent(
                                      passwordController.text,
                                      confirmPasswordController.text));
                            },
                            // controller: password,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 8.0),
                              labelText: "Re-Password",
                              floatingLabelStyle: TextStyle(color: borderColor),
                              labelStyle:
                                  TextStyle(color: Colours.primarybrown),
                              hintText: "",
                              hintStyle:
                                  const TextStyle(color: Colours.primarybrown),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: borderColor,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.visibility,
                                  color: obscureText2
                                      ? Colors.grey
                                      : Colours.primarygreen,
                                ),
                                onPressed: () {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                      SignUpConfirmVisibiltyPressed(
                                          obscureText2));
                                },
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                            ),
                            controller: confirmPasswordController,
                            obscureText: obscureText2),
                      );
                    },
                  ),
                   SizedBox(
                    height: 15,
                  ),
                   BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      Color borderColor = Colours.primarybrown;
                      if (state is SignUpCityValidState) {
                        cityValid = true;
                      }
                      if (state is SignUpCityInValidState) {
                        cityValid = false;
                      }
                      if (cityValid == true) {
                        borderColor = Colours.primarygreen;
                      } else if (cityValid == false) {
                        borderColor = Colors.red;
                      } else {
                        borderColor = Colours.primarybrown;
                      }
                      return SizedBox(
                        width: screenWidth * 0.85,

                        child: TextField(
                          focusNode: _focusNode6,
                          onEditingComplete: (){
                            FocusScope.of(context).requestFocus(_focusNode7);
                          },
                          onChanged: (value) {
                            BlocProvider.of<SignUpBloc>(context).add(
                                CityChangedEvent(
                                    cityController.text));
                          },
                          onSubmitted: (val){
                            FocusScope.of(context).requestFocus(_focusNode7);

                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                            floatingLabelStyle: TextStyle(color: borderColor),
                            labelText: "City",
                            hintStyle:
                                const TextStyle(color: Colours.primarybrown),
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: borderColor,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                            ),
                          ),
                          controller: cityController,
                          obscureText: false,
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 15),
            BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      Color borderColor = Colours.primarybrown;
                      if (state is SignUpAddressValidState) {
                        addressValid = true;
                      }
                      if (state is SignUpAddressInValidState) {
                        addressValid = false;
                      }
                      if (addressValid == true) {
                        borderColor = Colours.primarygreen;
                      } else if (addressValid == false) {
                        borderColor = Colors.red;
                      } else {
                        borderColor = Colours.primarybrown;
                      }
                      return SizedBox(
                        width: screenWidth * 0.85,

                        child: TextField(
                          focusNode: _focusNode7,
                          onEditingComplete: (){
                             
                          },
                          onSubmitted: (val){
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: (value) {
                            BlocProvider.of<SignUpBloc>(context).add(
                                AddressChangedEvent(
                                    addressController.text));
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                            floatingLabelStyle: TextStyle(color: borderColor),
                            labelText: "Address",
                            
                            hintStyle:
                                const TextStyle(color: Colours.primarybrown),
                            prefixIcon: Icon(
                              Icons.place,
                              color: borderColor,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                            ),
                          ),
                          controller: addressController,
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
             const SizedBox(height: 15),
          
                 
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,20,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         
                        Container(
                          width: Get.width/2.3,
                          child: RadioListTile<int>(
                                    title: Text('Ride Share'),
                                    value: 1,
                                    groupValue: _selectedOption,
                                     tileColor: Colors.grey.shade100,
                                    activeColor: Colours.primarygreen,
                                    onChanged: (int? value) {
                          setState(() {
                            selectedItem = 'Ride Share';
                            
                            _selectedOption = value!;
                          });
                                    },
                                  ),
                        ),
                                Container(
                                  width: Get.width/2.3,
                                  child: RadioListTile<int>(
                                    title: Text('Delivery'),
                                    value: 2,
                                    tileColor: Colors.grey.shade100,
                                    activeColor: Colours.primarygreen,
                                    groupValue: _selectedOption,
                                    onChanged: (int? value) {
                                                  setState(() {
                                                     selectedItem = 'Delivery' ;
                                                    _selectedOption = value!;
                                                  });
                                    },
                                  ),
                                ),
                      ],
                    ),
                  ),
              
                  // Container(
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey),
                  //     borderRadius: BorderRadius.circular(5)
                  //   ),
                  //   width: screenWidth * 0.85,
                  //   child: DropdownButton(
                  //     autofocus: true,
                  //     elevation: 0,
                  //           value: selectedItem, // The currently selected item
                  //           onChanged: (newValue) {
                  //             setState(() {
                  //               selectedItem = newValue!;
                  //             });
                  //           },
                  //           underline: Container(),
                  //           items: items.map((String item) {
                  //             return DropdownMenuItem<String>(
                                
                  //               value: item,
                  //               child: Padding(
                  //                 padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  //                 child: Container(
                  //                   width: screenWidth * 0.70,
                  //                   child: Text(item)),
                  //               ),
                  //             );
                  //           }).toList(),
                  //         ),
                  // ),
            
                  BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      if (state is SignUpErrorState) {
                        return Text(
                          state.errorMessage,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.w400),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 40,
                    width: screenWidth * 0.85,
                    child: BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        String signup = 'CONTINUE';
                        if (state is SignUpLoadingState) {
                          signup = 'loading';
                        } else {
                          signup = 'CONTINUE';
                        }
                        return CustomButton(
                          label: signup,
                          color: Colours.primarygreen,
                          onpressed: () async {
                            print(firstNameValid);
                            print(lastNameValid);
                            print(selectedItem);
                            if (firstNameValid == true &&
                                lastNameValid == true &&
                                phoneValid == true &&
                                emailValid == true &&
                                passwordValid == true &&
                                confirmPasswordValid == true&&
                                addressValid ==true&&
                                cityValid ==true) {
                              BlocProvider.of<SignUpBloc>(context)
                                  .add(SignUpSubmittedEvent(
                                    firstNameController.text,
                                      lastNameController.text,
                                      emailController.text,
                                      phonenumberController.text,
                                      passwordController.text,
                                      confirmPasswordController.text,
                                      addressController.text,
                                      cityController.text,
                                      selectedItem
                                  ));
                            }
                            
                          },
                        );
                      },
                    ),
                  ),
                  const AlreadyHaveAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
       Get.back();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      child: RichText(
        text: const TextSpan(
            text: "Already Have an Account?",
            style: TextStyle(
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: "  LOGIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colours.primaryblue,
                ),
              ),
            ]),
      ),
    );
  }
}
