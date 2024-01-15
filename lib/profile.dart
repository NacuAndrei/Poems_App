import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:poetry_app/Auth/Services/AuthService.dart';
import 'package:poetry_app/Data/Models/PoemModel.dart';
import 'package:poetry_app/Data/Services/DataService.dart';
import 'package:poetry_app/Feed/PoemList.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String? userId = GetIt.instance.get<AuthService>().getUserId();

  late final Stream<QuerySnapshot<Map<String, dynamic>>> _poemDraftsStream;

  @override
  void initState() {
    if (userId != null) {
      _poemDraftsStream =
          GetIt.instance.get<DataService>().getPoemDrafts(userId ?? "");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              child: Column(
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(GetIt.instance
                                .get<AuthService>()
                                .getUserPhotoURL() ??
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Eminescu.jpg/330px-Eminescu.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    GetIt.instance.get<AuthService>().getUserDisplayName() ??
                        "Unknown",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "-Poet-",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            Text(
              "About me",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8.0),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 32.0),
            Text(
              "Poems",
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: PoemList(
                poemsStream: _poemDraftsStream,
                published: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
