import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_mania/Screens/HomeScreen.dart';
import 'package:image_mania/Service/auth_Service.dart';
import 'package:image_mania/Widgets/CustomTextFeild.dart';
import 'package:image_mania/colors.dart';

class AuthScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isRegister = false;
  final AuthService _auth = AuthService();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();

//Future =>معناها إن الدالة ممكن تنفذ عملية محتاجة وقت
  Future<void> authenticate() async {
  final String email = _emailcontroller.text.trim();
  final String pass = _passcontroller.text.trim();

  if (email.isEmpty || pass.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Email and Password cannot be empty"),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  try {
    if (isRegister) {
      await _auth.signUp(
        email: email,
        password: pass,
      );
    } else {
      await _auth.signIn(
        email: email,
        password: pass,
      );
    }
    //مثلًا لو المستخدم خرج من الشاشة أثناء انتظار Firebase.
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Homescreen(),
      ),
    );
  } on FirebaseAuthException //مثلًا لو المستخدم خرج من الشاشة أثناء انتظار Firebase.
  catch (e) {
    if (!mounted) return;

    String message = "An error occurred";

    if (e.code == 'user-not-found') {
      message = "No account found with this email";
    } else if (e.code == 'wrong-password') {
      message = "Incorrect password";
    } else if (e.code == 'invalid-credential') {
      message = "Incorrect email or password";
    } else if (e.code == 'email-already-in-use') {
      message = "This email is already registered";
    } else if (e.code == 'weak-password') {
      message = "Password is too weak";
    } else if (e.code == 'invalid-email') {
      message = "Invalid email address";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Something went wrong. Please try again."),
        backgroundColor: Colors.red,
      ),
    );

    print("Authentication error: $e");
  }
}
  @override
  void dispose() {
    _emailcontroller.dispose();
    _passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,

      body: Stack(
        children: [
          const Positioned(
            left: 28,
            top: 56,

            child: Row(
              children: [
                Icon(Icons.image_outlined),
                SizedBox(width: 8),
                Text(
                  "ImagMania",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          //Form
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isRegister ? "Create Your account" : "Welcome back",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: 16),

                  if (isRegister)
                    CustomTextFeild(
                      title: "Full Name",
                      icon: Icons.person,
                      hint: 'Enter Your Name',
                    ),

                  CustomTextFeild(
                    title: "Email",
                    icon: Icons.mail_outlined,
                    hint: '@gmail.com',
                    controller: _emailcontroller,
                  ),
                  SizedBox(height: 8),
                  CustomTextFeild(
                    title: "Password",
                    icon: Icons.lock_outline,
                    hint: '********',
                    controller: _passcontroller,
                  ),
                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),

                      onPressed: () async {
                        await authenticate();
                      },
                      child: Text(
                        isRegister ? "SignUp" : "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        isRegister
                            ? "    Already have an acount?"
                            : "   Don`t have an acount?",
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isRegister = !isRegister;
                          });
                        },
                        child: Text(
                          isRegister ? "Login" : "Create account",
                          style: const TextStyle(
                            color: colorLink,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
