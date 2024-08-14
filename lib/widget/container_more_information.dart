part of widget;

class ContainerMoreInformation extends StatefulWidget {

  final List<Widget>? children;
  final List<Widget>? moreChildren;
  final CustomRefreshCallback? onRefresh;
  final ScrollController controller;

  const ContainerMoreInformation({Key? key, this.children, this.moreChildren, this.onRefresh, required this.controller}) : super(key: key);

  @override
  ContainerMoreInformationState createState() => ContainerMoreInformationState();
}

class ContainerMoreInformationState extends State<ContainerMoreInformation> {

  GlobalKey _expandKey = GlobalKey();
  late double _expandOffset;

  bool? _isExpand = false;

  late _Bloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = _Bloc(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      RenderBox box = _expandKey.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      _expandOffset = position.dy - AppSizes.maxPadding - 20.0;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }

  Widget _buildExpand(){
    return StreamBuilder(
        stream: _bloc.outputExpanded,
        initialData: _isExpand,
        builder: (_, snapshot){
          _isExpand = snapshot.data as bool?;
          return CustomComboBox(
            key: _expandKey,
            title: AppLocalizations.text(LangKey.more_information),
            backgroundColor: Colors.transparent,
            expand: snapshot.data as bool?,
            onChanged: (event) {
              _bloc.setExpanded(event);
              if(event){
                Future.delayed(Duration(
                    milliseconds: (AppAnimation.duration.inMilliseconds * 1.5).toInt()))
                    .then((value) => widget.controller.animateTo(
                    _expandOffset,
                    duration: AppAnimation.duration,
                    curve: Curves.easeIn
                ));
              }
            },
            child: Column(
              children: [
                CustomLine(),
                CustomListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorPadding: AppSizes.maxPadding,
                  children: widget.moreChildren ?? [],
                )
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      controller: widget.controller,
      padding: EdgeInsets.zero,
      children: [
        CustomListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(
              left: AppSizes.maxPadding,
              right: AppSizes.maxPadding,
              top: AppSizes.maxPadding),
          separatorPadding: AppSizes.maxPadding,
          children: widget.children ?? [],
        ),
        _buildExpand()
      ],
      onRefresh: widget.onRefresh,
    );
  }
}

class _Bloc extends BaseBloc {

  _Bloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamExpanded.close();
    super.dispose();
  }

  final _streamExpanded = BehaviorSubject<bool?>();
  ValueStream<bool?> get outputExpanded => _streamExpanded.stream;
  setExpanded(bool event) => set(_streamExpanded, event);
}