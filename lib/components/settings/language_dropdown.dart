import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohadraty/src/app_colors.dart';

class AppLang {
  String countryCode;
  String langCode;
  String langTitle;
  AppLang(
      {required this.countryCode,
      required this.langCode,
      required this.langTitle});
}

List<AppLang> appLangs = [
  AppLang(countryCode: 'US', langCode: 'en', langTitle: 'English'),
  AppLang(countryCode: 'EG', langCode: 'ar', langTitle: 'عربي')
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
        value: context.locale.languageCode == 'ar' ? appLangs[1] : appLangs[0],
        dropdownColor: AppColors.fillColor,
        alignment: Alignment.topCenter,
        decoration: const InputDecoration(border: InputBorder.none),
        items: appLangs.map((type) {
          return DropdownMenuItem(
            onTap: () {
              context.setLocale(Locale(type.langCode, type.countryCode));
            },
            value: type,
            child: Row(
              children: [
                CountryFlag.fromCountryCode(
                  type.countryCode,
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
