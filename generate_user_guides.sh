#!/bin/bash
set -v

mkdir -p docs/user_guides/rust/
mkdir -p docs/user_guides/bevy_plugin/
mkdir -p docs/user_guides/javascript/

# NOTE: injecting all code here is suboptimal because we're copying it 3 times
#       and parsing all those multiple times. Ideally we would inject the code at the last step.
find docs/user_guides/templates/ -type f -print0 | OUTPUT_FOLDER=docs/user_guides/templates_injected/ xargs -0 ./inject_code_in_user_guides.sh

cp -r docs/user_guides/templates/* docs/user_guides/rust/.
cp -r docs/user_guides/templates/* docs/user_guides/bevy_plugin/.
cp -r docs/user_guides/templates/* docs/user_guides/javascript/.

find docs/user_guides/bevy_plugin/ -type f -print0 | xargs -0 gawk -i inplace -v RS='<rapier>[^<]*</rapier>' -v ORS= '1'
find docs/user_guides/bevy_plugin/ -type f -print0 | xargs -0 sed -i '/<rapier>/,/<\/rapier>/d'
find docs/user_guides/bevy_plugin/ -type f -print0 | xargs -0 gawk -i inplace -v RS='<js>[^<]*</js>' -v ORS= '1'
find docs/user_guides/bevy_plugin/ -type f -print0 | xargs -0 sed -i '/<js>/,/<\/js>/d'
find docs/user_guides/bevy_plugin/ -type f -print0 | xargs -0 sed -i 's\<bevy>\\g'
find docs/user_guides/bevy_plugin/ -type f -print0 | xargs -0 sed -i 's\</bevy>\\g'
find docs/user_guides/bevy_plugin/ -type f -print0 | xargs -0 sed -i 's\<notjs>\\g'
find docs/user_guides/bevy_plugin/ -type f -print0 | xargs -0 sed -i 's\</notjs>\\g'

find docs/user_guides/rust/ -type f -print0 | xargs -0 gawk -i inplace -v RS='<bevy>[^<]*</bevy>' -v ORS= '1'
find docs/user_guides/rust/ -type f -print0 | xargs -0 sed -i '/<bevy>/,/<\/bevy>/d'
find docs/user_guides/rust/ -type f -print0 | xargs -0 gawk -i inplace -v RS='<js>[^<]*</js>' -v ORS= '1'
find docs/user_guides/rust/ -type f -print0 | xargs -0 sed -i '/<js>/,/<\/js>/d'
find docs/user_guides/rust/ -type f -print0 | xargs -0 sed -i 's\<rapier>\\g'
find docs/user_guides/rust/ -type f -print0 | xargs -0 sed -i 's\</rapier>\\g'
find docs/user_guides/rust/ -type f -print0 | xargs -0 sed -i 's\<notjs>\\g'
find docs/user_guides/rust/ -type f -print0 | xargs -0 sed -i 's\</notjs>\\g'

find docs/user_guides/javascript/ -type f -print0 | xargs -0 gawk -i inplace -v RS='<rapier>[^<]*</rapier>' -v ORS= '1'
find docs/user_guides/javascript/ -type f -print0 | xargs -0 sed -i '/<rapier>/,/<\/rapier>/d'
find docs/user_guides/javascript/ -type f -print0 | xargs -0 gawk -i inplace -v RS='<bevy>[^<]*</bevy>' -v ORS= '1'
find docs/user_guides/javascript/ -type f -print0 | xargs -0 sed -i '/<bevy>/,/<\/bevy>/d'
find docs/user_guides/javascript/ -type f -print0 | xargs -0 gawk -i inplace -v RS='<notjs>[^<]*</notjs>' -v ORS= '1'
find docs/user_guides/javascript/ -type f -print0 | xargs -0 sed -i '/<notjs>/,/<\/notjs>/d'
find docs/user_guides/javascript/ -type f -print0 | xargs -0 sed -i 's\<js>\\g'
find docs/user_guides/javascript/ -type f -print0 | xargs -0 sed -i 's\</js>\\g'
