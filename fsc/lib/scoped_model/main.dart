import 'package:scoped_model/scoped_model.dart';

import './user_profile.dart';
import './tournaments.dart';

class MainModel extends Model with UserProfielModel , TournamentModel {}
