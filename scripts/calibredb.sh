#!/bin/bash

#LIBRARY="/media/fa1t/calibre/library"
LIBRARY="http://localhost:8180/#library"
USER="xiaoyvr"
PASSWORD="asdfjkl;"

# xvfb-run calibredb $@ --with-library $LIBRARY --username $USER --password $PASSWORD
calibredb $@ --with-library $LIBRARY --username $USER --password $PASSWORD
