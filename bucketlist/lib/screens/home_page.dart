
import 'package:bucketlist/screens/add_bucketlist.dart';
import 'package:bucketlist/screens/view_bucket.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<dynamic> bucketListData = [];
  bool isLoading = false;
  bool isError = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response res = await Dio().get(
        "https://flutterapi-56219-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist.json",
      );

      if (res.data is List) {
        bucketListData = res.data;
      } else {
        bucketListData = [];
      }
      isLoading = false;
      isError = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      isError = true;
      setState(() {});
    }
  }

  Widget showError({required String errorText}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning, color: Colors.redAccent),
          Text(errorText),
          ElevatedButton(onPressed: getData, child: Text("Try Again")),
        ],
      ),
    );
  }

  Widget showBucketList() {
    //Filter the bucket list based on completion false
    List<dynamic> filteredBucketList = bucketListData
        .where((element) => !(element?['completed'] ?? false))
        .toList();

    return filteredBucketList.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.document_scanner), Text("No data")],
          )
        : ListView.builder(
            itemCount: bucketListData.length,
            itemBuilder: (BuildContext context, int index) {
              return (bucketListData[index] is Map &&
                  (!(bucketListData[index]?["completed"] ?? false)))
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (content) => ViewBucket(
                            index: index,
                            title: bucketListData[index]?['item'] ?? "",
                            image: bucketListData[index]?['image'] ?? "",
                          ),
                        ),
                      ).then(
                        (value) => {
                          if (value == 'refresh') {getData()},
                        },
                      );
                    },
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        bucketListData[index]?['image'] ?? "",
                      ),
                    ),
                    title: Text(bucketListData[index]?['item'] ?? ""),
                    trailing: Text(
                      bucketListData[index]?['cost'].toString() ?? "",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
              )
              : SizedBox();
            },
          );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddBucketlist(newIndex: bucketListData.length),
            ),
          ).then((value) => {
            if (value == 'refresh') {
              getData()
            }
          });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Bucket List"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(onTap: getData, child: Icon(Icons.refresh)),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getData();
                },
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : isError
                    ? showError(errorText: "Error fetching data")
                    : showBucketList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
