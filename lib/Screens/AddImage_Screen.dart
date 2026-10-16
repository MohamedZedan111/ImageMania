import 'package:flutter/material.dart';
import 'package:image_mania/Models/imge_model.dart';
import 'package:image_mania/Screens/HomeScreen.dart';
import 'package:image_mania/Screens/Profile_Screen.dart';
import 'package:image_mania/Service/database_imge.dart';
import 'package:image_mania/Widgets/CustomTextFeild.dart';
import 'package:image_mania/colors.dart';

class AddImageScreen extends StatefulWidget {
  const AddImageScreen({super.key});

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subTitleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  final DatabaseImg _databaseImg = DatabaseImg();

  bool _isLoading = false;

  @override
  void dispose() {
    _urlController.dispose();
    _titleController.dispose();
    _subTitleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  Future<void> _saveImage() async {
    final url = _urlController.text.trim();
    final title = _titleController.text.trim();
    final subTitle = _subTitleController.text.trim().isEmpty
        ? "Not subTitle"
        : _subTitleController.text;
    final author = _authorController.text.trim().isEmpty
        ? "ME  "
        : _authorController.text;
    if (url.isEmpty || title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in Image URL and Title')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      imgeModel newImage = imgeModel(
        imgePath: url,
        tiltle: title,
        subTitle: subTitle,
        author: author,
      );

      await _databaseImg.addImage(newImage);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image added successfully!')),
        );

        // _urlController.clear();
        // _titleController.clear();
        // _subTitleController.clear();
        // _authorController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to add image: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: colorBorder),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 18,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Homescreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Text(
                            'Add image',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        height: 428,//حاولت كتير
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          children: [
                            CustomTextFeild(
                              title: 'Image URL',
                              icon: Icons.link,
                              hint: "https://",
                              controller: _urlController,
                            ),
                            const SizedBox(height: 4),
                            CustomTextFeild(
                              title: 'Title',
                              icon: Icons.title,
                              hint: "Give it a Title",
                              controller: _titleController,
                            ),
                            const SizedBox(height: 4),
                            CustomTextFeild(
                              title: 'SubTitle',
                              icon: Icons.subtitles,
                              hint: "Short description",
                              controller: _subTitleController,
                            ),
                            const SizedBox(height: 4),
                            CustomTextFeild(
                              title: 'Author',
                              icon: Icons.person,
                              hint: "Defult 'ME' ",
                              controller: _authorController,
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 30.0,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: greenColor,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: _isLoading ? null : _saveImage,
                                  child: _isLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          'Save image',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
            selectedIndex: 1,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            onDestinationSelected: (i) {
              if (i == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              } else if (i == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Homescreen()),
                );
              }
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, color: Colors.white, size: 28),
                selectedIcon: Icon(Icons.home, color: greenColor, size: 28),
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
