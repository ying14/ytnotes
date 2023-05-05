#! /usr/bin/env python3
# -*- coding: utf-8 -*-
"""Pandoc filter to allow variable wrapping of LaTeX/pdf documents
through the wrapfig package.

Simply add a " {?}" tag to the end of the caption for the figure, where
? is an integer specifying the width of the wrap in inches. 0 will cause
the width of the figure to be used. Optionally precede ? with a
character in the set {l,r,i,o} to set wrapfig's placement parameter; the
default is 'l'. Optionally follow ? with a '-' and another width
specification to set wrapfig's overhang parameter and push the figure
that far into the margin.

"""

from pandocfilters import toJSONFilter, Image, RawInline, stringify
import re, sys

import logging
logging.basicConfig(filename='log_filename.txt', level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s',filemode="w")




FLAG_PAT = re.compile(
    '.*\{(\w?)(\d+\.?\d?(cm|in|pt)?)-?((\d+\.?\d?(cm|in|pt))?)?\,*(\d*)\}')
# (\w?)                          placement
# (\d+\.?\d?(cm|in|pt)?)         width
# -?((\d+\.?\d?(cm|in|pt))?)?    overhang


def wrapfig(key, val, fmt, meta):
    logging.debug(f'key={key}; val={val}')
    if key == 'Image':          # key can be Image, Div, Para, etc.
        attrs, caption, target = val
        if FLAG_PAT.match(stringify(caption)):
            # Strip tag
            where = FLAG_PAT.match(caption[-1]['c']).group(1)       # l, r, i, o
            overhang = FLAG_PAT.match(caption[-1]['c']).group(4)    # 0.5in, 1cm, 2pt, etc.
            overhang = overhang if not overhang else '[%s]' % overhang
            size = FLAG_PAT.match(caption[-1]['c']).group(2)        # 0.5in, 1cm, 2pt, etc.
            lines = FLAG_PAT.match(caption[-1]['c']).group(7)       # 0, 1, 2, etc.
            stripped_caption = caption[:-2]                         # remove the tag
            # logging.debug(f'where={where}; overhang={overhang}; size={size}; lines={lines}; stripped_caption={stripped_caption}')
            if fmt == 'latex':
                if where == 'm':  # produce a marginfigure
                    latex_begin = r'\begin{marginfigure}'
                    latex_end = r'}\end{marginfigure}'
                    if len(stripped_caption) > 0:
                        latex_fig = r'\includegraphics{' + target[0] \
                                    + '}\caption{'
                        return [RawInline(fmt, latex_begin + latex_fig)] \
                                + stripped_caption + [RawInline(fmt, latex_end)]
                    else:
                        latex_fig = r'\includegraphics{' + target[0] \
                                    + '}'
                        return [RawInline(fmt, latex_begin + latex_fig)] \
                                + [RawInline(fmt, latex_end)]
                else:  # produce a wrapfigure
                    if len(lines) > 0:
                        latex_begin = r'\begin{wrapfigure}[' + lines \
                            + ']{%s}%s{' % (where, overhang) + size + '}'
                    else:
                        latex_begin = \
                            r'\begin{wrapfigure}{%s}%s{' % (where, overhang) \
                            + size + '}'
                    if len(stripped_caption) > 0:
                        latex_fig = r'\centering\includegraphics{' + target[0] \
                                    + '}\caption{'
                        latex_end = r'}\end{wrapfigure}'
                        return [RawInline(fmt, latex_begin + latex_fig)] \
                                + stripped_caption + [RawInline(fmt, latex_end)]
                    else:
                        latex_fig = r'\centering\includegraphics{' + target[0] \
                                    + '}'
                        latex_end = r'\end{wrapfigure}'
                        return [RawInline(fmt, latex_begin + latex_fig)] \
                                + [RawInline(fmt, latex_end)]
            else:
                return Image(attrs, stripped_caption, target)
        

if __name__ == '__main__':
    toJSONFilter(wrapfig)
    sys.stdout.flush() # Should fix issue #1 (pipe error)
