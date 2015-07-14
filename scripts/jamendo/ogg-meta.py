#! /usr/bin/env python2
##
# Python script to read OGG Metadata
#
# Part of experiments in trying to automaticlly sort music
# collections by metadata.
##

import sys
import codecs
import argparse
from mutagen.oggvorbis import OggVorbis

def deref(tags):
    return dict([(tag[0], tag[1][0]) for tag in tags.items()])

if __name__ == "__main__":
    # python + unicode = sad pigeon x.x
    out = codecs.getwriter("utf8")
    sys.stdout = out(sys.stdout)

    # build the arugment parser
    parser = argparse.ArgumentParser(description="Read ogg metadata.")
    parser.add_argument("filename", help="the filename of the ogg to read")
    parser.add_argument("--data", help="name of the tag to read")
    parser.add_argument("--all", action="store_true")
    parser.add_argument("--format", help="string to format")

    #parse the arguments
    args = parser.parse_args()
    tags = OggVorbis(args.filename)

    # did the user want one tag?
    if args.data:
        print(tags[args.data][0])

    # data the user want everything?
    if args.all:
        items = deref(tags)
        for (tag, value) in items.iteritems():
            print(tag, value)

    # did the user want a formatted string?
    if args.format:
        items = deref(tags)
        base = unicode(args.format, "utf-8")
        base = unicode.format(base, **items)
        print(base)
