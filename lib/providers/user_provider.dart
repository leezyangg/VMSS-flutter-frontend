import 'package:provider/provider.dart';
import 'user_state.dart';

final userProvider =
    ChangeNotifierProvider<UserState>(create: (ref) => UserState());
