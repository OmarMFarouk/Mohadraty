import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:mohadraty/src/app_colors.dart';

class AppLang {
  String langCode;
  String langTitle;
  AppLang({required this.langCode, required this.langTitle});
}

List<AppLang> appLangs = [
  AppLang(langCode: 'us', langTitle: 'English'),
  AppLang(langCode: 'eg', langTitle: 'عربي')
];

class LanguageDropDown extends StatelessWidget {
  const LanguageDropDown({super.key, required this.consta});
  final BoxConstraints consta;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: consta.maxWidth * 0.3,
      height: kToolbarHeight,
      alignment: Alignment.bottomCenter,
      child: DropdownButtonFormField<AppLang>(
        value: appLangs.first,
        dropdownColor: AppColors.fillColor,
        alignment: Alignment.topCenter,
        decoration: const InputDecoration(border: InputBorder.none),
        items: appLangs.map((type) {
          return DropdownMenuItem(
            value: type,
            child: Row(
              children: [
                CountryFlag.fromCountryCode(
                  type.langCode,
                  width: 32,
                  height: 32,
                ),
                const SizedBox(width: 10),
                Text(
                  type.langTitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.goldish,
                      fontSize: 14),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (val) {},
      ),
    );
  }
}
