import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'app_state_model.dart';

void main() => runApp(ChangeNotifierProvider<AppStateModel>(
    create: (_) => AppStateModel(), child: RepositorySearchApp()));
