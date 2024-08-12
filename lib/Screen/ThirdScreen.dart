import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/model_user.dart';
import '../Core/connection.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<User> users = [];
  int currentPage = 1;
  int totalPages = 1; // Variabel untuk menyimpan total halaman
  bool isLoading = false;
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    if (isLoading || !hasMoreData) return;

    setState(() {
      isLoading = true;
    });

    final response =
        await http.get(Uri.parse('${Connection.apiUrl}&page=$currentPage'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List<User> fetchedUsers = (data['data'] as List)
          .map((userJson) => User.fromJson(userJson))
          .toList();

      setState(() {
        users.addAll(fetchedUsers);
        totalPages = data['total_pages']; // Update total halaman

        if (currentPage >= totalPages) {
          hasMoreData = false; // Tidak ada halaman lebih lanjut
        } else {
          currentPage++; // Naikkan halaman jika masih ada halaman berikutnya
        }
      });
    } else {
      throw Exception('Failed to load users');
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> refreshData() async {
    setState(() {
      users.clear();
      currentPage = 1;
      hasMoreData = true;
      totalPages = 1;
    });
    await fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: const Color.fromARGB(255, 1, 94, 170),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Third Screen',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!isLoading &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                hasMoreData) {
              fetchUsers();
            }
            return false;
          },
          child: RefreshIndicator(
            onRefresh: refreshData,
            child: users.isEmpty && !isLoading
                ? Center(
                    child: Text('No users found.'),
                  )
                : ListView.separated(
                    itemCount: users.length + (hasMoreData ? 1 : 0),
                    separatorBuilder: (context, index) => Divider(
                      indent: 20,
                      endIndent: 20,
                      thickness: 1,
                    ),
                    itemBuilder: (context, index) {
                      if (index == users.length) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final user = users[index];
                      return ListTile(
                        leading: Container(
                          width: 49,
                          height: 49,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.avatar ?? ''),
                          ),
                        ),
                        title: Text(
                          '${user.firstname} ${user.lastname}',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(
                              context, '${user.firstname} ${user.lastname}');
                        },
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
