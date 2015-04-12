#!/bin/bash

function myfun()
{
  echo $f
	./gradepop.rb production.sqlite3 $f
}

for f in grades/*; do
  myfun
done
