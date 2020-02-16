import 'package:scoped_model/scoped_model.dart';

mixin UtilityScope on Model {
  final String _hostUrl = 'https://bodima-b82e1.firebaseio.com';
  final String _apiKey = 'AIzaSyC4Iaxz3yLvyZft-MqpmF_kgD3HPXcxztE';
  bool _isEdit;

  bool get isEdit {
    return _isEdit;
  }

  set isEdit(bool stat) {
    _isEdit = stat;
    notifyListeners();
  }

  String get hostUrl {
    return _hostUrl;
  }

  String get apiKey => _apiKey;

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool status) {
    _isLoading = status;
    notifyListeners();
  }
}
