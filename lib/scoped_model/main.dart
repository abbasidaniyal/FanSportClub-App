
import 'package:scoped_model/scoped_model.dart';

import './itf_player_ranking.dart';
import './tournaments.dart';
import './user_profile_search.dart';
import './login.dart';
import './send_mail.dart';
import './payment.dart';
import './gallery_images.dart';

class MainModel extends Model
    with
        ITFPlayerRankingModel,
        TournamentModel,
        UserProfileModel,
        Login,
        SendCIENMail,
        GalleryModel,
        
        PaymentModel {}
