import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_holy_quran/component/global_component.dart';
import 'package:the_holy_quran/model/ayat.dart';
import 'package:the_holy_quran/model/surah.dart';

class DetailScreen extends StatelessWidget {
  final int noSurat;
  const DetailScreen({super.key, required this.noSurat});

  Future<Surah> _getDetailSurah() async {
    var data = await Dio().get("https://equran.id/api/surat/$noSurat");
    return Surah.fromJson(json.decode(data.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Surah>(
      future: _getDetailSurah(),
      initialData: null,
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: bgColor,
          );
        }
        Surah surah = snapshot.data!;
        return Scaffold(
          backgroundColor: bgColor,
          appBar: _appBar(context: context, surah: surah),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: _details(surah: surah),
              )
            ],
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView.separated(
                itemBuilder: (context, index) => _ayatItem(
                    ayat:
                        surah.ayat!.elementAt(index + (noSurat == 1 ? 1 : 0))),
                itemCount: surah.jumlahAyat + (noSurat == 1 ? -1 : 0),
                separatorBuilder: (context, index) => Container(),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _ayatItem({required Ayat ayat}) => Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                  color: const Color(0xF121931),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(27 / 2)),
                    child: Center(
                      child: Text(
                        '${ayat.nomor}',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, color: bgColor),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.share_outlined,
                    color: Color(0xFF672CBC),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Icon(
                    Icons.play_arrow_outlined,
                    size: 32,
                    color: Color(0xFF672CBC),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Icon(
                    Icons.bookmark_border_outlined,
                    color: Color(0xFF672CBC),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              ayat.ar,
              style:
                  GoogleFonts.amiri(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              ayat.idn,
              style: GoogleFonts.poppins(fontSize: 16),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      );

  Widget _details({required Surah surah}) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Stack(
          children: [
            Container(
              height: 257,
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
                child: Opacity(
                    opacity: .2,
                    child: SvgPicture.asset(
                      'assets/icons/alquran_icon.svg',
                      width: 324 - 55,
                    ))),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              child: Column(
                children: [
                  Text(
                    surah.namaLatin,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 26,
                        color: bgColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    surah.arti,
                    style: GoogleFonts.poppins(
                      color: bgColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  Divider(
                    color: Colors.white.withOpacity(.35),
                    thickness: 2,
                    height: 32,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        surah.tempatTurun.name,
                        style: GoogleFonts.poppins(
                            color: bgColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: bgColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${surah.jumlahAyat} ayat",
                        style: GoogleFonts.poppins(
                            color: bgColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SvgPicture.asset('assets/icons/bismillah_icon.svg')
                ],
              ),
            )
          ],
        ),
      );

  AppBar _appBar({required BuildContext context, required Surah surah}) =>
      AppBar(
        backgroundColor: bgColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
                onPressed: ((() {
                  Navigator.of(context).pop();
                })),
                icon: SvgPicture.asset('assets/icons/back_icon.svg')),
            const SizedBox(
              width: 24,
            ),
            Text(
              surah.namaLatin,
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
