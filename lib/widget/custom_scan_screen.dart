part of widget;

class CustomScreenScan extends StatefulWidget {

  final Function(String?)? qrCodeCallback;
  final bool enableInput;
  final String? title;

  CustomScreenScan({
    this.qrCodeCallback,
    this.enableInput = false,
    this.title,
  });

  @override
  CustomScreenScanState createState() => CustomScreenScanState();
}

class CustomScreenScanState extends State<CustomScreenScan> {
  
  final double _inputSize = 60.0;
  static final double _sizeScan = AppSizes.maxWidth! * 0.7;

  final FocusNode _focusCode = FocusNode();
  final TextEditingController _controllerCode = TextEditingController();

  bool _isShowInput = false;

  late CustomQRBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = CustomQRBloc(context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _bloc.setCamera(await CustomPermissionRequest.request(context, PermissionRequestType.CAMERA));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    _focusCode.dispose();
    _controllerCode.dispose();
    super.dispose();
  }

  _showInput() async {
    _isShowInput = true;
    await CustomNavigator.showCustomBottomDialog(context, CustomBottomSheet(
      title: AppLocalizations.text(LangKey.enter_information),
      isBottomSheet: false,
      body: CustomListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          CustomTextField(
            focusNode: _focusCode,
            controller: _controllerCode,
            hintText: AppLocalizations.text(LangKey.enter_information_here),
          ),
          CustomButton(
            text: AppLocalizations.text(LangKey.confirm),
            onTap: (){
              if(_controllerCode.text.isEmpty){
                CustomNavigator.showCustomAlertDialog(
                    context,
                    AppLocalizations.text(LangKey.notification),
                    AppLocalizations.text(LangKey.not_enter_information)
                );
                return;
              }
              widget.qrCodeCallback!(_controllerCode.text);
            },
          )
        ],
      ),
    ));
    _isShowInput = false;
  }

  Widget _buildBody(){
    return SingleChildScrollView(
      padding: EdgeInsets.all(0.0),
      child: Container(
        color: Colors.black,
        height: AppSizes.maxHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            StreamBuilder(
              stream: _bloc.outputCamera,
              initialData: false,
              builder: (_, snapshot){
                if(snapshot.data as bool){
                  return MobileScanner(
                    onDetect: (barcode){
                      if(!_isShowInput){
                        widget.qrCodeCallback!(barcode.barcodes.first.rawValue);
                      }
                    },
                  );
                }
                return Container(color: Colors.black,);
              }
            ),
            Container(
              decoration: ShapeDecoration(
                  shape: QrScannerOverlayShape(
                      cutOutSize: _sizeScan,
                      borderWidth: 10.0,
                      borderRadius: 10.0,
                      borderColor: AppColors.primaryColor
                  )
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: ScanAnimation(_sizeScan),
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.all(AppSizes.maxPadding),
                          child: Text(
                            widget.title ?? AppLocalizations.text(LangKey.place_barcode_in_the_scan_area)!,
                            style: AppTextStyles.style14WhiteBold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: _sizeScan,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(widget.enableInput)
                              ...[
                                Padding(
                                  padding: EdgeInsets.all(AppSizes.maxPadding),
                                  child: Row(
                                    children: [
                                      Expanded(child: CustomLine(),),
                                      SizedBox(width: AppSizes.maxPadding,),
                                      Text(
                                        AppLocalizations.text(LangKey.or)!.toLowerCase(),
                                        style: AppTextStyles.style14WhiteNormal,
                                      ),
                                      SizedBox(width: AppSizes.maxPadding,),
                                      Expanded(child: CustomLine(),),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  child: Container(
                                    width: _inputSize,
                                    height: _inputSize,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: AppColors.whiteColor
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(AppSizes.minPadding),
                                      child: CustomImageIcon(
                                        icon: Assets.iconTask,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                  ),
                                  onTap: _showInput,
                                ),
                                SizedBox(height: AppSizes.maxPadding,),
                                Text(
                                  AppLocalizations.text(LangKey.enter_information)!,
                                  style: AppTextStyles.style14WhiteBold,
                                  textAlign: TextAlign.center,
                                ),
                              ]
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: AppSizes.statusBarHeight,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: AppSizes.minPadding),
                    child: InkWell(
                      onTap: () => CustomNavigator.pop(context),
                      child: Container(
                        width: AppSizes.sizeOnTap,
                        height: AppSizes.sizeOnTap,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: AppSizes.iconSize,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isBottomSheet: true,
      body: _buildBody(),
    );
  }
}

class CustomQRBloc extends BaseBloc {

  CustomQRBloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamCamera.close();
    super.dispose();
  }

  final _streamCamera = BehaviorSubject<bool?>();
  ValueStream<bool?> get outputCamera => _streamCamera.stream;
  setCamera(bool event) => set(_streamCamera, event);
}