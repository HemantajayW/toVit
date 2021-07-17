import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// const Color pinkshade = Color(0xffFAE3E0);
// const Color blackshade = Color(0xff0C0C0C);

// const Color darkpinkshade = Color(0xffFCA19E);
// var shades = [
//   ColorShade(light: greenshade, dark: darkgreenshade),
//   ColorShade(light: blueshade, dark: darkblueshade),
//   ColorShade(light: pinkshade, dark: darkpinkshade),
//   ColorShade(light: orangeshade, dark: darkorangeshade),
//   ColorShade(light: purpleshade, dark: darkpurpleshade),
// ];

// const Color darkgreenshade = Color(0xff79be8e);
// const Color darkblueshade = Color(0xff719ec6);
// const Color darkpurpleshade = Color(0xffb3acd7);
// const Color darkorangeshade = Color(0xffd7c0ac);
// // const Color darkyellowshade = Color(0xffd7d7ac
// const Color greenshade = Color(0xffE6F3EA);
// const Color orangeshade = Color(0xfff3ece6);
// // const Color yellowshade = Color(0xfff3f3e6);
// const Color purpleshade = Color(0xffe8e6f3);

// const Color blueshade = Color(0xffE6EDF3);
// const googleClrButton = Color(0xff4285F4);

const Color bluedarkbackground = Color(0xff232424);
//inc001000596395
int shadeNo = 1;
// ColorShade getShadeAt(int index) => shades[index];

// Color get getShade => shades[shadeNo].light!;
// Color get getDarkShade => shades[shadeNo].dark!;
final ThemeData appTheme_light = ThemeData(
    primaryColor: Color(0XFF25514a),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xffeeeeee),
    buttonColor: Color(0XFFd65a31),
    appBarTheme: AppBarTheme(backgroundColor: Color(0xffeeeeee), elevation: 1),
    accentColor: Color(0xff8ACAC0),
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      headline1: GoogleFonts.notoSans(
          fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5),
      headline2: GoogleFonts.notoSans(
          fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5),
      headline3:
          GoogleFonts.notoSans(fontSize: 47, fontWeight: FontWeight.w400),
      headline4: GoogleFonts.notoSans(
          fontSize: 33, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headline5:
          GoogleFonts.notoSans(fontSize: 23, fontWeight: FontWeight.w400),
      headline6: GoogleFonts.notoSans(
          fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      subtitle1: GoogleFonts.notoSans(
          fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
      subtitle2: GoogleFonts.notoSans(
          fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyText1: GoogleFonts.roboto(
          fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyText2: GoogleFonts.roboto(
          fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      button: GoogleFonts.roboto(
          fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
      caption: GoogleFonts.roboto(
          fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      overline: GoogleFonts.roboto(
          fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    )
    // textTheme: TextTheme(
    //   headline1: TextStyle(),
    //   headline2: TextStyle(),
    //   headline3: TextStyle(),
    // ),
    );
var vle = Color(0XFF022c43);
final ThemeData appTheme_dark = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: vle,
  buttonColor: Color(0XFFca3e47),
  // brightness: Brightness.light,
  accentColor: Color(0XFFca3e47),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: vle,
    elevation: 1,
  ),
  // fontFamily: 'NatoSans',
  textTheme: TextTheme(
    headline1: GoogleFonts.robotoSlab(
        fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.robotoSlab(
        fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3:
        GoogleFonts.robotoSlab(fontSize: 48, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.robotoSlab(
        fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5:
        GoogleFonts.robotoSlab(fontSize: 24, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.robotoSlab(
        fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.robotoSlab(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.robotoSlab(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.roboto(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.roboto(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.roboto(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.roboto(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.roboto(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  ),
);

class ColorShade {
  Color? light;
  Color? dark;
  ColorShade({this.dark, this.light});
}

//TODO: pallete 1
// Color(0xff222831),
// Color(0XFFd65a31),
// Color(0XFFca3e47),
// Color(0xffeeeeee),

// TODO:
// 022c43 blue
//ffd700 yellow

//TODO
