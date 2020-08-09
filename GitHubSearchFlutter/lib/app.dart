import 'package:GitHubSearchFlutter/app_state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'model/github_repository.dart';
import 'repository_row_item.dart';
import 'search_bar.dart';
import 'styles.dart';

class RepositorySearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        child: RepositorySearchPage(),
      ),
    );
  }
}

class RepositorySearchPage extends StatefulWidget {
  @override
  _RepositorySearchPageState createState() => _RepositorySearchPageState();
}

class _RepositorySearchPageState extends State<RepositorySearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateModel>(context);
    final repositories = model.searchResults;
    return DecoratedBox(
      decoration: const BoxDecoration(color: Styles.scaffoldBackground),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _buildSearchBar(),
            _buildSearchResult(repositories),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: SearchBar(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: (text) => model.search(text),
          ),
        );
      },
    );
  }

  Widget _buildSearchResult(List<GitHubRepository> repositories) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => RepositoryRowItem(
          index: index,
          repository: repositories[index],
          lastItem: index == repositories.length - 1,
        ),
        itemCount: repositories.length,
      ),
    );
  }
}
