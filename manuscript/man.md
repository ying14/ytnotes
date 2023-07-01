---
title: "Ying's Manuscript"
# format: html
format: pdf
# format: native
prefer-html: true
keep-md: true
keep-tex: true
keep-yaml: true
# format:
#   pdf:
#     classoption: [twocolumn, landscape]
#     include-in-header:
#       - packages.tex
#     documentclass: book
#     papersize: letter
#     keep-tex: true # normally erases the intermediate TEX file
# mainfont: Lato
# monofont: Roboto
fontsize: 9pt
geometry: margin=.5in
# geometry:
  # - left=1in
  # - right=1in
  # - textwidth=4.5in
  # - marginparsep=.25in
  # - marginparwidth=.25in
include-in-header:
  text: |
    %%%%%%%%%%% header fonts %%%%%%%%%%%%%%%%%%
    % https://tex.stackexchange.com/questions/40034/giving-headlines-a-background-color-spanning-across-the-entire-typearea
    \newcommand{\mysection}[1]{                  %set H1 font 
      \Large\sf\bf
      \setlength{\fboxsep}{0cm}                  %already boxed
      \colorbox{orange!80}{                      %
          \begin{minipage}{\linewidth}           %
              \vspace*{2pt}                      %Space before
              #1
              \vspace*{2pt}                     %Space after
          \end{minipage}                        
      }}   
    \setkomafont{section}{\mysection}
    %\addtokomafont{subsection}{\colorbox{lightgray}}                    %set H2 font
    \makeatletter
      \setkomafont{subsection}{\color{white}%
        \bfseries\Large
        \begin{tikzpicture}[overlay]
          \draw[fill=blue] (0,-2pt) rectangle
          (\linewidth,16.4pt);
        \end{tikzpicture}}    
    %\newfontfamily\subsubsectionfont{Arial}[Color=Black]    %define H3 font
    %\addtokomafont{subsubsection}{\subsubsectionfont}
    \newfontfamily\paragraphfont{Arial}[Color=2052b0]          %define H4 font
    \addtokomafont{paragraph}{\paragraphfont}
    \addtokomafont{subparagraph}{\colorbox{lightgray}}    %define H5 font
    %%%%%%%%%%% figure/table margins %%%%%%%%%%%%%%%%%%
    \setlength{\intextsep}{0pt}                            %set wrapfig margin above/below
    \setlength{\columnsep}{0pt}                            %set wrapfig margin
    \setlength{\abovecaptionskip}{0pt}                    % spacing above caption, default 10pt
    \setlength{\belowcaptionskip}{0pt}                     % spacing below caption, default 0pt
    %%%%%%%%%%%% caption settings %%%%%%%%%%%%%%%%%%%%%
    % caption size: scriptsize|footnotesize|small|normalsize|large|Large
    \definecolor{captioncolor}{HTML}{37658c}
    %\usepackage[labelfont={bf},font={footnotesize,color=captioncolor},justification=RaggedRight]{caption}  
    \usepackage[labelfont={bf},font={footnotesize,color=captioncolor},justification=raggedright,format=plain]{caption}  
    %%%%%%%%%%%% hyperref settings %%%%%%%%%%%%%%%%%%%%%
    \usepackage[draft]{hyperref}                         % turns off all hyperlinks  
editor: source
# latex-tinytex: false
execute: 
  echo: false
  warning: false
# number-sections: true     #turn this on for section referencing
bibliography: references.bib
csl: nature.csl
fig-cap-location: bottom # this is default
tbl-cap-location: bottom # normally on top
header-includes:
   - \usepackage{lineno}     #line numbers, only works for latex
   - \linenumbers            #line numbers
   - \usepackage{wrapfig}    #to be able to wrap text around figures
   - \usepackage{graphicx}
# fontfamily: libertinus  #font changing (latex only)
# fontfamilyoptions:
#   - osf
#   - p
filters:
  - pandoc-wrapfig-mod.py      # https://github.com/scotthartley/pandoc-wrapfig
#   - spellcheck.lua
# cap-location: top
---


::: {.cell}

:::

::: {.cell}

:::



# Header 1
## Header 2
### Header 3
#### Header 4
##### Header 5
###### Header 6


## Introduction {#sec-introduction}

When you click the **Render** button a document will be generated that includes both content and the output of embedded code. You can embed code like this. The `echo: false` option disables the printing of code (only output is displayed).

Here is a footnote reference,[^1] and another.[^2] You can also reference inline![^3]

[^1]: Here is the footnote.

[^2]: Here's one with multiple blocks. Subsequent paragraphs are indented to show that they belong to the previous footnote.

        { some.code }

[^3]: Hello. I am an inline footnote.

<!-- These footnote definitions can go anywhere make sure there is blank line before/after -->

The whole paragraph can be indented, or just the first line. In this way, multi-paragraph footnotes work like multi-paragraph list items.

Here is a sentence with citation using bibliography. [@cordonnier2009randomized]

The sentence has multiple references. [@adibi2012reduction; @gold2008human; @roach1991ciprofloxacin]

Black-Scholes (@eq-black-scholes) is a mathematical model that seeks to explain the behavior of financial derivatives, most commonly options:

$$
\frac{\partial \mathrm C}{ \partial \mathrm t } + \frac{1}{2}\sigma^{2} \mathrm S^{2}
\frac{\partial^{2} \mathrm C}{\partial \mathrm C^2}
  + \mathrm r \mathrm S \frac{\partial \mathrm C}{\partial \mathrm S}\ =
  \mathrm r \mathrm C 
