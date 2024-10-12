abstract class MainStates {}

class MainInitial extends MainStates {}

class MainLoading extends MainStates {}

class MainFailure extends MainStates {
  String msg = '';
  MainFailure(this.msg);
}

class MainSuccess extends MainStates {}

class MainAdded extends MainStates {
  String msg = '';
  MainAdded(this.msg);
}
