import 'package:flutter/material.dart';
import '/view/on_boarding/on_boarding_gender.dart';
import '../../common/colo_extention.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTab extends StatelessWidget {
  final String name;
  final String email;

  const ProfileTab({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6835bd), // эхний өнгө (2 хэсэг)
              Color(0xFF6b88a3),
              Color(0xFF1E1E1E), // хоёр дахь өнгө (1 хэсэг)
              Color(0xFF1E1E1E), // доод өнгө (1 хэсэг)
            ],
            stops: [0.0, 0.45, 0.45, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                CircleAvatar(
                  radius: 55,
                  backgroundColor: TColor.whiteColor,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/img/power.jpg'),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: TColor.whiteColor,
                  ),
                ),
                const SizedBox(height: 0),
                Text(
                  'Email: $email',
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: TColor.grayColor,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(8),
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.show_chart,
                            color: Colors.black87,
                          ),
                          title: const Text(
                            'Status',
                            style: TextStyle(
                              fontFamily: 'GoogleFonts.notoSans',
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                          onTap: () {},
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(
                            Icons.chat_bubble,
                            color: Colors.black87,
                          ),
                          title: const Text(
                            'Coach',
                            style: TextStyle(
                              fontFamily: 'GoogleFonts.notoSans',
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                          onTap: () {},
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(
                            Icons.lock,
                            color: Colors.black87,
                          ),
                          title: Text(
                            'Нууц үг солих',
                            style: GoogleFonts.notoSans(
                              fontSize: 16,
                              color: const Color.fromARGB(221, 255, 255, 255),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                          onTap: () {},
                        ),

                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(
                            Icons.logout,
                            color: Colors.redAccent,
                          ),
                          title: const Text(
                            'Гарах',
                            style: TextStyle(
                              fontFamily: 'GoogleFonts.notoSans',
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const GenderSelectionView(),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Та гарлаа!")),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
