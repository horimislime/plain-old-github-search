import 'package:flutter/cupertino.dart';
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
  TextEditingController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<GitHubRepository> repositories = const [
      GitHubRepository(name: 'flutter/flutter'),
      GitHubRepository(name: 'apple/swift')
    ];
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Styles.scaffoldBackground
      ),
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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: _controller,
        focusNode: _focusNode,
      ),
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

  void _onTextChanged() {
    setState(() {
      // TODO: Call API
    });
  }
}
