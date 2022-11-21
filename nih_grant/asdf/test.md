---
format: pdf
keep-md: true
keep-tex: true
keep-yaml: true
editor: source
# number-sections: true
execute: 
  echo: false
  warning: false
geometry: margin=.5in #nothing in margin
mainfont: Arial # NIH should be >=11pt, Arial, Georgia, Helvetica, or Palatino Linotype
fontsize: 11pt
# linestretch: 1.5
indent: true
subparagraph: true
# pagenumbering: 
# install latex-environment with: quarto install extension quarto-ext/latex-environment
filters:
  - latex-environment
environments: [wrapfigure]
# commands: [wrapfigx]
header-includes:
  - \usepackage{wrapfig}    #to be able to wrap text around figures
  - \usepackage{graphicx}
bibliography: references.bib
csl: nature.csl
---


::: {.cell}

:::

::: {.cell}

:::


## Quarto

Quarto enables you to weave together content and executable code into a finished document. To learn more about Quarto see <https://quarto.org>.

## Running Code

When you click the **Render** button a document will be generated that includes both content and the output of embedded code. You can embed code like this:


::: {.cell}
::: {.cell-output .cell-output-stdout}
```
[1] 2
```
:::
:::


You can add options to executable code like this


::: {.cell}
::: {.cell-output .cell-output-stdout}
```
[1] 4
```
:::
:::


The `echo: false` option disables the printing of code (only output is displayed).

Donec, finibus netus maecenas sed cras sit in, quis in vestibulum, et in. Maecenas, ac aenean. Parturient purus maecenas, duis non risus et dictumst laoreet volutpat, dolor quis. Egestas ante maecenas lacus amet et fames a. Tincidunt velit sed sagittis efficitur nisl lobortis tellus, amet vitae. Ex sapien ut augue erat lorem turpis orci parturient bibendum vehicula mi in sed eget. Rutrum tellus nulla aliquet vel dapibus sit, massa dui.


::: {.cell wrapfigure='["R","4in"]'}

\includegraphics{test_files/figure-pdf/unnamed-chunk-5-1} 
:::