$$ {#eq-black-scholes}

The box was thrown beside the parked truck. The hogs were fed chopped corn and garbage. Four hours of steady work faced us. Large size in stockings is hard to sell. Check out @sec-introduction for additional content. The boy was there when the sun rose. ![](stamp1a.jpg){height="1em"} A rod is used to catch pink salmon. The source of the huge river is the clear spring. Kick the ball straight and follow through. Help the woman get back to her feet. A pot of tea helps to pass the evening. 




{{< pagebreak >}}





## Bitamp figure

Est, tortor primis ad nullam finibus metus, suscipit. Et quis, non et sed mi nec egestas. Habitasse scelerisque sapien, sit aliquam habitant faucibus. Parturient viverra fames vitae, vulputate sagittis finibus non finibus molestie cubilia id in viverra. Litora et in iaculis volutpat in velit massa euismod. Lacus quam facilisi nullam, pellentesque eu risus, conubia. Cubilia tincidunt bibendum dui bibendum sed. Amet diam, dis scelerisque quam, non tellus. Tincidunt eget a elementum malesuada sit vitae accumsan.
See @fig-stamp1a to see the stamp I'm talking about.

![Single bitmap](stamp1a.jpg){#fig-stamp1a}

Feugiat, nibh cum aenean elementum sem, varius risus. Fusce parturient a sem at bibendum montes in sed lobortis. Elit orci ac, arcu auctor, dapibus et mollis turpis ac. Inceptos justo, turpis ut ultricies interdum. Risus vel accumsan tempus, inceptos, non. Non et ac ornare non varius, auctor sit sociosqu litora. Mattis aptent parturient tempus ligula arcu sapien. At ipsum lorem euismod litora, massa morbi ac habitasse, mauris. Id eu mattis primis quisque hendrerit eget in, nec inceptos tempus. Ex dis magna eu, nec vel, in ridiculus ligula. Nam ut, morbi at amet nullam dolor.


Now look at @fig-combined, and notice how @fig-stamp1b and @fig-stamp1-again differ.

::: {#fig-combined layout-ncol="2"}
![stamp B](stamp1b.jpg){#fig-stamp1b}

![stamp A again](stamp1a.jpg){#fig-stamp1-again}

Combined stamps. Show again are several stamps. @fig-stamp1b shows in blue, and @fig-stamp1-again in red.
:::

Ac ac nunc et sapien. Urna neque, finibus aliquam vulputate. Libero aliquam quam nunc rhoncus platea, accumsan lobortis, ut. Sagittis, sed et amet habitant sed non nulla nisl. Sociosqu nunc amet lorem venenatis eleifend pulvinar libero. Posuere imperdiet suscipit ipsum et porta. Praesent, nostra turpis nam quam sed maximus vehicula sed velit. Facilisis cras ad leo, congue mi non auctor, sed in class rhoncus consectetur. Tempor etiam conubia molestie mattis egestas magna conubia ad lacus, donec vehicula. In libero ut mus feugiat eleifend mi justo.




{{< pagebreak >}}





Aenean, vel odio sit nullam commodo sed. Sociosqu nulla nam primis eu porttitor eros facilisi sollicitudin. Posuere purus vivamus, nec est, class. Ac et congue per eu malesuada luctus. Eu aliquam lorem vitae tincidunt suspendisse neque felis. Sed in odio, malesuada viverra, eros ut odio hendrerit. Est lacus tempor ac. Amet condimentum suspendisse sem mi arcu urna ullamcorper blandit, urna. In penatibus ornare nec, felis lacus. Et, lacinia malesuada, fringilla, senectus sed ipsum eget lectus. Finibus congue non, sit ante donec facilisis. Lacinia et vestibulum velit sed.
See @fig-diamonds.


::: {.cell}
::: {.cell-output-display}
![Plot of Diamonds](man_files/figure-pdf/fig-diamonds-1.pdf){#fig-diamonds width=50%}
:::
:::


Praesent pellentesque, mattis tempus et, a sociis. Lacus platea mauris habitasse, amet magna lobortis est magna amet. Finibus porttitor eu pulvinar platea a ut luctus, feugiat nisl. Sapien magna diam ac litora ullamcorper ipsum taciti. Himenaeos ac donec quis aliquam natoque. Ac tincidunt blandit vestibulum quam laoreet elementum rutrum nam! Vivamus penatibus venenatis, sed, orci consectetur. Consectetur sed sed montes nisl blandit et velit. Quam nisl scelerisque amet bibendum dictum sit erat, potenti. Porttitor iaculis sed, posuere in viverra eu neque euismod congue nec.
See @tbl-mtcars.


::: {#tbl-mtcars .cell tbl-cap='Table of Mtcars'}
::: {.cell-output-display}
\begin{tabular}{l|r|r|r|r|r|r|r|r|r}
\hline
  & mpg & cyl & disp & hp & drat & wt & qsec & vs & am\\
\hline
Mazda RX4 & 21.0 & 6 & 160 & 110 & 3.90 & 2.620 & 16.46 & 0 & 1\\
\hline
Mazda RX4 Wag & 21.0 & 6 & 160 & 110 & 3.90 & 2.875 & 17.02 & 0 & 1\\
\hline
Datsun 710 & 22.8 & 4 & 108 & 93 & 3.85 & 2.320 & 18.61 & 1 & 1\\
\hline
Hornet 4 Drive & 21.4 & 6 & 258 & 110 & 3.08 & 3.215 & 19.44 & 1 & 0\\
\hline
Hornet Sportabout & 18.7 & 8 & 360 & 175 & 3.15 & 3.440 & 17.02 & 0 & 0\\
\hline
Valiant & 18.1 & 6 & 225 & 105 & 2.76 & 3.460 & 20.22 & 1 & 0\\
\hline
Duster 360 & 14.3 & 8 & 360 & 245 & 3.21 & 3.570 & 15.84 & 0 & 0\\
\hline
\end{tabular}
:::
:::


Nisi lectus auctor dui potenti parturient imperdiet adipiscing. Eu, sed, magna a sed. Rutrum ac mus eleifend, eu. Velit mus aliquet ac libero praesent, semper. Integer ultricies eu iaculis ultricies a purus efficitur. Nulla sociis sed, morbi lectus erat nulla tincidunt morbi imperdiet tempor. Taciti nec vestibulum nisl lacus eu aliquam volutpat, vehicula. Nisl vitae. Sit ac justo, amet non eleifend ante, suspendisse porttitor. Mi sapien urna urna volutpat porttitor. Velit fringilla tristique eget eu lectus pellentesque, nunc nunc vitae proin finibus, finibus.




{{< pagebreak >}}





Ullamcorper augue consequat curabitur. Placerat ultrices sapien etiam dolor, porttitor lacus viverra egestas ex. Nascetur montes vestibulum donec egestas nulla. Nibh vestibulum ante himenaeos leo auctor. Sed amet dui! Arcu sed conubia lacus eget sapien, nunc ligula ligula sociosqu torquent taciti. Eu senectus vestibulum nisl nunc. Elementum posuere velit sed sed vestibulum rutrum. Montes non in, feugiat, condimentum nec. Tellus enim maximus tempor interdum posuere, nibh libero. Pretium vel facilisis, sociis ut quam conubia aenean. Quis, in senectus lobortis sit at. Amet congue in eget blandit. Ut erat porttitor, curabitur, nullam malesuada mattis adipiscing vitae vivamus.
See @fig-diamonds2.


::: {.cell layout-align="left"}
::: {.cell-output-display}
![Plot of Diamonds](man_files/figure-pdf/fig-diamonds2-1.pdf){#fig-diamonds2 fig-align='left' fig-pos='t' width=100%}
:::
:::


Amet amet dictum, in, faucibus nunc dolor. Porta fringilla sit eros sit at dictum neque eu blandit auctor volutpat posuere. Ut quis leo egestas non hac taciti, scelerisque a nisl. Diam senectus, ullamcorper et sapien, erat. Venenatis rutrum platea nisi eu nec velit vehicula? Diam augue velit vivamus mauris amet sit parturient diam eu nisi, egestas, taciti fames. Natoque nunc consequat donec quam ligula, proin nisl senectus scelerisque mollis. Enim tristique sed neque quis nibh lobortis platea vel.

Nulla phasellus ex enim sociosqu sollicitudin pulvinar ac. Mauris ut nostra eu hac efficitur orci hac. Aenean sed suspendisse. Sit nascetur varius sed elementum nostra congue. Rutrum at iaculis in libero. Mi mauris, sapien. Finibus orci pellentesque quisque fusce nec. Eget nec aenean cubilia parturient ligula tempor vel mi, ut suspendisse mattis ultricies primis.
See @tbl-mtcars2.


::: {#tbl-mtcars2 .cell tbl-cap='Table of Mtcars'}
::: {.cell-output-display}
\begin{table}
\centering\begingroup\fontsize{7}{9}\selectfont

\begin{tabular}{l|r|r|r|r|r|r|r|r|r}
\hline
  & mpg & cyl & disp & hp & drat & wt & qsec & vs & am\\
\hline
Mazda RX4 & 21.0 & 6 & 160.0 & 110 & 3.90 & 2.620 & 16.46 & 0 & 1\\
\hline
Mazda RX4 Wag & 21.0 & 6 & 160.0 & 110 & 3.90 & 2.875 & 17.02 & 0 & 1\\
\hline
Datsun 710 & 22.8 & 4 & 108.0 & 93 & 3.85 & 2.320 & 18.61 & 1 & 1\\
\hline
Hornet 4 Drive & 21.4 & 6 & 258.0 & 110 & 3.08 & 3.215 & 19.44 & 1 & 0\\
\hline
Hornet Sportabout & 18.7 & 8 & 360.0 & 175 & 3.15 & 3.440 & 17.02 & 0 & 0\\
\hline
Valiant & 18.1 & 6 & 225.0 & 105 & 2.76 & 3.460 & 20.22 & 1 & 0\\
\hline
Duster 360 & 14.3 & 8 & 360.0 & 245 & 3.21 & 3.570 & 15.84 & 0 & 0\\
\hline
Merc 240D & 24.4 & 4 & 146.7 & 62 & 3.69 & 3.190 & 20.00 & 1 & 0\\
\hline
Merc 230 & 22.8 & 4 & 140.8 & 95 & 3.92 & 3.150 & 22.90 & 1 & 0\\
\hline
Merc 280 & 19.2 & 6 & 167.6 & 123 & 3.92 & 3.440 & 18.30 & 1 & 0\\
\hline
\end{tabular}
\endgroup{}
\end{table}
:::
:::


{{< pagebreak >}}





## Wrapfig: bitmap via manual-TEX

<!-- 1. cross-refs have to be done at TEX level -->
<!-- 2. specifying 0 will automatically fit based on the image's size -->

Rutrum turpis lobortis sit nec odio class velit quisque, gravida malesuada bibendum. Ut quis scelerisque iaculis taciti nulla. Aenean sed, nulla etiam augue, vitae, ante posuere mus ullamcorper primis. Ante eros etiam vitae, habitasse. Ultricies enim tellus. Iaculis et conubia est feugiat vitae in. In semper amet arcu nostra imperdiet parturient. Senectus, ante porttitor class viverra quam adipiscing lacinia facilisis. Eget fusce enim quis sed ut, enim vestibulum convallis nec erat. Quisque non et a cum ut cursus mattis. Porta sed nisi sed cras. Commodo congue facilisi donec rutrum.

Et at fusce morbi, sed rutrum semper faucibus finibus inceptos id. Non accumsan cursus orci, sed mus praesent fringilla cubilia. Accumsan sed suscipit et. Sed, sit eu. Ridiculus, mauris, torquent sed. Eros sed porttitor mauris hac dolor tortor nibh, nulla sit sociis libero? Quam non mauris leo amet aliquam. Blandit tempor semper ridiculus ipsum himenaeos phasellus suscipit porttitor. Ut class sociosqu lorem vitae lobortis, sed diam faucibus sed. Fringilla integer hac, ligula nascetur pulvinar ultrices ante nisl in magnis! Et aliquam faucibus nisi, augue, sed penatibus posuere ex laoreet. Volutpat in ligula ipsum aenean nec nec eu, semper egestas.
You can see a wrapped text thing at Figure \ref{fig-wrap}.



```{=tex}
% \begin{wrapfigure}[lineheight]{position}{width}
% \begin{wrapfigure}{0}{0.4\linewidth}{0.5\textwidth}

\begin{wrapfigure}{r}{0.4\textwidth}
  \centering
  \includegraphics[width=0.35\textwidth]{stamp1b.jpg}
  \caption{\label{fig-wrap}caption here. A cup of sugar makes sweet fudge. Place a rosebush near the porch steps.}
  \vspace{-3pt}
\end{wrapfigure}
```


Tristique sodales gravida egestas eleifend. Vel amet mauris integer mauris volutpat potenti. Eros sed ut, quis id, nostra, sed fames amet malesuada. Sit et vel, aptent iaculis magna risus velit nullam tincidunt. Ac turpis amet dui pellentesque urna habitasse magnis, congue placerat donec habitasse maximus sed. Commodo nibh sit purus rutrum leo. Orci leo lorem consequat, magnis ut sed ut parturient nulla urna. Arcu vitae torquent nunc, non, malesuada a nulla neque elementum netus. Nunc, tortor vivamus commodo justo malesuada a nulla ornare magnis. In ante vitae class cras senectus lectus inceptos adipiscing sociosqu amet euismod sed? Condimentum, diam, in et blandit risus et placerat.

Faucibus auctor interdum turpis himenaeos felis sit sed dapibus. Sed vestibulum sed ac amet fermentum vestibulum vestibulum dignissim ac. Odio nunc auctor nunc ac morbi. Nisi bibendum eget ut id in risus vel platea curae etiam. A ipsum velit augue, vitae, magna morbi elit dis, neque. Suscipit velit sapien eget amet, himenaeos. Dis hendrerit nisi nec vitae erat, ipsum pellentesque sed. A sollicitudin, mi fringilla quis. Sed cras, risus nunc. Convallis porta. Ut aliquet adipiscing mattis. Ac magnis varius eget ac purus convallis lectus pharetra mauris mi. Velit ridiculus et duis in, sed amet class.

Nam lobortis pretium a semper rutrum cubilia facilisis vel, convallis pretium. In dapibus quis urna vitae sollicitudin elementum dignissim sed justo arcu nunc sem. Sit dignissim amet class at. Nisl lorem maximus fermentum mauris gravida felis sapien. Torquent nec eu mollis ipsum in vel velit, amet. Blandit mollis aenean, massa congue mattis sed. Dictum maximus, aenean morbi purus torquent ornare ac felis nullam metus, condimentum tempus tempus. Dapibus risus curabitur sit non, parturient ut. Ultricies nec lacus justo sed ultrices ornare purus, libero.
You can see a wrapped text thing at Figure \ref{fig-wrap2}.



```{=tex}
\begin{wrapfigure}{l}{0\textwidth}
  \centering
  \includegraphics[width=0.3\textwidth,height=0.3\textwidth]{stamp1a.jpg}
  \caption{\label{fig-wrap2}caption here. A cup of sugar makes sweet fudge. Place a rosebush near the porch steps.}
  \vspace{-6pt}
\end{wrapfigure}
```


In viverra ligula habitasse vel ornare ac. Netus sem vitae in dui ullamcorper. At, luctus nascetur nisl, ut. Suscipit bibendum et turpis risus eu. Dolor, ipsum sit varius. Primis sociis et! Dui leo diam ullamcorper eget sed taciti. Ut accumsan hac luctus ut vestibulum ac ante nostra in elit vel. Cubilia scelerisque blandit sed vivamus sapien, ac, eget. Molestie volutpat at facilisis faucibus mauris? Ante erat suscipit tortor magna eros, vestibulum. Facilisi a arcu eu montes nam phasellus ut sit in ac. Fames a efficitur odio nunc vitae in augue nam class.

Amet, sollicitudin rhoncus eget mi amet lectus accumsan elit mattis porttitor pharetra molestie. Vel mattis feugiat. Egestas vel augue felis natoque suscipit magnis erat. Ut arcu mi eros eu. Aliquam blandit accumsan aliquam aliquam consectetur maecenas? Sit tempus sed pulvinar amet efficitur. Sociis lacinia ultrices sem senectus laoreet sociis est, non dapibus. Eros lectus nulla sed purus fringilla in in ligula blandit faucibus a sagittis inceptos. Tincidunt, habitasse leo, sed, in ligula, nisi dui enim velit. Cursus quam ante sagittis a pharetra eros in non eleifend. Tempus justo donec torquent sapien sed ipsum, justo sed. Phasellus nostra nec sit sed sollicitudin nam.

In nulla nunc suscipit auctor mattis. Interdum ut ultricies, vitae tempus feugiat. Ligula tincidunt imperdiet, aptent enim quis. Magna turpis torquent cursus egestas phasellus maximus sem quam, malesuada nam. Libero ullamcorper, ex, sed. Metus, justo at, bibendum maecenas non. Id odio mauris aliquam at interdum nunc primis. Euismod ut lorem fames velit et sagittis, magnis mattis. Amet nisl, litora donec et cubilia. In et nec pulvinar, quam sit torquent in hac enim, pellentesque est est tincidunt. Nunc aenean turpis sodales. Nostra fusce nullam arcu in ac eleifend. Ligula donec, fames interdum auctor nisl risus, nulla cubilia.

Placerat urna vitae dictumst, vitae metus, nulla. Sapien nec blandit rutrum lobortis sapien, efficitur ipsum. Laoreet ad ut a, ipsum ut. Fusce pellentesque, lobortis, leo eros sodales. Tellus lacinia in. Aliquam dignissim posuere cursus egestas mattis ac sed elit tempus. Leo orci diam consectetur pretium eu efficitur auctor est. Scelerisque, non fermentum vel dictum dignissim. Leo aliquam aenean ac in mauris parturient. Ultrices eget at aliquam sed sed, eu vestibulum.


















{{< pagebreak >}}





## Wrapfig: bitmap via pandoc-filter

<!-- 1. cross-refs have to be done at TEX level -->
<!-- 2. Unclear how to stretch figure to fit;  -->
<!-- 3. width needs to be expressed in in/cm/pt -->

Lacus in consequat condimentum dolor senectus semper tempus nec nullam quam sed. Sem, eu eros curabitur, sem ut. Sed quis fermentum et tempor. Id ut amet sed vel nunc, efficitur risus duis ut, ex sociosqu. Magnis pellentesque duis pellentesque mauris aenean ac volutpat. Ante nibh et sit mauris curae parturient. Sapien at, eu sed sociosqu neque dis id nec. Conubia aliquam elementum class nisi senectus dolor non. Sed erat, sed congue velit. Euismod eros mauris amet sociosqu. Mauris feugiat himenaeos lectus ut, malesuada dolor et ultricies, senectus. Aliquam cubilia orci pellentesque ipsum urna. Duis lobortis, tincidunt ante vehicula odio ornare amet, proin amet. Eros egestas vulputate eget scelerisque donec urna efficitur vulputate.

Urna quis nec quis sed natoque erat maecenas eleifend senectus elementum tincidunt ut. Auctor montes rhoncus finibus dis nulla neque praesent in in neque massa cubilia, pellentesque ut himenaeos nascetur pellentesque non. Sollicitudin porttitor lobortis eros malesuada vel dolor ligula, commodo. Justo aenean eu sed vitae eleifend ex per. Leo quis quam ac ipsum per quam nunc dictum. Ut, vel nisi massa platea, dignissim odio, viverra. Malesuada nisl, laoreet in quisque sit fringilla. Praesent accumsan class phasellus eros, pellentesque arcu. Quis nunc in senectus egestas. Himenaeos per, bibendum dui eu libero bibendum eu. Litora aliquet pharetra sapien eleifend sed at eleifend sed ac.
You can see a wrapped text thing at Figure \ref{fig-wrap-filter}.
 
![\label{fig-wrap-filter} A cup of sugar makes sweet fudge. Place a rosebush near the porch steps. {r3in}](stamp1b.jpg){#fig-wrap-filter}



Amet, aliquam, lorem augue consequat turpis tristique sit eu velit, at. Feugiat neque accumsan tellus nam sit. Urna dis, ridiculus hendrerit amet viverra id parturient cras, hendrerit, enim. Nec, ut cras lorem a ex fermentum, arcu ut finibus vel, augue magnis. Eu ornare senectus in purus id ex mauris consequat. Non per hendrerit fringilla imperdiet habitant maecenas molestie, cubilia. Feugiat senectus sed dictumst ut erat eu nulla metus massa. At, posuere, elit lobortis sit ante risus. Per nullam dolor dui massa metus luctus ultricies tempor ultrices. Mi dolor, platea in turpis varius. Ligula diam in nascetur est.

Porttitor quam ac aliquam, justo consequat. Ornare, eros habitant mi, diam curae convallis varius luctus. Dictumst dolor, mi dis, lacus tempus sed sed diam lacus aliquet commodo. Facilisi consectetur a vitae vel quis nam. Mi tempor porttitor per class sed elementum eget. In amet lobortis cubilia urna. Velit sociosqu sed enim non litora. Curabitur vivamus bibendum, amet viverra id, in. Odio lorem sodales neque taciti in. Quis, ut dui morbi amet quam tincidunt feugiat. Suspendisse volutpat lacinia amet lacinia, malesuada est facilisis. Amet sed eget, ut sit condimentum laoreet felis amet sem velit at. Varius tellus leo porta posuere tempor amet netus ultricies mauris. Dis cursus vitae amet, magna. Id parturient dis gravida lorem mauris sociosqu amet porta eleifend felis efficitur lorem tincidunt purus.

Turpis nec, pharetra in proin morbi. Tempor in senectus diam natoque efficitur. Non adipiscing, non. In, purus conubia suscipit, at. Magnis enim neque aenean, sed, ipsum ut porta, ex consectetur donec. Class lorem sed augue diam varius. Odio, parturient mauris ultrices. Amet egestas ut taciti fermentum pellentesque leo. Sed eget torquent, dis vulputate sed nostra duis sed. Ultricies ligula aliquam nam at leo proin. Blandit sed varius montes, quis eu conubia ut conubia.
You can see a wrapped text thing at Figure \ref{fig-wrap-filter2}
You can see a wrapped text thing at @fig-wrap-filter2
<!-- Figure \ref{fig-wrap-filter2}. -->

<!-- ::: {#fig-wrap-filter2} -->
<!-- ![](stamp1a.jpg) -->

<!-- A cup of sugar makes sweet fudge. Place a rosebush near the porch steps.{l3in,18} -->
<!-- ::: -->


\begin{wrapfigure}{l}{0\textwidth}
  \centering
  \includegraphics[width=4in,height=0.3\textwidth]{stamp1a.jpg}
  \caption{\label{fig-wrap-filter2}TITLE HERE}
  \vspace{-6pt}
\end{wrapfigure}




<!-- ![\label{fig-wrap-filter2} A cup of sugar makes sweet fudge. Place a rosebush near the porch steps. {l3in,18}](stamp1a.jpg) -->

Nullam nulla sed posuere et lectus? Integer at ac conubia, tristique. Pharetra metus venenatis diam magna venenatis proin quis. Sed libero sed metus ad ad. Ac, nullam, lacinia ac egestas velit ut neque augue turpis nullam libero et libero vel primis. Feugiat vestibulum nulla hac, est id, lacus. Interdum ut fringilla primis ligula lectus facilisis libero, morbi. Congue vel, finibus blandit vulputate duis sed nam felis! Imperdiet integer metus sit, amet montes ut lorem.

Aenean tellus sit potenti, odio nunc quis in, mauris. Mauris augue taciti amet. Maximus, et sed a lectus blandit quis potenti, at nisi. Dapibus nibh, nullam justo gravida vel, cursus, id, congue. Sed aptent, ac mauris, efficitur ante vivamus purus felis nibh nunc metus. Sed molestie sapien ante in eget at maecenas lectus. Sagittis blandit class iaculis pellentesque. Ligula egestas dolor eros ultricies sed inceptos ac amet curabitur in cum. Semper vitae facilisis class justo ipsum ipsum nostra in. Nec a purus vulputate inceptos, fringilla. Tempus et et vel ac nibh hac varius efficitur, ultrices, parturient. At himenaeos quisque orci lobortis duis. Id sed, vestibulum euismod, auctor aliquam, torquent blandit est. Pellentesque sollicitudin placerat nec, eget commodo id sapien. Suscipit sed leo, hendrerit dui. Magna maecenas tortor ac enim. Duis dui nisl libero senectus erat amet habitant. Condimentum, purus nibh ex senectus dis dolor montes. Phasellus eget proin turpis lorem justo donec posuere.

Feugiat luctus eleifend volutpat nam enim euismod, enim ornare sed, sit egestas nullam. Mollis duis lobortis, ornare finibus, potenti neque ac. Ligula vitae fringilla. Quam dolor, litora bibendum nulla per mattis morbi. Accumsan dui auctor mattis varius? Posuere eu vehicula fermentum vestibulum parturient tempor in netus curae purus habitant in, in. Natoque dui, a aenean quis, ut tempus vel consectetur. Quam nec netus amet magna. Egestas ac blandit nec felis sapien.

Et augue nec accumsan etiam venenatis nunc maecenas. In justo, nascetur cras tempor, diam in eu. A orci mauris nibh urna felis quis consectetur. Proin lacus molestie nibh tellus quis auctor. Sapien diam ut. Pulvinar vitae amet lacus, at felis ligula mattis eu sapien dictum lacinia. Turpis turpis, non, dui ac vitae posuere vehicula. Integer nec dictum, ridiculus auctor sed. Tristique suspendisse eu felis faucibus dignissim odio. Aliquet eget tellus et consequat lectus sed, vivamus, amet varius.














{{< pagebreak >}}





## Wrapfig: ggplot-pdf via manual TEX

<!-- 1. cross-refs have to be done at TEX level -->
<!-- 2. play around with pdf size and wrapfig size to get it right -->



::: {.cell}

:::


```{=tex}
\begin{wrapfigure}{r}{0.4\textwidth}
  \centering
  \includegraphics{mtcars.pdf}
  \caption{\label{fig-mtcars-wrapfig-0}Create ggplot pdf, then add as TEX.}
\end{wrapfigure}
```



<!-- \begin{wrapfigure}{l}{0\textwidth} -->

Et turpis, aptent lorem nostra leo est. Eu, nostra finibus amet ac vestibulum. Commodo ex. Primis at ridiculus porta, non pellentesque amet, curabitur facilisis arcu porta. Ornare metus felis turpis magna risus. Ultricies libero eget convallis lacinia aliquam venenatis ut rhoncus duis. Class, sed sed. Vehicula eu, quis sagittis et. Rhoncus montes commodo sed, egestas, pellentesque, ultrices sed.

Quisque velit accumsan, efficitur tristique aliquet ante nisi. Vitae, sociosqu ultricies varius pellentesque in vehicula vehicula. Felis, platea et montes scelerisque ex efficitur ut id, cursus a. Ultrices nisi cursus nisl interdum eros consequat nibh velit in velit luctus lacinia. Taciti erat fames mauris diam, cursus congue eu. Dictumst sit. In nibh nullam eu tristique accumsan, vel lectus.
See Figure \ref{fig-mtcars-wrapfig-0}.

Vitae imperdiet eu, ac nulla, sed volutpat eros mi. Sed auctor porta sociosqu, iaculis nibh, nibh varius, mus tellus, eu. Facilisis litora! Metus neque fames ut proin donec, himenaeos. Primis lacinia nibh sed. Cursus, luctus, phasellus nec dis arcu dui, sed gravida posuere. Lobortis sed commodo. At lacus eros finibus fusce lorem aenean nulla laoreet maximus sollicitudin, dolor. Justo etiam ac, vel fames sem congue mauris. Pharetra non ipsum tristique tempus. Mauris vehicula ac egestas scelerisque magnis eu mus diam.

Erat a ad dis vitae turpis ut, cras sed? Dictumst aliquam quis sed tincidunt iaculis sit. Vulputate tempus nisi accumsan dapibus, vitae, non in eu mi nec varius. Nec amet lobortis per venenatis condimentum vitae, finibus non, quis phasellus ac. Vehicula dui condimentum mi sed. Non blandit libero sem, ut volutpat, platea, pharetra, dapibus consequat. Justo ac ut nec eu primis turpis facilisis torquent, congue adipiscing eros, nisi. Eget felis sit sed porttitor vestibulum placerat ultrices nunc quis. At tempor vivamus. Eu at justo cras metus scelerisque facilisis non tellus. Ridiculus sagittis molestie. Montes vel tempus sed et. Tempus quisque vestibulum ullamcorper natoque ullamcorper vitae aliquam vel eu. Iaculis, nunc condimentum orci ornare sed scelerisque pharetra quis lacinia? Sollicitudin, et torquent nunc tristique mauris ultricies nibh ad habitant vestibulum eget. Posuere id at dis a, ac dui pulvinar convallis placerat fames. Risus maecenas congue, purus.




















{{< pagebreak >}}





## Wrapfig: ggplot2-pdf via pandoc-filter

<!-- 1. cross-refs have to be done at TEX level -->
<!-- 2. play around with pdf size and wrapfig size to get it right -->

![\label{fig-mtcars-wrapfig-1.5} figure here{r3in,18}](mtcars.pdf)

Malesuada semper amet eu vitae in pulvinar. Nec laoreet litora. Ultricies sem porttitor venenatis sollicitudin nec. Nunc habitasse cras porttitor tempor lacus ut sed sagittis a nunc malesuada cras a. Id risus, velit rutrum in arcu congue lorem felis adipiscing sit. Praesent porttitor sodales vitae mauris eget purus justo. Sit ut sed amet nunc gravida ex arcu libero. Sociis in.

Id primis auctor ullamcorper mattis at mollis nibh habitasse lobortis congue nec leo lectus rhoncus turpis egestas ornare. Venenatis justo quis placerat habitasse odio vestibulum habitasse. Lorem, at faucibus sapien eros sed vel eu ad. Ipsum ac odio amet etiam, varius pharetra. Tristique bibendum class eu phasellus ac erat. Nulla, neque eget eget, vivamus in nullam lectus, convallis netus. Vitae fusce et dignissim interdum eu. Eros tempor leo libero et dui donec, nulla tortor.
See Figure \ref{fig-mtcars-wrapfig-1.5}.

Non sed pharetra pellentesque. Iaculis augue, venenatis, eu maximus litora, sit et. Amet facilisis nec litora odio fermentum torquent non ante. Amet ac risus blandit id odio! Finibus laoreet egestas elit at ullamcorper facilisis at. Fringilla nisi pharetra sed morbi, mollis semper posuere augue. Quam ullamcorper, tempor vulputate ut ridiculus leo. Ac consectetur dictumst sed eros, nam, orci. Facilisis nec luctus. Leo, eu non urna quis turpis sit sed volutpat libero nascetur. Et sed, primis nam phasellus odio ex a enim.

Suscipit eget et donec interdum urna in fermentum suspendisse sed, fames tempus lacus. In tempus, ipsum phasellus molestie semper commodo ac, massa. Non sociis sed adipiscing sagittis praesent. Dictum hac pellentesque rutrum lacus in tortor. Vel pretium, ligula a sit dictumst ac tempus ullamcorper, sem. Tellus convallis condimentum urna convallis nam tempor volutpat velit. Fames metus in consectetur mi eleifend class augue. Ullamcorper curae fames, platea placerat aliquam ac ut tempus. Enim quam tristique a nec eleifend lobortis facilisis tincidunt ut, sed. Metus magnis ultricies pellentesque amet nec varius et facilisis. Aliquet, fusce a tortor et sed.


















{{< pagebreak >}}





## Wrapfig: inline-ggplot via wrapf-hook 

<!-- 1. cross-ref and fig-captions don't work! -->

Efficitur hac ligula nullam nunc sed, sed mauris accumsan himenaeos, dictum. Sapien malesuada neque lacinia taciti porta, ultrices molestie maximus. Libero cum quisque hendrerit nec tortor. Auctor consequat risus porta et scelerisque, eget non amet sit volutpat eu consectetur dolor. Dolor gravida vehicula ligula, amet aenean bibendum tristique sed id felis. Turpis mauris sodales euismod etiam ornare neque, tortor vitae aliquam. Sodales ut ullamcorper habitasse id et at netus pellentesque. Augue consectetur montes penatibus parturient potenti. In dis sociosqu quam sed lectus iaculis fusce litora augue.

Nunc dictumst ultrices torquent nascetur augue, sem nisl nec sociis laoreet hendrerit nulla bibendum porttitor turpis. Non etiam sed. Ligula urna tortor quam, luctus ipsum a ante suspendisse nibh convallis mauris consequat. Purus, taciti dignissim ipsum eu. Mi mi ridiculus ut. Et et amet sed. Nisi leo tempor morbi ultrices luctus ipsum. Lobortis tempor ipsum cras in. In dictumst, aliquam eget. Volutpat, ridiculus suscipit dui torquent nulla magna rhoncus ac neque phasellus tristique. Quis posuere euismod, vivamus cum sem pellentesque ut facilisi, ornare.


::: {.cell wrapf='true'}
\begin{wrapfigure}{R}{0.3\textwidth}\includegraphics{man_files/figure-pdf/fig-mtcars-wrapfig-1}

\end{wrapfigure}
:::


Leo arcu sed vel vitae. Faucibus justo, egestas id, erat pellentesque est, turpis nibh. Eget proin amet volutpat hendrerit nec sed magnis. Interdum consequat in integer suscipit erat lacus. Ultrices suspendisse quis egestas massa imperdiet. Maximus quam pellentesque sapien mauris quam vel aenean, ac, neque. Litora nunc taciti mauris eu scelerisque nibh turpis. Mus fringilla leo, erat vivamus lacus. Mauris amet blandit praesent vitae. Mauris eros et iaculis. Ante erat, dui libero pellentesque. Fringilla feugiat sed lectus ante tincidunt tempus nibh pretium ipsum sed urna. Sagittis interdum nisl sodales. Mauris eu aliquet arcu quam et convallis duis vel. Vitae ac nunc id vehicula eu egestas nec.

Per massa mattis litora eget. Ac leo, ligula tempor adipiscing. Hendrerit cursus, in suscipit sed tellus parturient donec sed non. Non dignissim sed adipiscing iaculis! Luctus suspendisse lorem curabitur quam laoreet. Bibendum, nisi quis pulvinar sociis euismod. Et sapien, cubilia malesuada ut sit velit eget turpis. Aliquet pretium libero mollis proin. Litora integer lectus neque nunc ornare arcu semper euismod proin, tincidunt ac lacus tincidunt mi. Aenean sapien montes ante, et dapibus at.

Aptent condimentum platea maximus, mollis sem ex. Adipiscing et, congue dapibus viverra, convallis pretium pulvinar dictum cubilia et dictum? Magnis cras dolor leo class. Conubia interdum venenatis, orci ac suscipit amet penatibus nisi augue. Litora fringilla convallis maximus maximus. Suscipit venenatis pellentesque habitant sed at faucibus at risus consequat egestas lacinia. Aliquam maecenas volutpat eget ridiculus quis eu. Parturient vulputate tincidunt finibus. Malesuada convallis feugiat aliquam, at. Cum ante et nisl sed.

Maximus quis imperdiet ultricies aliquet aenean erat luctus dictumst, enim vestibulum. Quisque sed in pharetra. Diam lectus tempor parturient sem in aenean eleifend, mattis, eu felis quam consectetur, aenean tempor ipsum integer platea. Ac sed morbi varius amet fringilla dictumst. Class sit ac tincidunt ultricies netus velit. Praesent lorem turpis enim nibh, nunc urna sed erat. In nullam sapien sociosqu lacus purus dignissim ut parturient. Ac nascetur parturient ex aptent posuere, non sed nunc in urna. Convallis in blandit nullam ut. Nulla lobortis, quis, duis id sed, torquent. Malesuada quam. Finibus natoque vitae luctus vestibulum quam sed. Pulvinar ut ad sed ridiculus.

Natoque sit auctor vehicula eu dignissim sodales cum eros lectus, enim. Tempor facilisis et ex praesent mi lacinia venenatis sed facilisis venenatis. Interdum natoque, purus ipsum rutrum nec. Vivamus, inceptos ut nunc, in sed. Ipsum potenti, donec interdum. Dictum, auctor ut urna quisque maximus nunc nisl felis, tincidunt nunc. Leo penatibus finibus in lorem sed eu mollis. Habitant vestibulum ad, pellentesque egestas accumsan. Fringilla ullamcorper ipsum interdum at semper commodo metus facilisis.













{{< pagebreak >}}





## Wrapfig: inline-ggplot via wrapfigure-hook

<!-- 1. this isn't working right now -->


::: {.cell wrapfigure='["r",0.3]'}
::: {.cell-output-display}
![](man_files/figure-pdf/unnamed-chunk-10-1.pdf)
:::
:::


{{< pagebreak >}}





## Wrap table

<!-- 1. caption and cross-ref doesn't work -->

Donec augue imperdiet bibendum auctor ut sed. Nunc, ipsum ac nibh dis sed mus suspendisse mattis nunc. Sit, sollicitudin amet ut ut in eu in ipsum. Arcu commodo eros gravida efficitur imperdiet in. At varius ac dolor, ut nunc luctus sociosqu purus non, proin tempus. Ex tellus pharetra tempor montes ut mollis platea. Faucibus nisl, enim purus venenatis parturient auctor natoque suscipit arcu leo nulla in. Arcu egestas sodales hac. Imperdiet, platea in turpis tellus ut mus, class eros. Venenatis suscipit efficitur ad ligula in non scelerisque vivamus leo in. Himenaeos mauris quis lorem tortor eleifend sollicitudin. Curabitur bibendum arcu quisque viverra sit, velit hendrerit ac turpis. Laoreet viverra phasellus auctor rhoncus cum est nisi risus nullam egestas congue pretium. Aliquam laoreet porttitor pellentesque maximus tristique. Egestas quis maximus luctus nunc dictum hendrerit vitae leo.

Enim ad lorem, non pellentesque primis neque malesuada. Rutrum montes turpis at turpis. Nisi ultricies nunc curae sit eu id est aptent. Adipiscing maecenas duis nam morbi in. Egestas faucibus molestie, ut ut. Ut sed interdum nisi nibh mauris magnis metus, blandit. Auctor diam efficitur, urna a vitae sed quis odio imperdiet sagittis fringilla. Habitasse egestas iaculis ligula eget, arcu rhoncus. Feugiat ut, curae pretium, sem.

Metus pulvinar, sed fusce duis nec mauris litora sit, ipsum. Lacinia odio maximus suspendisse eleifend. Lorem quis sed nec ipsum. Lacinia donec justo nulla per morbi condimentum. Egestas arcu duis, sed adipiscing. Egestas sed mauris ipsum massa, at rutrum id per, non. Sed nibh velit, sapien turpis consectetur fringilla sed ipsum nisl. Odio odio dictum arcu, praesent hendrerit. Mollis, odio condimentum turpis magna ligula orci placerat torquent. Mi maximus id elit arcu ac eget proin, praesent, in ac sed. Semper at sollicitudin sed mauris sed mollis a sed nostra dui est sit. Venenatis nibh lacus nulla, penatibus lacinia.
See @kable-float.





::: {.cell}
::: {.cell-output-display}
\begin{wraptable}{r}{0pt}\begingroup\fontsize{7}{9}\selectfont

\begin{tabular}[t]{lrrrrrr}
\toprule
  & mpg & cyl & disp & hp & drat & wt\\
\midrule
\cellcolor{gray!6}{Mazda RX4} & \cellcolor{gray!6}{21.0} & \cellcolor{gray!6}{6} & \cellcolor{gray!6}{160} & \cellcolor{gray!6}{110} & \cellcolor{gray!6}{3.90} & \cellcolor{gray!6}{2.620}\\
Mazda RX4 Wag & 21.0 & 6 & 160 & 110 & 3.90 & 2.875\\
\cellcolor{gray!6}{Datsun 710} & \cellcolor{gray!6}{22.8} & \cellcolor{gray!6}{4} & \cellcolor{gray!6}{108} & \cellcolor{gray!6}{93} & \cellcolor{gray!6}{3.85} & \cellcolor{gray!6}{2.320}\\
Hornet 4 Drive & 21.4 & 6 & 258 & 110 & 3.08 & 3.215\\
\cellcolor{gray!6}{Hornet Sportabout} & \cellcolor{gray!6}{18.7} & \cellcolor{gray!6}{8} & \cellcolor{gray!6}{360} & \cellcolor{gray!6}{175} & \cellcolor{gray!6}{3.15} & \cellcolor{gray!6}{3.440}\\
\bottomrule
\multicolumn{7}{l}{\textsuperscript{a} asdfasdfasdf}\\
\end{tabular}
\endgroup{}\end{wraptable}
:::
:::




Euismod neque imperdiet nisl eleifend, placerat aenean faucibus metus vitae consequat arcu. Turpis in morbi ornare vel suspendisse convallis integer a nec nec aliquam. Accumsan tempus lorem semper suspendisse suspendisse efficitur nulla ad quis dolor mus curae aliquam convallis magna. Cras tortor ac luctus, mollis quisque nibh dui purus imperdiet. Ad dictum sapien feugiat, donec non non in. Diam turpis varius laoreet mauris velit turpis rutrum suspendisse. Sem tristique velit nascetur sed. Dui dignissim primis ipsum orci ut nam posuere mattis risus massa sociis amet cum. Mauris, a maximus elementum sed. Leo ligula ornare tortor aliquam curabitur facilisis sed pulvinar. Maximus lobortis, magna per. Senectus elementum per nisl faucibus euismod nunc.

Dignissim nam ac dictum, curabitur. Vitae pulvinar ipsum fermentum velit malesuada phasellus malesuada. Rutrum nisi adipiscing elementum tristique commodo fusce tempor imperdiet amet. Euismod ac quisque amet aliquam congue velit. Maximus elementum justo est et, per sem himenaeos felis, in potenti? Auctor, placerat libero condimentum donec netus nibh varius rhoncus non sagittis, mattis turpis. Nunc fermentum sodales proin, pretium nec. Sed blandit libero a pellentesque fringilla, feugiat ultrices luctus. Diam at ultrices id accumsan tristique. Placerat in sed sed ultricies congue. Pretium ac ut montes pretium a metus aliquam, sem dictumst ut lorem. Ipsum ligula iaculis scelerisque dictum diam sapien, erat parturient. Aliquam gravida suspendisse erat nunc, vel. Accumsan pretium, dis donec imperdiet, ipsum sed quisque sed donec in ligula. Diam pretium sagittis non posuere vestibulum sed nascetur, fringilla ornare nulla enim senectus.

Consectetur in nunc ligula ornare eu neque scelerisque nullam amet consectetur, senectus gravida luctus. Turpis sit lacus et amet aliquam ut mauris magnis vivamus. Aliquam nullam habitant maecenas aliquam sociosqu eget arcu ut at in ac phasellus facilisis dignissim. Ut, non himenaeos facilisis augue quis sed felis. Ligula vulputate, inceptos facilisis vestibulum viverra facilisis. Et volutpat ipsum, nunc lorem vel. Ridiculus, risus felis in volutpat faucibus turpis finibus. Auctor nunc rhoncus eros interdum a, sed quam dictum vestibulum nec sapien. Aliquam in mus.

Fermentum leo quam justo sed ut et. Donec pellentesque neque erat phasellus tristique. Enim sed et metus, efficitur sed lorem, hendrerit nulla, sed. Neque mollis ac ad et sem tincidunt! Class eget elit dolor nisi, ac. Suscipit, vivamus ultricies sed orci nulla metus. Odio ad, mi sagittis faucibus ut sed, sociosqu interdum sed ut turpis duis massa nulla. Molestie justo magna nec duis. Nunc orci laoreet diam efficitur sed urna. Malesuada eros faucibus, sapien vestibulum vestibulum, hendrerit. Nisi sed parturient faucibus convallis convallis primis porttitor litora penatibus ex urna sem. Sit enim ut, enim at velit ac himenaeos malesuada.


<!-- See Table \ref{tbl-mtsmall}. -->

<!-- ```{=tex} -->
<!-- \begin{wrapfigure}{l}{0.4\linewidth} -->
<!--   \centering -->
<!-- ```{r} -->
<!-- library(xtable) -->
<!-- print(xtable(head(iris[,c(1,2)])), floating = FALSE) -->
<!-- ``` -->
<!--   \caption{\label{tbl-mtsmall}caption here. A cup of sugar makes sweet fudge. Place a rosebush near the porch steps.} -->
<!--   \vspace{-3pt} -->
<!-- \end{wrapfigure} -->
<!-- ``` -->



{{< pagebreak >}}










## Wrap table manual

<!-- 1. caption and cross-ref doesn't work -->




```{=tex}

\begin{wraptable}{r}{5.5cm}
  \caption{A wrapped table going nicely inside the text.}\label{tbl-wrap}
  \begin{tabular}{ccc}\\\toprule  
  Header-1 & Header-1 & Header-1 \\\midrule
  2 &3 & 5\\  \midrule
  2 &3 & 5\\  \midrule
  2 &3 & 5\\  \bottomrule
  \end{tabular}
\end{wraptable} 

```



Ante commodo eget ligula leo ligula elementum ex. Mauris lacus semper enim vestibulum. Habitant finibus turpis primis. Auctor torquent fusce dictum lorem, nec ligula egestas. Nec nullam vitae quis, risus ante maximus arcu cum integer. At auctor, class ligula ac at nec a sed condimentum eu consequat. Ut vel, cubilia nascetur commodo cras tellus in. Magna blandit montes. Eleifend sed porttitor elit ac sed. Netus in mauris faucibus pharetra vitae! Velit habitant dolor amet et proin. Mauris ut interdum mollis sed, penatibus elit nisl.

Turpis tortor quisque sed, finibus nec. Facilisis dictum at tristique facilisis ac ultrices. Massa torquent sociosqu nisi curabitur diam arcu cum taciti neque tempus nisi himenaeos. Consectetur purus, sodales cubilia ullamcorper et, eu etiam sed taciti urna platea! Sem sed mi in, ut justo sit. Orci elit dolor sit blandit a sed. In senectus eros tempor tellus donec arcu sed non eros amet, congue volutpat sit ac! Sodales himenaeos tristique nec facilisi a neque lorem et, in.

Mattis volutpat dolor fusce non duis. Sapien, eu a. Senectus amet, ex magna ut. Litora eu elementum est. Aliquet suscipit sem. Nisl orci proin pellentesque nunc facilisi. Ad ultricies nisi sociosqu lorem duis. Velit feugiat nostra eros posuere, ante sit. Nibh, ligula, lobortis eu, et cum lobortis lectus, sed. Venenatis ligula class pretium vestibulum egestas proin orci. Feugiat tellus, gravida in. A vel, luctus nec amet habitasse scelerisque egestas.
See Table \ref{tbl-wrap}.






{{< pagebreak >}}









## Wrap table 2




\begin{wraptable}[20]{r}{5in}

\caption{\label{tbl-wrap2}here is the table}
\centering
\fontsize{7}{9}\selectfont
\begin{tabular}[t]{lrrrrrr}
\toprule
  & mpg & cyl & disp & hp & drat & wt\\
\midrule
\cellcolor{gray!6}{Mazda RX4} & \cellcolor{gray!6}{21.0} & \cellcolor{gray!6}{6} & \cellcolor{gray!6}{160} & \cellcolor{gray!6}{110} & \cellcolor{gray!6}{3.90} & \cellcolor{gray!6}{2.620}\\
Mazda RX4 Wag & 21.0 & 6 & 160 & 110 & 3.90 & 2.875\\
\cellcolor{gray!6}{Datsun 710} & \cellcolor{gray!6}{22.8} & \cellcolor{gray!6}{4} & \cellcolor{gray!6}{108} & \cellcolor{gray!6}{93} & \cellcolor{gray!6}{3.85} & \cellcolor{gray!6}{2.320}\\
Hornet 4 Drive & 21.4 & 6 & 258 & 110 & 3.08 & 3.215\\
\cellcolor{gray!6}{Hornet Sportabout} & \cellcolor{gray!6}{18.7} & \cellcolor{gray!6}{8} & \cellcolor{gray!6}{360} & \cellcolor{gray!6}{175} & \cellcolor{gray!6}{3.15} & \cellcolor{gray!6}{3.440}\\
\bottomrule
\end{tabular}
\end{wraptable}



Vestibulum lorem dolor inceptos mollis, tincidunt duis nascetur. Tortor eget, dolor tempus placerat gravida ornare eget. Elementum et nunc ligula est duis ut lacus nulla. Ut, justo eu felis rutrum in cursus molestie. Convallis libero suspendisse in, mauris tortor ad dignissim gravida, netus. Augue habitasse class ligula congue non finibus et congue, ac dictum. Amet arcu nec class tincidunt eros at gravida. Nullam scelerisque ornare eu mollis ligula. Vestibulum nascetur urna, pellentesque, vestibulum ligula, eleifend pulvinar. Feugiat, et tortor ridiculus pellentesque nec gravida facilisis! Porttitor egestas sed nunc nisi placerat efficitur himenaeos, lacinia. Dictum pretium luctus, sed, aptent egestas porta ac. In purus, sit quis. Curabitur, purus penatibus sit, netus penatibus cum augue.

Ut efficitur ac. Vel sed amet ultrices ex magna dictum himenaeos, ut, nisl eleifend lectus. At turpis libero vestibulum et a, ac porttitor in. Id fames taciti iaculis nec quisque faucibus ornare ultricies id adipiscing interdum. Gravida aliquam leo, condimentum, venenatis conubia aliquam cras. Metus imperdiet sit fusce sapien sit mauris quis mauris fermentum. Auctor ullamcorper etiam, senectus id ante a mi libero ut. Fusce, vitae lobortis aptent mollis sed tristique nec dui. Sed nec. Nibh posuere curabitur ligula sem dapibus. Ut, sollicitudin sem curabitur magna cum ad et. Porta tincidunt nulla vivamus taciti sed sed.

Sed mauris etiam maecenas risus sed dictumst felis aliquam. Ac iaculis id. In dui lorem risus nullam et sociis platea ullamcorper. Tempor sed ac feugiat magna ultrices bibendum odio in. Euismod congue eros ligula justo semper natoque. Odio vel varius est vel nec est. Sem nisi class mattis arcu morbi, mauris dis, sociis, maximus. In consectetur congue laoreet bibendum eu mauris hendrerit commodo sed dapibus. Et molestie at aliquam curabitur, auctor porttitor ultrices non, sollicitudin. Quam ultricies a aenean eget diam sollicitudin tellus natoque magna, efficitur sodales magna.
See Table \ref{tbl-wrap2}.
<!-- See @tbl-wrap2. -->



{{< pagebreak >}}









<!-- does not work for pdf -->

::: columns
::: {.column width="50%"}
left column
:::

::: {.column width="50%"}
right column
:::
:::

### References

<!-- Bibliography will go here (it this isn't included, it will follow CSL format) -->

::: {#refs}
:::

Acknowledgements: asdf
