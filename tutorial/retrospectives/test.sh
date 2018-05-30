#!/bin/sh
today=`date +%Y-%m-%d`
result=0
cd tutorial/retrospectives
for workshop in `find . -type d -name "${today}*"`; do
  for type in beginner supporter developer; do
    if [ -f ${workshop}/${type}.yaml ]; then
      ./aggregate.rb ${workshop} ${type} >/dev/null
		if [ ! $? = '0' ]; then
			result=1
		fi
    fi
  done
done
exit ${result}
