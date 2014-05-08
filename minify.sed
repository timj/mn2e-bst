# preload the hold space with something innocuous
# (this depends on the first line of the .sty file being a comment)
1 {
  s/.*/\\relax/
  h
  D
}

/^ *%/d
/^ *$/d

/^[^ ]/ {
  # remove trailing percents from pattern space
  s/% *$//
  x
  s/\n//g
  s/\(.*\)/"\1" write$ newline$/
}
/^ / {
  s/^ *//
  s/% *$//
  # Append to the hold space
  H
  # ...and discard this line
  D
}
