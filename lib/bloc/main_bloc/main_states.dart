abstract class MainStates {}

class MainInitial extends MainStates {}

class MainLoading extends MainStates {}

class MainFailure extends MainStates {
  String msg = '';
  MainFailure(this.msg);
}

class MainSuccess extends MainStates {}

class MainGenQr extends MainStates {
  String qrCode = '';
  MainGenQr(this.qrCode);
}

class MainAdded extends MainStates {
  String msg = '';
  MainAdded(this.msg);
}
