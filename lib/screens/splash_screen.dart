import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_holy_quran/component/global_component.dart';
import 'package:the_holy_quran/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Qur'an App",
                  style: GoogleFonts.poppins(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Learn Qur'an and\nRecite once everyday",
                  style: GoogleFonts.poppins(color: textColor, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 48,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 450,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: primaryColor),
                      child: SvgPicture.asset("assets/icons/splash_icon.svg"),
                    ),
                    Positioned(
                      left: 0,
                      bottom: -23,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            HitTestBehavior.opaque;
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                            decoration: BoxDecoration(
                              color: orangeColor,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Text(
                              "Get Started",
                              style: GoogleFonts.poppins(
                                  color: bgColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
