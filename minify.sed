# preload the hold space with something innocuous
# (this depends on the first line of the .sty file being a comment)
1 {
  s/.*/\\relax/
  h
  D
}

/^ *%/d
/^ *$/d

# A non-indented line.
# Emit the line we've previously built up
/^[^ ]/ {
  # remove trailing percents from pattern space
  s/% *$//
  x
  s/\n//g
  s/\(.*\)/"\1" write$ newline$/
}
# a continuation line
/^ / {
  s/^ *//
  # Any lines which end with a CS, add a trailing space
  # (helps bibtex output line-breaking not go mad)
  s/\(\\[a-z@]*\) *$/\1 /
  # remove trailing percent characters, with _no_ trailing space
  s/% *$//
  # Append to the hold space
  H
  # ...and discard this line
  d
}
