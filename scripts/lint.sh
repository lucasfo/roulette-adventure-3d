#! /bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR
source ../.venv/bin/activate

LIST_FILES=$(find .. | grep .gd$  | grep -v -E 'addons|.godot|.venv|test_')
cp main.gdlintrc .gdlintrc
echo "Script files"
gdlint $LIST_FILES

# Test files
LIST_FILES=$(find .. | grep test_.*.gd$  | grep -v -E 'addons|.godot|.venv')
echo "Test files"
cp test.gdlintrc .gdlintrc
gdlint $LIST_FILES

# Clean up
rm .gdlintrc
