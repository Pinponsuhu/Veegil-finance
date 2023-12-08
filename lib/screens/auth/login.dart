import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veegil/providers.dart';
import 'package:veegil/screens/auth/register.dart';
import 'package:veegil/screens/home.dart';
import 'package:veegil/services/auth.dart';

class LoginScreen extends StatefulWidget {
  static String id = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true;
  TextEditingController _phoneNumber = TextEditingController(); 
  TextEditingController _password = TextEditingController();


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset("images/veegillogo.png"),
        centerTitle: false,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello. \nWelcome back",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 32, height: 1.2),
            ),
            SizedBox(
              height: 24,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone Number",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  TextFormField(
                    controller: _phoneNumber,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Phone Number field is required";
                      }else if(value!.length < 11){
                        return "Phone Number character cannot be less than 11";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero
                    ),
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  TextFormField(
                    controller: _password,
                    keyboardType: TextInputType.text,
                    obscureText: isVisible,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Password field is required";
                      }else if(value!.length < 8){
                        return "Password character cannot be less than 8";
                      }
                    }, 
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                        suffix: TextButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      style: ButtonStyle(
                        
                          padding: MaterialStateProperty.all(EdgeInsets.zero)),
                      child: Text(
                        "Show", 
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                        ),
                    )),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Consumer(
                      builder: (context,ref,build){
                        return TextButton(
                        onPressed: (){
                          
                          ref.read(login(
                            {
                            'context': context, 
                            'phoneNumber' : _phoneNumber.text,
                            'password' : _password.text
                          }
                          ));

                          // print(AuthHandle )
                          // Navigator.pushNamed(context, HomeScreen.id);
                        }, 
                        child: Text(
                          "Login", 
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold, 
                            fontSize: 20,
                          ),
                          ), 
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          )),
                          padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                          backgroundColor: MaterialStateProperty.all(Colors.blue.shade600)
                        ),
                        );
                      },
                      // child: 
                    ),
                  )
                ],
              ),
            ), 
            Spacer(), 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, RegisterScreen.id);
                  }, 
                  child: Text(
                    "Create Account", 
                    style: TextStyle(
                      fontSize: 16, 
                      color: Colors.grey
                    ),
                    )
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
