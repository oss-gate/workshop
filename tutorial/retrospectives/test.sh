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
    elif ls ${workshop}/${type}?*.yaml >/dev/null 2>&1; then
      echo "Do not delete ${workshop}/${type}.yaml"
      result=1
    fi
    if ls ${workshop}/${type}_*.yaml >/dev/null 2>&1; then
      echo "Filename must be ${workshop}/${type}-\${USER}.yaml instead of ${workshop}/${type}_\${USER}.yaml"
      result=1
    fi
  done
done
exit ${result}
