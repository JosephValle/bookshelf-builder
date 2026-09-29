import 'package:bookshelf_builder/features/planner/domain/models/assembly_diagram.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/assembly_diagram_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/services/assembly_guide_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/services/cut_layout_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/services/piece_ids.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  const dg = AssemblyDiagramBuilder();
  final plan = planFor();
  final ids = PieceIds(plan);

  Set<String> labels(AssemblyDiagram d) => {
    for (final s in d.shapes)
      if (s.label.isNotEmpty) s.label,
  };

  group('AssemblyDiagramBuilder', () {
    test('the cleat pair shows both halves apart and hooked', () {
      final d = dg.cleatPair(plan);
      expect(d.shapes.length, 4);
      expect(labels(d), {
        ids.id('Wall French cleat'),
        ids.id('Unit French cleat'),
      });
      expect(d.pieces.map((p) => p.label), [
        ids.id('Wall French cleat'),
        ids.id('Unit French cleat'),
      ]);
    });

    test('column marks give the first gap and the spacing after it', () {
      final d = dg.columnMarks(plan, left: true);
      expect(d.dimensions.map((e) => e.text), ['9 9/16"', '10 1/4"']);
      expect(labels(d), containsAll([ids.id('Outer column panel', 0)]));
    });

    test('a column shelf picture names the shelf and its height', () {
      final d = dg.columnShelf(plan, left: true, k: 2);
      expect(labels(d), contains(ids.id('Left column shelf', 2)));
      expect(labels(d), contains(ids.id('Left column shelf', 0)));
      expect(labels(d), isNot(contains(ids.id('Left column shelf', 4))));
      expect(d.dimensions.single.text, '30 1/16"');
      expect(d.arrows.length, 1);
      expect(d.marks.length, 1);
    });

    test('the right column uses the right column pieces', () {
      final d = dg.columnShelf(plan, left: false, k: 0);
      expect(labels(d), contains(ids.id('Right column shelf', 0)));
      expect(labels(d), contains(ids.id('Outer column panel', 1)));
    });

    test('screw placement shows three screws on a deep panel', () {
      final d = dg.shelfScrews(
        plan,
        panelId: 'B1',
        bandId: 'D1',
        bandName: 'shelf',
      );
      expect(d.marks.length, 3);
      expect(d.dimensions.map((e) => e.text), ['1"', '1"', '3/8"']);
      expect(d.caption, contains('B1'));
      expect(d.caption, contains('D1'));
    });

    test('screw placement shows two screws on a shallow panel', () {
      final shallow = planFor(const Inputs(depth: 8));
      final d = dg.shelfScrews(
        shallow,
        panelId: 'B1',
        bandId: 'D1',
        bandName: 'shelf',
      );
      expect(d.marks.length, 2);
      expect(d.caption, isNot(contains('one in the middle')));
    });

    test('a column divider is placed by its distance from the panel', () {
      final p = planFor(const Inputs(left: 40));
      final d = dg.columnDivider(p, left: true, opening: 1, index: 0);
      expect(d.dimensions.single.text, contains('"'));
      expect(d.marks.length, 2);
    });

    test('the inner panel picture has a screw per shelf', () {
      final d = dg.columnInner(plan, left: true);
      expect(d.marks.length, plan.leftCol.shelves);
    });

    test('the square check gives the diagonal', () {
      final d = dg.squareCheck(plan, w: 14, h: 71.0625, what: 'the column');
      expect(d.caption, contains('72'));
      expect(d.shapes.length, 3);
    });

    test('bar marks give the first divider position', () {
      final d = dg.barMarks(plan, top: true);
      expect(
        d.dimensions.first.text,
        formatterFor(dg.dividerPos(plan, top: true, m: 1)),
      );
    });

    test('the notch picture shows the notch size', () {
      final d = dg.barNotch(plan, top: true);
      expect(d.dimensions.map((e) => e.text), ['3/4"', '3 1/2"']);
      expect(dg.barNotch(plan, top: false).shapes.single.points.length, 6);
    });

    test('a bar divider has three screws and a position', () {
      final d = dg.barDivider(plan, top: true, k: 0);
      expect(d.marks.length, 3);
      expect(labels(d), contains(ids.id('Top bar divider')));
    });

    test('the skin picture has three screws per divider', () {
      final d = dg.barSkin(plan, top: false);
      expect(d.marks.length, plan.bottomBar.dividers * 3);
    });

    test('the cleat section is mirrored for the bottom bar', () {
      final top = dg.barCleat(plan, top: true);
      final bottom = dg.barCleat(plan, top: false);
      expect(labels(top), contains(ids.id('Top bar anchor cleat')));
      expect(
        top.shapes.last.points.first.y,
        isNot(bottom.shapes.last.points.first.y),
      );
    });

    test('a bar shelf picture puts the shelf in its bay', () {
      final p = planFor(const Inputs(top: 20));
      final d = dg.barShelf(p, top: true, k: 1);
      expect(labels(d), contains(PieceIds(p).id('Top bar shelf', 1)));
    });

    test('each ring stage adds one assembly', () {
      final counts = [
        for (var s = 0; s < 4; s++) dg.ringStage(plan, stage: s).shapes.length,
      ];
      expect(counts, [1, 3, 4, 5]);
    });

    test('ring column screws are three per column panel', () {
      final d = dg.ringColumn(plan, left: true, top: true);
      expect(d.marks.length, 6);
      expect(d.dimensions.map((e) => e.text), contains('13 5/16"'));
    });

    test('the right column is measured from the right end', () {
      final d = dg.ringColumn(plan, left: false, top: false);
      expect(d.marks.length, 6);
      expect(d.dimensions.last.text, '13 5/16"');
    });

    test('the bar end picture names the inner panel and the skin', () {
      final d = dg.barEnd(plan, left: true, top: true);
      expect(d.caption, contains(ids.id('Inner column panel', 0)));
      expect(d.caption, contains(ids.id('Head panel')));
      expect(d.pieces.length, 4);
    });

    test('the toe kick picture has one screw and the fastener count', () {
      final d = dg.toeKick(plan);
      expect(d.marks.length, 1);
      expect(d.pieces.any((p) => p.qty == (plan.ringW / 8).ceil()), isTrue);
    });

    test('back panels show only the ones fixed so far', () {
      expect(dg.backs(plan, current: 0).shapes.length, 2);
      expect(dg.backs(plan, current: 3).shapes.length, 5);
    });

    test('nail placement gives the inset and the spacing', () {
      final d = dg.nails(plan, backId: 'J1');
      expect(d.dimensions.map((e) => e.text), ['3/8"', '6"']);
      expect(d.marks.every((m) => m.kind.name == 'nail'), isTrue);
    });

    test('the unit cleat picture names the piece being fixed', () {
      final d = dg.unitCleat(plan, current: 2);
      final base = ids.id('Unit French cleat');
      expect(labels(d), containsAll(['${base}a', '${base}b', '${base}c']));
      expect(labels(d), isNot(contains('${base}d')));
    });

    test('unit cleat screws are 1 inch from the ends and 6 apart', () {
      final d = dg.cleatScrews(plan, wall: false, piece: 0);
      expect(d.marks.length, 3);
      expect(d.dimensions.map((e) => e.text), ['1"', '1"', '6" or less']);
    });

    test('wall cleat screws are two per stud', () {
      final d = dg.cleatScrews(plan, wall: true, piece: 0);
      expect(d.marks.length, 4);
      expect(d.dimensions.map((e) => e.text), ['1"', '1"', '16"']);
    });

    test('the mount picture shows the 3/4 inch gap', () {
      final d = dg.mount(plan);
      expect(d.dimensions.single.text, '3/4"');
      expect(labels(d), containsAll(['wall', 'unit']));
    });
  });

  group('every picture in the guide', () {
    final variants = <String, Inputs>{
      'default': const Inputs(),
      'wide columns': const Inputs(left: 40, right: 40),
      'tall bars': const Inputs(top: 20, bottom: 20),
      'edge band': const Inputs(edgeStiffener: true),
      'off the floor': const Inputs(onFloor: false),
      'few shelves': const Inputs(targetClearH: 45),
      'no shelves': const Inputs(targetClearH: 80),
      'shallow': const Inputs(depth: 8),
      'concrete wall': const Inputs(concreteWall: true),
      'home': Inputs.home,
    };

    for (final e in variants.entries) {
      test('${e.key} stays inside its canvas and has no empty text', () {
        final Plan p = planFor(e.value);
        for (final step in const AssemblyGuideBuilder().build(p)) {
          for (final d in step.diagrams) {
            expect(d.caption, isNotEmpty, reason: step.title);
            expect(d.shapes, isNotEmpty, reason: step.title);
            final pts = [
              for (final s in d.shapes) ...s.points,
              for (final m in d.marks) m.at,
              for (final a in d.arrows) ...[a.from, a.to],
              for (final x in d.dimensions) ...[x.from, x.to],
              for (final l in d.labels) l.at,
            ];
            for (final pt in pts) {
              expect(
                pt.x,
                inInclusiveRange(-1, d.width + 1),
                reason: '${step.title}: x=${pt.x} of ${d.width}',
              );
              expect(
                pt.y,
                inInclusiveRange(-1, d.height + 1),
                reason: '${step.title}: y=${pt.y} of ${d.height}',
              );
            }
            for (final piece in d.pieces) {
              expect(piece.name, isNotEmpty, reason: step.title);
            }
            expect(d.caption.contains('—'), isFalse);
          }
        }
      });
    }
  });

  group('finished states', () {
    test('the elevation labels every panel with its id', () {
      final d = dg.elevation(plan, caption: 'c');
      expect(d.labels.length, plan.geometry.panels.length);
      expect(d.large, isTrue);
      expect(d.width, plan.ringW);
      expect(d.height, plan.ringH);
    });

    test('every id in the elevation is a real, distinct piece', () {
      final p = planFor(const Inputs(left: 30, top: 20, bottom: 20));
      final d = dg.elevation(p, caption: 'c');
      final known = {for (final part in p.parts) ...part.ids};
      final seen = d.labels.map((l) => l.text).toList();
      expect(seen.toSet().length, seen.length);
      for (final id in seen) {
        expect(known, contains(id));
      }
    });

    test('the elevation puts shelf ids where the guide puts the shelves', () {
      final d = dg.elevation(plan, caption: 'c');
      final texts = d.labels.map((l) => l.text).toSet();
      for (final id in ids.ids('Left column shelf')) {
        expect(texts, contains(id));
      }
      for (final id in ids.ids('Right column shelf')) {
        expect(texts, contains(id));
      }
    });

    test('the elevation labels the toe kick and the window', () {
      final d = dg.elevation(plan, caption: 'c');
      expect(labels(d), containsAll(['window', ids.id('Toe kick')]));
      final off = dg.elevation(
        planFor(const Inputs(onFloor: false)),
        caption: 'c',
      );
      expect(labels(off), isNot(contains('F1')));
    });

    test('a finished column shows every shelf and both panels', () {
      final d = dg.columnDone(plan, left: true);
      expect(labels(d).length, plan.leftCol.shelves + 2);
      expect(d.caption, contains('finished left column'));
    });

    test('a finished bar shows both skins and its dividers', () {
      final d = dg.barDone(plan, top: true);
      expect(
        labels(d),
        containsAll([ids.id('Top panel'), ids.id('Head panel')]),
      );
      expect(labels(d), contains(ids.id('Top bar divider')));
      expect(d.shapes.length, 2 + plan.topBar.dividers);
    });
  });

  group('elevation label placement', () {
    for (final e in {
      'default': const Inputs(),
      'home layout': Inputs.home,
      'tall bars': const Inputs(top: 20, bottom: 20),
      'wide columns': const Inputs(left: 30, right: 30),
    }.entries) {
      test('${e.key}: no two labels sit on top of each other', () {
        final d = dg.elevation(planFor(e.value), caption: 'c');
        // A label is about 2 in wide and 1.2 in tall at page size.
        for (var a = 0; a < d.labels.length; a++) {
          for (var b = a + 1; b < d.labels.length; b++) {
            final la = d.labels[a];
            final lb = d.labels[b];
            final overlap =
                (la.at.x - lb.at.x).abs() < 2 &&
                (la.at.y - lb.at.y).abs() < 1.2;
            expect(
              overlap,
              isFalse,
              reason: '${la.text} and ${lb.text} overlap',
            );
          }
        }
      });
    }

    test('a shelf is named at its left end, not over a divider', () {
      final p = planFor(Inputs.home);
      final d = dg.elevation(p, caption: 'c');
      final shelf = p.geometry.panelNames.indexOf('Right column shelf');
      final box = p.geometry.panels[shelf];
      final label = d.labels[shelf];
      expect(label.at.x, closeTo(box.x + 2.4, 1e-9));
      expect(label.at.y, lessThan(box.y));
    });

    test('a divider is named at its top end, right of it', () {
      final p = planFor(Inputs.home);
      final d = dg.elevation(p, caption: 'c');
      final k = p.geometry.panelNames.indexOf('Left column divider');
      final box = p.geometry.panels[k];
      final label = d.labels[k];
      expect(label.at.x, greaterThan(box.x + box.w));
      expect(label.at.y, greaterThan(box.y));
      expect(label.at.y, lessThan(box.y + 3));
    });
  });

  group('concrete wall pictures', () {
    final concrete = planFor(const Inputs(concreteWall: true));

    test('screws go in pairs 1.5 inches from the ends and 12 apart', () {
      final d = dg.cleatScrews(concrete, wall: true, piece: 0);
      expect(d.marks.length, 4);
      expect(d.dimensions.map((e) => e.text), [
        '1 1/2"',
        '1 1/2"',
        '12" or less',
        '1"',
        '1"',
      ]);
      expect(d.caption, contains('concrete wall'));
      expect(d.pieces.last.name, contains('concrete screws'));
    });

    test('there are no studs in the concrete picture', () {
      final d = dg.cleatScrews(concrete, wall: true, piece: 0);
      expect(d.shapes.length, 1);
    });
  });
}

