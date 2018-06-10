#!/bin/sh
today=${1:-$(date +%Y-%m-%d)}
result=0
cd "$(dirname "$0")"
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
