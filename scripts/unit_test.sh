# /bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

# Variables
ORIGDIR=$PWD/../game # Godot original project folder (Linux)
GAMEDIR=$PWD/../.test # Godot parsed project folder (Linux)
GAMEGDIR=res:/ # Godot project folder (Godot Path)

TESTPATH=main # Path to test directory
TESTDIR=$GAMEDIR/$TESTPATH
TESTGDIR=$GAMEGDIR/$TESTPATH

# Copy all .gd files to a temporary test dir
#rm -rf $GAMEDIR/
rsync -az --include='*/' --include='*.gd' --include='*.uid' --exclude='*' $ORIGDIR/ $GAMEDIR/
cp $ORIGDIR/project.godot $GAMEDIR
cp -r $ORIGDIR/autoload $GAMEDIR
cp -r $ORIGDIR/extra_scenes $GAMEDIR # Due to initial scene be here
cp -r $ORIGDIR/addons/gut $GAMEDIR/addons

# Remove Static typing
find $TESTDIR -name '*.gd' -type f -exec sed -i 's/var \(.*\)\:.*[.*\].*=/var \1 =/g; s/var \(.*\)\:.*=/var \1 =/g; s/func \(.*\)->.*:/func \1:/g' {} \;
# ; s/:.*,/,/g; s/:.*)/)/g
# Reimport assets
#godot --headless --quiet --path $GAMEDIR --editor --quit

# Defines a function to create a "gut" command
gut () {
    godot --debug --headless --path $GAMEDIR -s $GAMEDIR/addons/gut/gut_cmdln.gd  $@
}

# Get test files and change the linux path by godot path
FILES=$(find $TESTDIR | grep "/test_.*\.gd$" | sed -e "s|$GAMEDIR|$GAMEGDIR|g")

# Transform list of files (\n) in a list separated by comma
LIST=""
for f in $FILES; do
    LIST="$LIST$f,"
done
LIST=$(echo $LIST | sed -e 's/.$//g') # Remove trailing comma

# Really executes the test
gut -gtest=$LIST -glog=1 -gexit