String formatterFor(double v) {
  // Bar positions are shown with the same 1/16 formatting as the guide.
  return const AssemblyGuideBuilder().formatter.format(v);

  group('cutting layout pictures', () {
    final p = planFor();
    final sheets = const CutLayoutBuilder().build(
      parts: p.parts,
      depthPanel: p.depthPanel,
    );
    final first = sheets.first;
    final d = dg.cutSheet(first, of: 3);

    test('is drawn at page size, to the 96 by 48 inch sheet', () {
      expect(d.large, isTrue);
      expect(d.shapes.first.points[2].x, 96);
      expect(d.shapes.first.points[2].y, 48);
    });

    test('has the sheet outline and one shape per piece', () {
      expect(d.shapes.length, first.pieces.length + 1);
      expect(labels(d), first.pieces.map((e) => e.id).toSet());
    });

    test('pieces are at their layout position and size', () {
      final piece = first.pieces.first;
      final shape = d.shapes[1];
      expect(shape.points.first.x, piece.x);
      expect(shape.points.first.y, piece.y);
      expect(shape.points[2].x, piece.x + piece.length);
      expect(shape.points[2].y, piece.y + piece.width);
    });

    test('writes each strip width beside the sheet and the 96 inch length', () {
      final texts = d.dimensions.map((e) => e.text).toList();
      expect(texts.where((t) => t == '11 1/16"').length, 4);
      expect(texts, contains('96"'));
    });

    test('writes the length on pieces big enough to hold it', () {
      final inside = d.dimensions.where((e) => e.from.x < 96 && e.text != '96"');
      expect(inside, isNotEmpty);
      for (final m in inside) {
        expect(m.light, isTrue, reason: 'panels are dark');
      }
    });

    test('a tiny piece gets no length of its own', () {
      final narrow = sheets
          .expand((s) => s.pieces)
          .where((e) => e.width < 5)
          .length;
      expect(narrow, greaterThan(0));
      final all = sheets.map((s) => dg.cutSheet(s, of: 3));
      final lengths = all.expand((x) => x.dimensions).length;
      final pieces = sheets.expand((s) => s.pieces).length;
      expect(lengths, lessThan(pieces + sheets.length * 6));
    });

    test('back sheets use the lighter back tone and dark measurements', () {
      final back = sheets.last;
      expect(back.material, PartMaterial.ply14);
      final bd = dg.cutSheet(back, of: 1);
      expect(bd.caption, contains('1/4" sheet 1 of 1'));
      expect(
        bd.dimensions.where((e) => e.from.x < 96 && e.text != '96"').every(
          (e) => !e.light,
        ),
        isTrue,
      );
    });
  });
}
