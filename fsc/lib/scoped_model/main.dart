import 'package:scoped_model/scoped_model.dart';

import './itf_player_ranking.dart';
import './tournaments.dart';
import './user_profile_search_model.dart';

class MainModel extends Model with  ITFPlayerRankingModel, TournamentModel,UserProfileModel {}
