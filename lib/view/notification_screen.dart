import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohadraty/bloc/main_bloc/main_cubit.dart';
import 'package:mohadraty/bloc/main_bloc/main_states.dart';
import 'package:mohadraty/components/settings/notification_tile.dart';
import 'package:mohadraty/src/app_assets.dart';
import 'package:mohadraty/src/app_colors.dart';
import 'package:mohadraty/src/app_shared.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List notes = [];
  List dates = [];
  @override
  void initState() {
    for (var note in AppShared.localStorage.getStringList('notes')!) {
      notes.add(note);
    }
    for (var date in AppShared.localStorage.getStringList('notes_dates')!) {
      dates.add(date);
    }
    setState(() {});
    log(notes.toString());
    log(dates.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit.get(context);
          return LayoutBuilder(builder: (context, consta) {
            return Scaffold(
              appBar: AppBar(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                title: Text(
                  context.tr('notification'),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              backgroundColor: const Color(0xFF141416),
              body: LayoutBuilder(builder: (context, consta) {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: consta.maxHeight * 0.02),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xFF23262F),
                                  border: Border(
                                    top: BorderSide(
                                        color: Color(0xFFBEFF6C), width: 5),
                                  ),
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25))),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                        width: 1,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    context.tr('recent'),
                                    style: const TextStyle(
                                        fontSize: 32,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  if (notes.isEmpty)
                                    Column(
                                      children: [
                                        Image.asset(AppAssets.notFoundIllu),
                                        Text(
                                          context.tr('empty'),
                                          style: const TextStyle(
                                              fontSize: 32,
                                              color: AppColors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  else
                                    Expanded(
                                      child: ListView.separated(
                                        itemCount: notes.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            NotificationsTile(
                                          date: dates[index],
                                          title: notes[index],
                                          consta: consta,
                                        ),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                                height:
                                                    consta.maxHeight * 0.02),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ]));
              }),
            );
          });
        });
  }
}
