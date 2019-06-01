import 'package:scoped_model/scoped_model.dart';
import 'package:ontas/scoped_model/user_scoped_model.dart';
import 'package:ontas/scoped_model/person_scoped_model.dart';

class MainModel extends Model with UserScopedModel, LostPersonScopedModel {}
