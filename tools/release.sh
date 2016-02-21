#!/usr/bin/env bash

mkdir tmp

cp -r src tmp
cp -r demo tmp
mkdir tmp/snippets
cp test/unit/spec/snippets/*.js tmp/snippets
cp test/unit/meta.js tmp

git checkout gh-pages

cp -r tmp/src ./
cp -r tmp/demo ./
cp -r tmp/snippets test/unit/spec
cp tmp/meta.js test/unit

rm -rf tmp