// Made with flutterflow, lines 195 to 228 as api connections were edited manually in this file and 415 to 419
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/volunteering_log_row_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'my_work_model.dart';
export 'my_work_model.dart';

class MyWorkWidget extends StatefulWidget {
  const MyWorkWidget({super.key});

  static String routeName = 'MyWork';
  static String routePath = '/myWork';

  @override
  State<MyWorkWidget> createState() => _MyWorkWidgetState();
}

class _MyWorkWidgetState extends State<MyWorkWidget> {
  late MyWorkModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyWorkModel());

    _model.documentWorkFieldTextController ??= TextEditingController();
    _model.documentWorkFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<VolunteeringLogsRecord>>(
      stream: queryVolunteeringLogsRecord(
        queryBuilder: (volunteeringLogsRecord) => volunteeringLogsRecord
            .where(
              'uid',
              isEqualTo: currentUserReference,
            )
            .orderBy('date', descending: true),
        limit: 20,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFFCCFFCC),
                  ),
                ),
              ),
            ),
          );
        }
        List<VolunteeringLogsRecord> myWorkVolunteeringLogsRecordList =
            snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FlutterFlowIconButton(
                        borderRadius: 8,
                        buttonSize: 50,
                        fillColor: Colors.transparent,
                        icon: Icon(
                          Icons.logout,
                          color: Color(0x7F008000),
                          size: 36,
                        ),
                        onPressed: () async {
                          GoRouter.of(context).prepareAuthEvent();
                          await authManager.signOut();
                          GoRouter.of(context).clearRedirectLocation();

                          context.goNamedAuth(
                              LoginSignupWidget.routeName, context.mounted);
                        },
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.75,
                    height: MediaQuery.sizeOf(context).height * 0.12,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/SevaiLogo.png',
                        width: 200,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: MediaQuery.sizeOf(context).height * 0.8,
                          decoration: BoxDecoration(
                            color: Color(0xFFE6FFE6),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x33000000),
                                offset: Offset(
                                  0,
                                  2,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: AlignmentDirectional(0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional(0, -0.87),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 25, 0, 25),
                                        child: Container(
                                          width: 300,
                                          child: TextFormField(
                                            controller: _model
                                                .documentWorkFieldTextController,
                                            focusNode: _model
                                                .documentWorkFieldFocusNode,
                                            onFieldSubmitted: (_) async {
                                              _model.apiResult9cg =
                                                  await NodeNLPCall.call(
                                                sentence: _model
                                                    .documentWorkFieldTextController
                                                    .text,
                                              );

                                              if ((_model.apiResult9cg
                                                      ?.succeeded ??
                                                  true)) {
                                                await VolunteeringLogsRecord
                                                    .collection
                                                    .doc()
                                                    .set(
                                                        createVolunteeringLogsRecordData(
                                                      startTime: getJsonField(
                                                        (_model.apiResult9cg
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$['Start Time']''',
                                                      ).toString(),
                                                      endTime: getJsonField(
                                                        (_model.apiResult9cg
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$['End Time']''',
                                                      ).toString(),
                                                      duration: getJsonField(
                                                        (_model.apiResult9cg
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.Duration''',
                                                      ).toString(),
                                                      place: getJsonField(
                                                        (_model.apiResult9cg
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.Locations''',
                                                      ).toString(),
                                                      notes: getJsonField(
                                                        (_model.apiResult9cg
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.Activities''',
                                                      ).toString(),
                                                      uid: currentUserReference,
                                                      date: getCurrentTimestamp,
                                                    ));
                                              } else {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          'This feature isn\'t available right now.'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('OK'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }

                                              safeSetState(() {});
                                            },
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font:
                                                        GoogleFonts.inriaSerif(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: Color(0xFF00B300),
                                                    fontSize: 16,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              hintText: 'Document your work...',
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            Color(0xFF00B300),
                                                        fontSize: 16,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF009900),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF008000),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              filled: true,
                                              fillColor: Color(0xFFCCFFCC),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inriaSerif(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                            cursorColor: Color(0xFF00B300),
                                            validator: _model
                                                .documentWorkFieldTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 25),
                                      child: FlutterFlowIconButton(
                                        borderRadius: 24,
                                        buttonSize: 50,
                                        fillColor: Color(0xFF008000),
                                        icon: Icon(
                                          Icons.add,
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          size: 30,
                                        ),
                                        onPressed: () async {
                                          await VolunteeringLogsRecord
                                              .collection
                                              .doc()
                                              .set(
                                                  createVolunteeringLogsRecordData(
                                                date:
                                                    dateTimeFromSecondsSinceEpoch(
                                                        getCurrentTimestamp
                                                            .secondsSinceEpoch),
                                                startTime: '',
                                                endTime: '',
                                                duration: '',
                                                place: '',
                                                notes: '',
                                                expanded: false,
                                                uid: currentUserReference,
                                              ));
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: SingleChildScrollView(
                                        primary: false,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 5),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final fetchedDocuments =
                                                          myWorkVolunteeringLogsRecordList
                                                              .toList();

                                                      return ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            fetchedDocuments
                                                                .length,
                                                        itemBuilder: (context,
                                                            fetchedDocumentsIndex) {
                                                          final fetchedDocumentsItem =
                                                              fetchedDocuments[
                                                                  fetchedDocumentsIndex];
                                                          return Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10,
                                                                        30,
                                                                        10,
                                                                        30),
                                                            child:
                                                                AnimatedContainer(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      100),
                                                              curve:
                                                                  Curves.easeIn,
                                                              width: 90,
                                                              height: 256,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child:
                                                                  wrapWithModel(
                                                                model: _model
                                                                    .volunteeringLogRowModels
                                                                    .getModel(
                                                                  fetchedDocumentsItem
                                                                      .reference
                                                                      .id,
                                                                  fetchedDocumentsIndex,
                                                                ),
                                                                updateCallback: () =>
                                                                    safeSetState(
                                                                        () {}),
                                                                child:
                                                                    VolunteeringLogRowWidget(
                                                                  key: Key(
                                                                    'Keyfld_${fetchedDocumentsItem.reference.id}',
                                                                  ),
                                                                  startTime:
                                                                      fetchedDocumentsItem
                                                                          .startTime,
                                                                  endTime:
                                                                      fetchedDocumentsItem
                                                                          .endTime,
                                                                  duration:
                                                                      fetchedDocumentsItem
                                                                          .duration,
                                                                  place:
                                                                      fetchedDocumentsItem
                                                                          .place,
                                                                  notes:
                                                                      fetchedDocumentsItem
                                                                          .notes,
                                                                  expanded:
                                                                      false,
                                                                  logDate:
                                                                      fetchedDocumentsItem
                                                                          .date!,
                                                                  ref: fetchedDocumentsItem
                                                                      .reference,
                                                                  userUid:
                                                                      currentUserReference!,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

