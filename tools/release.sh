#!/usr/bin/env bash

mkdir tmp

cp -r src tmp
cp -r demo tmp
mkdir tmp/snippets
cp test/spec/snippets/*.js tmp/snippets

git checkout gh-pages

cp -r tmp/src ./
cp -r tmp/demo ./
cp tmp/snippets test/spec

rm -rf tmp