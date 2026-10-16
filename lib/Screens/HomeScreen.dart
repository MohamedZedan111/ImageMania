import 'package:flutter/material.dart';
import 'package:image_mania/Models/imge_model.dart';
import 'package:image_mania/Screens/AddImage_Screen.dart';
import 'package:image_mania/Screens/Auth_Screen.dart';
import 'package:image_mania/Screens/Profile_Screen.dart';
import 'package:image_mania/Service/auth_Service.dart';
import 'package:image_mania/Service/database_imge.dart';
import 'package:image_mania/Widgets/SingleCardWidget.dart';
import 'package:image_mania/colors.dart';

class Homescreen extends StatefulWidget {
  const new({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  DatabaseImg _databaseImg = DatabaseImg();
  AuthService _auth = AuthService();
  List<imgeModel> images = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    // Fetch all images from the database when the screen initializes
    _databaseImg.getAllImage().then((value) {
      setState(() {
        images = value;
        _isLoading = false;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: CircleAvatar(
            backgroundColor: greenColor,
            radius: 23,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              icon: const Icon(Icons.person, color: Colors.white),
            ),
          ),
        ),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search images',
            prefixIcon: const Icon(Icons.search, color: colorFeild),
            filled: true,
            fillColor: backgroundColor,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: colorBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: colorBorder),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              //backgroundColor: Colors.red,
              radius: 23,
              backgroundColor: bottomNavigationBarColor,
              child: IconButton(
                onPressed: () async {
                 await _auth.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Homescreen()),
                  );
                },
                icon: const Icon(Icons.refresh, color: Colors.white),
              ),
            ),
          ),
        ],
      ),

      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                childAspectRatio: 0.5,
                children: images.map((image) {
                  return SingleCardWidget(
                    imagePath: image.imgePath ?? '',
                    title: image.tiltle ?? '',
                    subTitle: image.subTitle ?? '',
                  );
                }).toList(),
              ),
            ),
      bottomNavigationBar: BottomVavigationBarWidget(),
    );
  }
}

class BottomVavigationBarWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: Card(
        color: bottomNavigationBarColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: NavigationBar(
          height: 55,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedIndex: 0,
          labelBehavior: NavigationDestinationLabelBehavior
              .alwaysHide, // لإلغاء المساحة المحجوزة للنصوص
          onDestinationSelected: (i) {
            if (i == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            } else if (i == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddImageScreen()),
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
    );
  }
}
