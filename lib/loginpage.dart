import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pixel_adventure/welcomepage.dart';
import 'forgot_password_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginpage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<loginpage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserCredentials();
  }

  _loadUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
    });
  }

  _saveUserCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  _clearUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 120),
              Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'ro',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Email',
                      hintStyle: TextStyle(fontFamily: 'ro'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: 'Password',
                      hintStyle: TextStyle(fontFamily: 'ro'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    User? user = userCredential.user;
                    print('Sign in: ${user!.uid}');

                    // Hiển thị hộp thoại sau khi đăng nhập thành công
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Lưu thông tin đăng nhập'),
                          content: Text(
                              'Bạn có muốn lưu thông tin đăng nhập cho lần tới không?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Không'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => welcomepage()),
                                );
                              },
                            ),
                            TextButton(
                              child: Text('Có'),
                              onPressed: () async {
                                await _saveUserCredentials(emailController.text,
                                    passwordController.text);
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => welcomepage()),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } catch (e) {
                    print('404-error: $e');

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Failed to sign in: $e'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Log In'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage()),
                  );
                },
                child: Text('Quên mật khẩu?'),
              ),
              const SizedBox(width: 10),
              SizedBox(height: 230),
              GestureDetector(
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: Offset(1, 1),
                        blurRadius: 10,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(120),
                      topRight: Radius.circular(120),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'ro',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return DraggableScrollableSheet(
                        initialChildSize: 0.77,
                        builder: (context, scrollController) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(120),
                                topRight: Radius.circular(120),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 50),
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'ro',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Container(
                                      padding: EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: TextField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.email),
                                          hintText: 'Email',
                                          hintStyle:
                                              TextStyle(fontFamily: 'ro'),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Container(
                                      padding: EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: TextField(
                                        controller: passwordController,
                                        obscureText: true,
                                        obscuringCharacter: '*',
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.lock),
                                          hintText: 'Password',
                                          hintStyle:
                                              TextStyle(fontFamily: 'ro'),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        UserCredential userCredential =
                                            await FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    welcomepage()));
                                      } catch (e) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Error'),
                                              content:
                                                  Text('Failed to sign up: $e'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: const Text('Sign up'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:pixel_adventure/welcomepage.dart';
// import 'forgot_password_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class loginpage extends StatelessWidget {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   loginpage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.only(bottom: 16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(height: 120),
//               Center(
//                 child: Text(
//                   'Login',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontFamily: 'ro',
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 40),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: Container(
//                   padding: EdgeInsets.only(left: 15),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15)),
//                   child: TextField(
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       icon: Icon(Icons.email),
//                       hintText: 'Email',
//                       hintStyle: TextStyle(fontFamily: 'ro'),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: Container(
//                   padding: EdgeInsets.only(left: 15),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15)),
//                   child: TextField(
//                     controller: passwordController,
//                     obscureText: true,
//                     obscuringCharacter: '*',
//                     decoration: InputDecoration(
//                       icon: Icon(Icons.lock),
//                       hintText: 'password',
//                       hintStyle: TextStyle(fontFamily: 'ro'),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     UserCredential userCredential =
//                         await FirebaseAuth.instance.signInWithEmailAndPassword(
//                       email: emailController.text,
//                       password: passwordController.text,
//                     );
//                     User? user = userCredential.user;
//                     print('Sign in: ${user!.uid}');
//
//                     // Hiển thị hộp thoại sau khi đăng nhập thành công
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text('Lưu thông tin đăng nhập'),
//                           content: Text('Bạn có muốn lưu thông tin đăng nhập cho lần tới không?'),
//                           actions: <Widget>[
//                             TextButton(
//                               child: Text('Không'),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => welcomepage()),
//                                 );
//                               },
//                             ),
//                             TextButton(
//                               child: Text('Có'),
//                               onPressed: () async {
//                                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                                 await prefs.setString('email', emailController.text);
//                                 await prefs.setString('password', passwordController.text);
//                                 Navigator.of(context).pop();
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => welcomepage()),
//                                 );
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     );
//
//                     // Navigator.push(context,
//                     //     MaterialPageRoute(builder: (context) => welcomepage()));
//                   } catch (e) {
//                     print('404-error: $e');
//
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text('Error'),
//                           content: Text('Failed to sign in: $e'),
//                           actions: <Widget>[
//                             TextButton(
//                               child: Text('OK'),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   }
//                 },
//                 child: const Text('Log In'),
//               ),
//               // const SizedBox(width: 10),
//               // SizedBox(height: 230),
//
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
//                   );
//                 },
//                 child: Text('Quên mật khẩu?'),
//               ),
//
//               const SizedBox(width: 10),
//               SizedBox(height: 230),
//
//
//               GestureDetector(
//                 child: Container(
//                   height: 100,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade300,
//                         offset: Offset(1, 1),
//                         blurRadius: 10,
//                       )
//                     ],
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(120),
//                       topRight: Radius.circular(120),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Sign Up',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'ro',
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   showModalBottomSheet(
//                     isScrollControlled: true,
//                     backgroundColor: Colors.transparent,
//                     barrierColor: Colors.transparent,
//                     context: context,
//                     builder: (BuildContext context) {
//                       return DraggableScrollableSheet(
//                         initialChildSize: 0.77,
//                         builder: (context, scrollController) {
//                           return Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(120),
//                                 topRight: Radius.circular(120),
//                               ),
//                             ),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   SizedBox(height: 50),
//                                   Text(
//                                     'Sign Up',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontFamily: 'ro',
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   SizedBox(height: 30),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 30),
//                                     child: Container(
//                                       padding: EdgeInsets.only(left: 15),
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(15)),
//                                       child: TextField(
//                                         controller: emailController,
//                                         decoration: InputDecoration(
//                                           icon: Icon(Icons.email),
//                                           hintText: 'Email',
//                                           hintStyle: TextStyle(fontFamily: 'ro'),
//                                           border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(15),
//                                             borderSide: BorderSide.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(height: 20),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 30),
//                                     child: Container(
//                                       padding: EdgeInsets.only(left: 15),
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(15)),
//                                       child: TextField(
//                                         controller: passwordController,
//                                         obscureText: true,
//                                         obscuringCharacter: '*',
//                                         decoration: InputDecoration(
//                                           icon: Icon(Icons.lock),
//                                           hintText: 'password',
//                                           hintStyle: TextStyle(fontFamily: 'ro'),
//                                           border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(15),
//                                             borderSide: BorderSide.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(height: 20),
//                                   ElevatedButton(
//                                     onPressed: () async {
//                                       try {
//                                         UserCredential userCredential =
//                                             await FirebaseAuth.instance
//                                                 .createUserWithEmailAndPassword(
//                                           email: emailController.text,
//                                           password: passwordController.text,
//                                         );
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     welcomepage()));
//                                       } catch (e) {
//                                         showDialog(
//                                           context: context,
//                                           builder: (BuildContext context) {
//                                             return AlertDialog(
//                                               title: Text('Error'),
//                                               content:
//                                                   Text('Failed to sign up: $e'),
//                                               actions: <Widget>[
//                                                 TextButton(
//                                                   child: Text('OK'),
//                                                   onPressed: () {
//                                                     Navigator.of(context).pop();
//                                                   },
//                                                 ),
//                                               ],
//                                             );
//                                           },
//                                         );
//                                       }
//                                     },
//                                     child: const Text('Sign up'),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
