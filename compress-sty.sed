# Compress the input .sty file into single lines, for inclusion into mn2e.bst.
# This isn't a general solution, and it depends on, for example,
# the input file ending with '\endinput', which is discardable. 

# Output sed-spottable marker at beginning of file
1i\
%%%+

# Get rid of blank lines, and lines containing only comments
/^ *\(%.*\)*$/d

# Remove trailing comments
s/% *$//

# Add continuation lines (indented from left) to the hold space
/^ / {
  H
  d
}
# Non continuation lines (not indented):
# print out the hold space in a form which can be included in a .bbl file
/^[^ ]/ {
  x
  s/\n *//g
  s/\(.*\)/"\1" write$ newline$/
}
# This ends up not printing out the last line, but that's OK,
# since that line is just '\endinput'

# Marker at end.
$a\
%%%-
