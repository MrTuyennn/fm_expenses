rm -f lib/src/*.gen.dart
dart run vector_graphics_compiler --input-dir pre_processing_svgs/ --out-dir svgs
for f in svgs/*.svg.vec; do mv "$f" "${f%.svg.vec}.vec"; done
dart run build_runner build -d