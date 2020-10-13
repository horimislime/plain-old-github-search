import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'model/github_repository.dart';
import 'styles.dart';

class RepositoryRowItem extends StatelessWidget {
  const RepositoryRowItem({
    this.index,
    this.repository,
    this.lastItem,
  });

  final GitHubRepository repository;
  final int index;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    repository.name,
                    style: Styles.rowItemLarge,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  if (repository.description != null)
                    Text(
                      repository.description,
                      style: Styles.rowItemSmall,
                    ),
                  Text(DateFormat.yMMMd().format(repository.updatedAt),
                      style: Styles.rowItemSmall)
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: Styles.productRowDivider,
          ),
        ),
      ],
    );
  }
}
