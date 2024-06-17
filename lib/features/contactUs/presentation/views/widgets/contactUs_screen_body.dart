import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/contactUs/repos/contactUsApi.dart';

import '../../../../navdrawer/presentation/views/widgets/nav_drawer.dart';
import '../../../../navdrawer/presentation/views/nav_drawer_view.dart';

class ContactUsScreenBody extends StatefulWidget {
  ContactUsScreenBody({super.key});

  static var formKey = GlobalKey<FormState>();

  @override
  State<ContactUsScreenBody> createState() => _ContactUsScreenBodyState();
}

class _ContactUsScreenBodyState extends State<ContactUsScreenBody> {
   bool _isLoading = false;
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
       color: kPrimaryColor,
      inAsyncCall: _isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        drawer: NavDrawerView(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Contact Us',
            style:
                TextStyle(fontSize: 22, fontFamily: 'Lato', color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                // top: 20,
                left: 20,
                right: 20,
              ),
              child: Form(
                key: ContactUsScreenBody.formKey,
                child: Column(
                  children: [
                    Text(
                      'Contact us by sending your message ,we will reply to you soon',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Lato',
                          color: kPrimaryColor),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormFeild(
                      controller: nameController,
                      type: TextInputType.name,
                      label: 'Name',
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    defaultFormFeild(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email',
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    defaultFormFeild(
                      controller: phoneController,
                      type: TextInputType.number,
                      label: 'Phone',
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    defaultFormFeild(
                      controller: messageController,
                      type: TextInputType.multiline,
                      min: 8,
                      max: 12,
                      label: 'Message',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: kPrimaryColor,
                        minimumSize: const Size(400, 55),
                      ),
                      onPressed: () async {
                        if (ContactUsScreenBody.formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          await ContactUsAPI().contactUs(
                              context: context,
                              nameCont: nameController,
                              emailCont: emailController,
                              phoneCont: phoneController,
                              msgCont: messageController);
                               setState(() {
                           _isLoading =false;
                        }); 
                              
                        }
                        
                       
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
