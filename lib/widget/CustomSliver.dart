/*
var top = 0.0;

@override
Widget build(BuildContext context) {
  return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      top = constraints.biggest.height;
                      return FlexibleSpaceBar(
                          centerTitle: true,
                          title: Container(
                            color: Colors.yellow,
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 300),
                              //opacity: top == MediaQuery.of(context).padding.top + kToolbarHeight ? 1.0 : 0.0,
                              opacity: 1.0,
                              child: Text(
                                'Workout',
                                style: TextStyle(
                                    fontSize: top > 70 ? 0.15*top : 16,
                                    backgroundColor: Colors.red
                                ),
                              ),
                            ),
                          ),
                          background: Image.network(
                            "https://images.unsplash.com/photo-1542601098-3adb3baeb1ec?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=5bb9a9747954cdd6eabe54e3688a407e&auto=format&fit=crop&w=500&q=60",
                            fit: BoxFit.cover,
                          )
                      );
                    }
                )
            ),
          ];
        },
        body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context,index){
            return Text("List Item: " + index.toString());
          },
        ),
      )
  );
}*/
