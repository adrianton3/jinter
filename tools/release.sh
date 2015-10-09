#!/usr/bin/env bash

mkdir tmp

cp -r src tmp
cp -r demo tmp
cp test/spec/Snippets.js tmp

git checkout gh-pages

cp -r tmp/src ./
cp -r tmp/demo ./
cp tmp/Snippets.js test/spec

rm -rf tmp