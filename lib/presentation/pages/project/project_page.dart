import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_personal_website/domain/entities/project/project.dart';
import 'package:flutter_personal_website/presentation/controllers/project_controller.dart';
import 'package:flutter_personal_website/utils/constant.dart';
import 'package:flutter_personal_website/utils/state_enum.dart';
import 'package:flutter_personal_website/utils/url_launch.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

part 'parts/fetch_languages.dart';
part 'parts/build_projects_card.dart';
part 'parts/build_projects_content.dart';

class ProjectPage extends StatelessWidget {
  ProjectPage({super.key});

  final ProjectController projectController = Get.find<ProjectController>();

  @override
  Widget build(BuildContext context) {
    if (projectController.projects.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        projectController.getProjects();
      });
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Obx(() => buildProjectsContent(context, projectController))],
      ),
    );
  }
}
