import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_holy_quran/component/global_component.dart';
import 'package:the_holy_quran/tabs/hijb_tabs.dart';
import 'package:the_holy_quran/tabs/page_tabs.dart';
import 'package:the_holy_quran/tabs/para_tabs.dart';
import 'package:the_holy_quran/tabs/surah_tabs.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _appBar(),
      body: DefaultTabController(
        length: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: _greetingSallam(),
              ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: bgColor,
                shape: Border(
                  bottom: BorderSide(
                    width: 3,
                    color: const Color(0xFFAAAAAA).withOpacity(.1),
                  ),
                ),
                pinned: true,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: _tab(),
                ),
              ),
            ],
            body: const TabBarView(
              children: [
                SurahTab(),
                ParaTab(),
                PageTab(),
                HijbTab(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  TabBar _tab() {
    return TabBar(
        unselectedLabelColor: textColor,
        labelColor: primaryColor,
        indicatorColor: primaryColor,
        indicatorWeight: 3,
        tabs: [
          _tabItem(label: "Surah"),
          _tabItem(label: "Para"),
          _tabItem(label: "Page"),
          _tabItem(label: "Hijb"),
        ]);
  }

  Tab _tabItem({required String label}) {
    return Tab(
      child: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Column _greetingSallam() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'ٱلسَّلَامُ عَلَيْكُمْ',
          style: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.w500, color: textColor),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          'Alghany Kennedy',
          style: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.w600, color: primaryColor),
        ),
        const SizedBox(
          height: 24,
        ),
        _lastRead()
      ],
    );
  }

  Stack _lastRead() {
    return Stack(
      children: [
        Container(
          height: 135,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                  0,
                  .6,
                  1
                ],
                colors: [
                  Color(0xFFDF98FA),
                  Color(0xFFB070FD),
                  Color(0xFF9055FF),
                ]),
          ),
        ),
        Positioned(
            bottom: 2,
            right: 2,
            child: SvgPicture.asset('assets/icons/alquran_icon.svg')),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/icons/book_icon.svg'),
                  const SizedBox(width: 8),
                  Text(
                    'Last Read',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: bgColor),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Al-Fatihah',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 18, color: bgColor),
              ),
              const SizedBox(height: 4),
              Text(
                'Ayat No: 1',
                style: GoogleFonts.poppins(color: bgColor),
              ),
            ],
          ),
        )
      ],
    );
  }

  AppBar _appBar() => AppBar(
        backgroundColor: bgColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
                onPressed: ((() {})),
                icon: SvgPicture.asset('assets/icons/menu_icon.svg')),
            const SizedBox(
              width: 24,
            ),
            Text(
              "Qur'an App",
              style: GoogleFonts.poppins(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const Spacer(),
            IconButton(
                onPressed: ((() {})),
                icon: SvgPicture.asset('assets/icons/search_icon.svg'))
          ],
        ),
      );
}

BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
      backgroundColor: bgColor,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        _bottomNavBarItem(icon: "assets/icons/quran_icon.svg", label: "home1"),
        _bottomNavBarItem(icon: "assets/icons/lamp_icon.svg", label: "home2"),
        _bottomNavBarItem(icon: "assets/icons/prayer_icon.svg", label: "home3"),
        _bottomNavBarItem(icon: "assets/icons/hand_icon.svg", label: "home4"),
        _bottomNavBarItem(
            icon: "assets/icons/bookmark_icon.svg", label: "home5")
      ],
    );

BottomNavigationBarItem _bottomNavBarItem(
        {required String icon, required String label}) =>
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        color: textColor,
      ),
      activeIcon: SvgPicture.asset(
        icon,
        color: primaryColor,
      ),
      label: label,
    );
