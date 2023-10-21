/*
 * This file is part of wger Workout Manager <https://github.com/wger-project>.
 * Copyright (C) 2020, 2021 wger Team
 *
 * wger Workout Manager is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * wger Workout Manager is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wger/models/routines/routine.dart';
import 'package:wger/screens/form_screen.dart';
import 'package:wger/screens/routine_screen.dart';
import 'package:wger/widgets/routines/day.dart';
import 'package:wger/widgets/routines/forms.dart';

class RoutineDetail extends StatefulWidget {
  final Routine _routine;
  final Function _changeMode;

  const RoutineDetail(this._routine, this._changeMode);

  @override
  _RoutineDetailState createState() => _RoutineDetailState();
}

class _RoutineDetailState extends State<RoutineDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget._routine.days.isNotEmpty)
          ToggleButtons(
            renderBorder: false,
            onPressed: (int index) {
              if (index == 1) {
                widget._changeMode(RoutineScreenMode.log);
              }
            },
            isSelected: const [true, false],
            children: const <Widget>[
              Icon(Icons.table_chart_outlined),
              Icon(Icons.show_chart),
            ],
          ),
        if (widget._routine.description != '')
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(widget._routine.description),
          ),
        ...widget._routine.days.map((workoutDay) => RoutineDayWidget(workoutDay)).toList(),
        Column(
          children: [
            ElevatedButton(
              child: Text(AppLocalizations.of(context).newDay),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  FormScreen.routeName,
                  arguments: FormScreenArguments(
                    AppLocalizations.of(context).newDay,
                    DayFormWidget(widget._routine),
                    hasListView: true,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
