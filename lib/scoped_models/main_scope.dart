import 'package:bodima/scoped_models/border_scope.dart';
import 'package:bodima/scoped_models/location_scope.dart';
import 'package:bodima/scoped_models/owner_scope.dart';
import 'package:bodima/scoped_models/utility_scope.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model
    with UtilityScope, LocationScope, BorderScope, OwnerScope {}
