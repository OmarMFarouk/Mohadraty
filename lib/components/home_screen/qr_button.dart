import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mohadraty/src/app_colors.dart';

import '../../bloc/main_bloc/main_cubit.dart';
import '../../src/app_assets.dart';
import 'qr_dialog.dart';

// ignore: must_be_immutable
class QrButton extends StatelessWidget {
  QrButton({super.key, required this.qrCont, required this.cubit});
  MobileScannerController qrCont;
  final MainCubit cubit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      splashColor: Colors.white.withAlpha(100),
      onTap: () async {
        qrCont = MobileScannerController();
        await showDialog(
          context: context,
          builder: (context) => QrDialog(
            controller: qrCont,
            onCapture: (p0) async {
              cubit.attendClass(qrCode: p0.barcodes[0].rawValue!);
              Navigator.pop(context);
            },
          ),
        );
        qrCont.dispose();
      },
      child: Ink(
        decoration: BoxDecoration(
            image: DecorationImage(
                scale: 1.75, image: AssetImage(AppAssets.scanQrIcon)),
            borderRadius: BorderRadius.circular(15),
            color: AppColors.primary),
        child: const Column(
          children: [
            Text(
              'Scan Qr-Code',
              style: TextStyle(
                  color: Color(0xff131a0b),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.chevron_right,
                size: 45,
              ),
            )
          ],
        ),
      ),
    );
  }
}
