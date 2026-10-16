import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_mania/Screens/AddImage_Screen.dart';
import 'package:image_mania/Screens/Auth_Screen.dart';
import 'package:image_mania/Screens/HomeScreen.dart';
import 'package:image_mania/Service/auth_Service.dart';
import 'package:image_mania/Widgets/CustomTextFeild.dart';
import 'package:image_mania/colors.dart';

class ProfileScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _auth = AuthService();
  final TextEditingController _Emailcontroleer = TextEditingController();
  final TextEditingController _Passcontroleer = TextEditingController();

  Future<void> _SaveChange() async {
    String email = _Emailcontroleer.text;
    final pass = _Passcontroleer.text.trim();
    if (email.isEmpty || pass.isEmpty) {
      print("Email:${email}");
      print("Pass:${pass}");
      print("Cannot email & pass is Empty");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email and Password cannot be empty"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String? errorMsg = await _auth.updateEmailAndPassword(
        newEmail: email,
        newPassword: pass,
      );
      if (errorMsg == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(' Update your data successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed Update your data '),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("Error in SaveChange ${e}");
    }
  }

  String userEmail = "Loading...";
  String userName = "Loading...";
  @override
  void initState() {
    super.initState();
    getUserEmail();
  }

  void getUserEmail() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      setState(() {
        userEmail = user.email!;
        userName = userEmail.split('@')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      /////////////////////

      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 28,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            const CircleAvatar(
                              radius: 42,
                              backgroundColor: Color(0xFFE1ECE9),
                              child: Icon(Icons.person, size: 32),
                            ),
                            Positioned(
                              right: -4,
                              bottom: -2,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD9C3A5),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.photo_camera_outlined,
                                  size: 16,
                                  color: colorFeild,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // اسم المستخدم
                        Text(
                          userName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userEmail,
                          style: TextStyle(
                            color: Color(0xBFFFFFFF),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      
                      child: Text("  Change Email OR Password",),
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        // CustomTextFeild(
                        //   title: "Username",
                        //   icon: Icons.person,
                        //   hint: "username",
                        // ),
                        // const SizedBox(height: 14),

                        CustomTextFeild(
                          title: " New Email",
                          icon: Icons.mail,
                          hint: "@gmail.com",
                          controller: _Emailcontroleer,
                        ),
                        const SizedBox(height: 14),

                        CustomTextFeild(
                          title: " New Password",
                          icon: Icons.lock_outline,
                          hint: '********',
                          controller: _Passcontroleer,
                        ),
                        const SizedBox(height: 14),

                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: greenColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () async {
                              await _SaveChange();
                            },
                            child: const Text(
                              'Save changes',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  TextButton.icon(
                    style: TextButton.styleFrom(foregroundColor: logOutColor),
                    icon: const Icon(Icons.logout, size: 20),
                    label: const Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      _auth.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AuthScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
        child: Card(
          color: bottomNavigationBarColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: NavigationBar(
            height: 55,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedIndex: 2,
            labelBehavior: NavigationDestinationLabelBehavior
                .alwaysHide, // لإلغاء المساحة المحجوزة للنصوص
            onDestinationSelected: (i) {
              if (i == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Homescreen()),
                );
              }
              if (i == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddImageScreen(),
                  ),
                );
              }
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, color: Colors.white, size: 28),
                selectedIcon: Icon(
                  Icons.home,
                  color: greenColor,
                  size: 28,
                ), // لون الأيقونة داخل المؤشر الأبيض
                label: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.add, color: Colors.white, size: 28),
                selectedIcon: Icon(Icons.add, color: greenColor, size: 28),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline, color: Colors.white, size: 28),
                selectedIcon: Icon(Icons.person, color: greenColor, size: 28),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
