import 'package:bodima/models/location_model.dart';
import 'package:scoped_model/scoped_model.dart';

mixin LocationScope on Model {
  Location _currentLocation;

  Location get currentLocation {
    return _currentLocation;
  }

  set currentLocation(Location loc) {
    _currentLocation = loc;
    notifyListeners();
  }
}
