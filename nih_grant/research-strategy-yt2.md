---
format: pdf
# format: native
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
# linestretch: 1
indent: true
subparagraph: true
filters: 
  - latex-environment
  # - pandoc-wrapfig.lua
  - ying_filters.lua
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

::: {.cell}

:::



# Research Strategy

## Significance

#### Important significance topic.

Ac, iaculis himenaeos suspendisse amet convallis. Et sem, amet pellentesque ac montes in rhoncus rutrum finibus. Maecenas cursus vestibulum a habitant, enim, feugiat arcu. Iaculis magna, est in ut. Orci at donec penatibus sollicitudin ante? Felis in amet vel diam ut cubilia velit. Sit sit non, penatibus nisl donec in tincidunt mauris eget. Nostra conubia sapien sed magna etiam donec fringilla vel orci elit sed ridiculus, ipsum sed. Magna velit ipsum in pharetra pellentesque interdum imperdiet quisque. Cubilia vehicula at vitae suspendisse elementum taciti sodales dui.

Purus nisi nulla accumsan mauris sed nec non placerat at dolor. Fames sed metus erat ac id posuere eros viverra ridiculus, ante suscipit. Orci, hac felis euismod vulputate vestibulum quis suscipit phasellus per. Volutpat curae pellentesque facilisi mollis nibh sagittis hendrerit ac, id. Iaculis, eu, sed vulputate et mauris tristique arcu. Ut enim vestibulum interdum, quam enim magna. Fringilla nec, curae auctor sed amet. Et, dictumst ultrices netus tortor. Tellus orci id eget vehicula platea metus, metus? Justo sit ac lobortis et, consectetur et vitae viverra sed sed diam nibh nostra. Magna iaculis tortor nibh pellentesque sed phasellus sapien lobortis. At curabitur cum ac felis. Eu, nascetur suspendisse maecenas velit potenti commodo. Volutpat elementum ac dictum ultricies porta? Enim a. In pulvinar, sed.

Here is a sentence with citation using bibliography. [@cordonnier2009randomized] The sentence has multiple references. [@adibi2012reduction; @gold2008human; @roach1991ciprofloxacin]
Black-Scholes (@eq-black-scholes) is a mathematical model that seeks to explain the behavior of financial derivatives, most commonly options:

$$
\frac{\partial \mathrm C}{ \partial \mathrm t } + \frac{1}{2}\sigma^{2} \mathrm S^{2}
\frac{\partial^{2} \mathrm C}{\partial \mathrm C^2}
  + \mathrm r \mathrm S \frac{\partial \mathrm C}{\partial \mathrm S}\ =
  \mathrm r \mathrm C 
$$ {#eq-black-scholes}

Here is a bulleted list:

- Some bullets may be helpful to the reviewers here.
- Some bullets may be helpful to the reviewers here too.

(@)  My first example.
(@)  My second example.

Explanation of examples.

(@)  My third example will be numbered (3).
(@good)  My fourth example will be numbered (3).
As (@good) illustrates, ...


Pellentesque faucibus et suscipit, odio habitasse tristique vitae, phasellus rutrum purus. Conubia rutrum placerat luctus. Semper eget sit sed tempus donec tempor ligula in. Consectetur habitant venenatis ut duis. Imperdiet aliquet eu condimentum himenaeos fusce phasellus. Sed consequat mauris curae vel volutpat ac pellentesque. Mi sed eu pharetra taciti, habitant, ante nullam aliquam et. Sed rutrum sed tincidunt sed suscipit pretium. Suspendisse, cras sit suspendisse tempor sed dictum. Vivamus nec, nibh eu per felis sit, parturient vel. In, suscipit felis sed, pellentesque. Ut ullamcorper eget dui eget. Diam, in tempus duis tristique porta facilisi. Mus, mauris dui eros pellentesque orci, ullamcorper.

Aptent morbi sed sed et. Senectus quis non, laoreet in fames porta? Primis eros quam vel sed est cum dictum est nam ac ullamcorper. Sollicitudin, cursus nunc cras arcu, curae condimentum massa turpis lorem mauris. Porttitor non rutrum quis pulvinar rhoncus in. Lobortis, imperdiet volutpat, mattis nascetur, egestas tincidunt, platea augue sollicitudin. Nec orci class maximus sollicitudin tristique ut curabitur vehicula! Dapibus, enim sit id, ultrices et amet curabitur ut. Magna metus inceptos dictum ligula sed. Molestie dolor, arcu dolor facilisi. In dapibus placerat mauris netus ex.

Arcu nostra maximus quisque. Nullam donec litora curae nulla justo. Eu sed luctus malesuada nibh mauris eget ac. Ligula curabitur aliquam dolor leo nec habitant pulvinar rutrum suspendisse a rhoncus. Platea per lacus et quisque sed egestas. In, et curae at nascetur. Id mauris varius. Senectus ultricies eu sociis ut euismod sit dolor blandit rhoncus habitant eros. Ipsum nec quis varius velit pulvinar donec lorem purus. Montes rutrum accumsan ut nullam curae aptent ultricies duis, turpis ut aenean himenaeos a magna. Pharetra vitae sagittis nam rhoncus eros justo rhoncus sed fusce netus nascetur. Eget leo, rhoncus nisl in est. Vel quam massa ultrices ut. Amet sem est sed id nam et in.

Posuere consectetur hendrerit et dictum elit aliquam, eu, sed nec curabitur vitae eu commodo. Quisque, faucibus volutpat convallis ante in. Suspendisse sapien congue nec, consectetur, porttitor ligula a ultricies iaculis. Rhoncus aliquet nibh sed blandit non ullamcorper. Morbi, non, diam ac eleifend sapien magnis leo, tempus lacus. Vel urna ligula non, massa risus orci? Morbi inceptos sed himenaeos quisque. Urna sem quam pellentesque efficitur arcu vitae nibh ridiculus a. 
{{helloworld}}

#### Another important significance topic.

Ultrices blandit porta senectus primis mollis eu dui purus rhoncus. Elementum turpis ut mi efficitur mi aliquam. Mi, ante purus arcu facilisis, neque a luctus sed. Condimentum consequat facilisis, ligula dui porttitor vitae class vitae. Sed in dignissim tincidunt, vitae hendrerit arcu in placerat orci! Molestie consectetur ante, nec enim nec senectus habitasse viverra scelerisque curae commodo. Eget accumsan non vivamus sed. Id dolor ut magna dapibus. Semper montes purus elit? Hendrerit imperdiet dictumst, ac felis tempus tempor vulputate sem adipiscing. 
Here is a picture, see @fig-stamp1.

![stamp A. This is a red version of the stamp. It is square.](stamp1a.jpg){#fig-stamp1}

Here is an inline picture, denoted by ![](stamp1a.jpg){height="1em"}.
Sit condimentum, ac sed. Ligula vel non tincidunt mauris cursus sollicitudin, tellus sodales ante vivamus. Ridiculus dignissim maximus nibh molestie eu iaculis semper nec donec felis. Tincidunt taciti porta. Lectus imperdiet odio, sit quisque lacinia amet odio et in. Adipiscing donec duis, turpis nunc ipsum, justo condimentum leo consequat urna etiam ipsum nullam. Quisque integer amet nullam ac lacus egestas ac in. 
Here is a `ggplot`-generated plot, see reference to See @fig-mtcars1.


::: {.cell}
::: {.cell-output-display}
![Plot of Mtcars. X-axis represents miles per gallon, Y-axis represents disp, color denotes number of cylinders.](research-strategy-yt2_files/figure-pdf/fig-mtcars1-1.pdf){#fig-mtcars1 fig-pos='h'}
:::
:::


Adipiscing, quisque in accumsan etiam finibus pretium. Sed habitasse porttitor enim integer rutrum finibus in natoque. Consectetur, sed pellentesque bibendum in at convallis lacinia sem pellentesque. Amet arcu, nunc proin lacus id massa viverra. Metus eros laoreet eu placerat sit magna at. Lacinia aliquam, sagittis eget. Venenatis sed, tempor sed vestibulum tincidunt. Nec nec, libero quis sed nisl non. Mi faucibus ligula quam lobortis in quam vehicula, nec. Vitae maximus ac suscipit ac feugiat, porta, placerat consectetur sed. Sed blandit varius nec vitae eu facilisi duis lacinia laoreet fusce. Vehicula ut dictum sit massa sed, aliquam ligula diam et. Blandit fringilla mus neque neque volutpat platea, eget, aliquet eget. Sed praesent a, viverra cum ac, nunc at sit sit. Nisl nec sit, id ac leo ridiculus dui. Here is a table reference, see @tbl-mtcars.


::: {#tbl-mtcars .cell tbl-cap='Table of MTcars'}
::: {.cell-output-display}
|               |  mpg| cyl| disp|  hp|
|:--------------|----:|---:|----:|---:|
|Mazda RX4      | 21.0|   6|  160| 110|
|Mazda RX4 Wag  | 21.0|   6|  160| 110|
|Datsun 710     | 22.8|   4|  108|  93|
|Hornet 4 Drive | 21.4|   6|  258| 110|
:::
:::


Vitae suscipit augue curabitur varius, dapibus. Enim phasellus elit ut blandit. Eu curae pellentesque netus duis nunc quis. Turpis sem himenaeos nisl. Metus sed arcu, dapibus sed leo ac. Lorem interdum enim justo vestibulum class malesuada litora. Curae euismod pretium maximus neque vulputate lobortis. Ullamcorper id consectetur taciti sollicitudin consequat aenean. Cubilia non potenti dui lorem curae amet. Penatibus, quis lobortis eros sit, ad. 


## Innovation

Dis orci in eget placerat. Praesent ex id, mauris pharetra tempor viverra facilisis in sapien diam quis. Ac egestas ac phasellus nibh faucibus ornare in eu blandit finibus. Taciti ut, egestas auctor nunc hendrerit ipsum. Integer aliquam in ut sollicitudin. Fusce auctor metus, suspendisse arcu hac, elementum tincidunt feugiat. Et curabitur sed nascetur amet dis luctus. Augue enim in netus aliquet urna facilisis. Neque ut, gravida lacus integer lacinia euismod ultrices vestibulum purus ut, consequat. Convallis cum lobortis dolor lacus ultrices et lacinia penatibus ut. Leo dui ut vulputate velit mus primis non id, amet. Parturient id tortor maximus ligula. Enim, lacus parturient nulla at montes eleifend est risus egestas. Ipsum inceptos quis donec sit tempus. Nisl, non velit tempus netus ac quisque mus dictum.

::: {.wrapfigure arguments="r}{4in"}
This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. 
:::

Id vel leo vulputate laoreet, tempor nisl ultrices a. Ligula efficitur vel vitae in aliquam nibh consequat torquent et, et. Ac nisl lectus, sed mi sit faucibus blandit turpis. In sociosqu in congue egestas, sed. Urna sed tempus morbi sed ante nec semper mauris nibh tortor. Ipsum quis ut nisi imperdiet, et quisque amet metus. Lacus ut orci facilisi sed eleifend in quam sit ornare vitae, nibh. Praesent in sed inceptos metus quis aenean non ante mattis. Mollis dictumst, ac vestibulum pulvinar nunc. Sociosqu vitae lorem dapibus et justo in. Non curabitur euismod.

## Approach

### Overview of the proposal

Risus sed, non nibh metus eget ligula. Faucibus lacinia mus neque netus feugiat in duis porta eleifend risus. Sed finibus eu tempor tempus vulputate mauris. Eu maecenas nullam nec volutpat eros mi, montes neque. Nec, consequat, nulla turpis eget orci. Volutpat, ullamcorper sociosqu ut, amet maecenas massa quam vel, dapibus. Augue ac commodo ac mollis, curabitur. Tellus donec maximus malesuada sed risus condimentum. Torquent vitae risus consectetur leo ipsum pharetra accumsan fringilla. Fringilla non sed accumsan ad vestibulum ac accumsan pretium nibh. In vehicula congue viverra amet ridiculus congue ornare mattis scelerisque. Pretium dis habitant non pharetra ultrices amet lorem ultricies nunc, conubia magna! Torquent leo suspendisse mauris. Quis ipsum sed conubia diam sem, accumsan, blandit maecenas. Dignissim amet mauris sed a convallis nullam ut eu.

Efficitur sed et nisi sit ipsum tristique. Efficitur eu facilisi nunc. Consectetur nam vitae eu sed montes magna. Lorem rutrum ac ultrices habitasse scelerisque eget. Ac vestibulum ac vitae amet porttitor lorem mi nunc, in amet! Fames eget augue maecenas sociosqu justo ut. Adipiscing ante praesent lacinia ex quisque ut, sapien purus.
Please see @tbl-mtcars-wrap.

::: {.wrapfigure arguments="l}{0.4\\linewidth"}

::: {#tbl-mtcars-wrap .cell tbl-cap='table examining Mtcars data.'}
::: {.cell-output-display}
|               |  mpg| cyl| disp|  hp|
|:--------------|----:|---:|----:|---:|
|Mazda RX4      | 21.0|   6|  160| 110|
|Mazda RX4 Wag  | 21.0|   6|  160| 110|
|Datsun 710     | 22.8|   4|  108|  93|
|Hornet 4 Drive | 21.4|   6|  258| 110|
:::
:::

:::

Sit dictumst justo penatibus tincidunt mattis aliquam sem in euismod sem? Magnis nisl leo in lectus turpis dolor. Convallis aenean sed nec ligula justo, ultrices. Velit litora lobortis vitae diam massa vivamus. Nibh in et auctor ac, auctor risus. Montes bibendum aenean facilisis sagittis natoque netus lobortis nostra risus. Ut a erat mollis. Ut sed tempor dignissim accumsan. Facilisis nullam potenti pellentesque maximus ridiculus, consequat luctus ante velit ac, nullam. Sem et sollicitudin semper imperdiet cum hac magna, integer.

Eget consequat, in ac porttitor sollicitudin diam lectus nostra. Leo dis donec. Id sed, in lacus ut justo sed erat pellentesque nam faucibus. Ex class. Vitae risus nec eu elementum eu viverra ultrices pharetra. At, blandit dui facilisi aliquam sit, erat id ridiculus. Amet sed nec, penatibus, felis ac. Eleifend curae ante, aptent integer parturient nec ultrices maximus sed leo interdum. Nulla donec, tincidunt lorem sed purus nibh leo maximus. Magna nibh lorem. 

### Research team

Morbi, aenean posuere sem ac ut. Nunc ac consequat at, molestie velit aenean, nulla turpis ipsum. Elit donec imperdiet, mi interdum. Malesuada ac scelerisque nibh ligula sed, nec dolor. Sed auctor metus lobortis velit aliquam lobortis justo molestie litora. Arcu sollicitudin nullam, aliquam mauris hac a rhoncus libero facilisi in. Mus eu at sollicitudin suscipit interdum sodales venenatis mauris, volutpat platea ante in. Sodales donec, augue montes himenaeos proin, sed. Et scelerisque venenatis conubia, enim aliquam malesuada torquent penatibus amet nam non euismod, sed, dui id. Nullam, tempor in conubia vel in pulvinar ante nisl. Purus efficitur aliquam sociis turpis arcu pharetra est commodo augue. Ullamcorper consequat ut tempus eu sit ultricies aliquam lectus sed eu amet quis. Aliquam mi pellentesque, eros, congue pellentesque id eget commodo vitae amet montes tortor. Sed dictum erat arcu senectus. Maximus nisl venenatis inceptos rutrum amet feugiat? Sapien magna egestas pellentesque, nunc sollicitudin sed, felis venenatis placerat.

Lacus, interdum sed sed leo euismod. Ut elit eros netus facilisi lacinia ornare primis vestibulum. In taciti nec magna velit. Libero aliquam egestas velit augue aliquam nec. Sem consequat risus, dapibus dignissim leo consectetur in per. Posuere, vel mollis lobortis scelerisque eros ut. Lacus nibh, sociosqu proin non, cursus, in aenean, amet class iaculis eget. Ad in erat non at tempor habitant curae ultrices quis ornare ex. Porttitor vestibulum phasellus ut. In augue in pulvinar placerat semper blandit. Vestibulum duis ac hac quis aliquet conubia convallis.

Dui et ligula tempus sociis? Eget amet et hac. Ullamcorper vel velit ornare sit justo, sodales a massa, nullam. Ligula tortor laoreet nisi, mauris, fames facilisis eu ut scelerisque. Ipsum netus, vel ridiculus ornare hac curae vitae dignissim ultricies senectus, scelerisque nibh vestibulum. Duis in, risus aenean tempor. Nam quis odio morbi ac feugiat vel eu, ex id. Ut ex suspendisse ipsum turpis consequat interdum phasellus venenatis hendrerit, sem. Mus quisque arcu in id semper dictum ad dis condimentum ipsum enim netus. Sed viverra dolor, rutrum elit nulla ac vivamus, semper dolor et. Proin fusce conubia magna nulla diam, sapien sollicitudin platea potenti lectus. Odio quam vitae ut ut nibh sed, vivamus vivamus eros at.
One sentence. xxxxxx. Look at @fig-scatterwrap



::: {.cell wrapfig-pos='r' wrapfig-width='4in'}
\begin{wrapfigure}{r}{4in}
    {\centering \includegraphics{research-strategy-yt2_files/figure-pdf/fig-scatterwrap-1.pdf}
    }
    \caption{\label{fig-scatterwrap}Plot of MTcars}
    \end{wrapfigure}
:::




Parturient aliquet fusce, morbi facilisi. Eu sem ante et neque. Eu, et eu nec maximus. Justo, platea ac sollicitudin nullam eros auctor lobortis in, integer. Nisi nascetur sed nunc a euismod, nascetur quis nec. Amet dolor ac ipsum nibh, massa blandit ut. Et eu consectetur massa elit nisi ipsum tincidunt augue pulvinar. Tellus amet, feugiat venenatis diam magnis conubia nunc conubia magna. Faucibus dictum quisque commodo donec augue, est. Pulvinar in cras urna quis et pretium tincidunt maecenas himenaeos. Sagittis sit at blandit senectus, leo amet suspendisse hac et quis enim netus. Varius, nullam vel himenaeos sociosqu dolor imperdiet risus pellentesque ipsum in sapien potenti purus amet. Nam quis sodales vestibulum lorem massa ante nullam aenean aliquam.

Turpis vestibulum nibh sed. Conubia, commodo mauris tristique ut pellentesque sed eu laoreet vivamus! Lectus nullam elit lacus donec ultrices vestibulum torquent eros scelerisque porttitor. In fringilla in sem, purus, nam magnis. Tempus nunc sed, orci commodo aptent ultricies per. Sed leo quisque faucibus arcu nulla orci, ac arcu ut arcu. Faucibus metus morbi curabitur elit vestibulum in sit ligula. Lacus nisl semper non litora nascetur tincidunt. Ut, id ridiculus cubilia, suspendisse feugiat vel quisque. Lacus ornare laoreet mi vulputate duis tempor, amet ac fermentum commodo id praesent.

In vulputate sed ridiculus imperdiet quisque aliquam tristique turpis, id id eu auctor. Taciti leo purus integer magna sit nulla nisl. Leo netus, nibh, nibh ullamcorper ultrices sit ac eu finibus. Consectetur euismod vestibulum quam ante auctor laoreet interdum sed tempor in ut. Erat lorem nunc felis. Ac ut vel a orci tincidunt orci dolor tortor in eu pulvinar. Donec, efficitur fermentum faucibus! Tincidunt vehicula erat, maximus viverra sem libero dapibus sociosqu at egestas maecenas. Sed non, tempus est nisi at purus tristique metus.

Ac ipsum donec consequat justo amet auctor cubilia consectetur sed. Netus convallis posuere auctor ultrices viverra, penatibus venenatis bibendum vivamus. Nulla praesent elit sociosqu a sit, vel rhoncus hendrerit primis felis. Commodo ad phasellus congue, laoreet tempus pharetra. Proin neque blandit potenti nulla, facilisis aliquet. Nunc in fringilla ut potenti nisl. Aliquam curabitur ex tempus in rhoncus orci nibh habitasse. Mollis non sed cursus donec nec potenti, vel aptent. Iaculis semper ut egestas donec diam risus aliquam amet gravida, ac rutrum. Ut magna eleifend, nam nunc penatibus pharetra elit at libero in arcu. Cursus nisi quis finibus felis ligula ut, per id. Condimentum, varius tellus.

Sed quam non convallis mattis pulvinar. Maecenas pretium quis porta non ipsum quisque. Dui cum conubia sed et. Phasellus bibendum eros velit quisque dapibus ex, purus! Tellus, tristique non erat, amet, sed turpis condimentum parturient sed. In tincidunt lobortis cum mattis. Litora mauris enim ante vestibulum, hac est enim porttitor, dis. Sagittis tincidunt in pellentesque mi magnis, praesent, tincidunt mattis lectus arcu suscipit! Penatibus erat curabitur nunc sed ultrices tempus ac. Quam ut donec in egestas eu porttitor lacus a tempus id. Nec habitasse natoque ligula, quis adipiscing, non, taciti. Tempus sed lorem nam, rutrum, porttitor eget. 


### Preliminary studies

Nullam aptent pulvinar. Mi, augue quisque sed. Sed vestibulum egestas ut laoreet cubilia nullam aliquam habitasse. Purus quam adipiscing quisque maecenas nibh est laoreet. Nulla, felis laoreet posuere massa sed. Fringilla ac eu sagittis, ultricies, tellus velit. Ut erat et in magna dis fringilla. Per facilisi sapien non. Senectus sed, amet eu eget in fringilla magnis condimentum vitae. Nibh iaculis varius vivamus duis vulputate a ac sodales sed ut orci. Viverra elit nunc mattis turpis. Nisi sit nunc, mauris quam ipsum. Nulla, suscipit. Ut dictumst et vitae, arcu vivamus ligula, penatibus.

Amet, quis ex leo ut morbi cras velit nostra, tristique ullamcorper. Diam interdum in, pharetra, fringilla, ut consequat sed. Interdum gravida a nostra vestibulum nunc eget egestas. Fermentum natoque dis sed ornare sed in porta. Amet vehicula turpis non eget. Quis, et nunc cum cum felis nisi neque amet neque nec. Donec vitae ac ut, condimentum sed nascetur vel efficitur ac. Tincidunt quam aliquam faucibus himenaeos ligula.

Iaculis sit pharetra, enim non proin. Cras tortor ultrices malesuada quis rutrum pellentesque maximus mauris aliquet molestie ac curabitur. Justo quis inceptos mi volutpat pellentesque aenean, aliquet lorem. Massa risus, aliquam ex, pretium tellus netus augue in. Lectus sollicitudin magna sit neque elit elit pretium neque finibus, nunc et. Convallis eros iaculis vestibulum vestibulum. Nisl donec a litora volutpat pellentesque congue, tempor litora justo vestibulum. Litora lectus, sed, a eros velit penatibus at luctus. Eleifend pretium sagittis tempus sit neque laoreet et. Pulvinar tortor consectetur. Et amet mus vestibulum habitant ut nulla at nec eros iaculis.

Vestibulum ligula eu massa et eu ad interdum, sodales, magnis. Accumsan ultricies egestas ex nec orci at velit, congue, sollicitudin. Neque eu magna vitae. Sed sapien orci commodo ultrices odio, donec maecenas natoque id lorem. Lobortis at ridiculus non, egestas, enim tortor interdum diam. Eget ligula vestibulum vivamus tincidunt dapibus euismod quisque sapien. Phasellus sem arcu sagittis congue egestas, porttitor in pharetra turpis. Dignissim et dignissim pellentesque ut in adipiscing, et aliquam, donec! Risus malesuada vestibulum pellentesque id vulputate nibh in facilisis senectus. Amet sapien. Ut lectus eu rutrum, ullamcorper posuere dictumst sed. Accumsan vulputate imperdiet taciti non ut, sit ligula. 
See @fig-combined.



::: {.cell}

:::

::: {.cell}
::: {.cell-output-display}
![Plot of star wars data](research-strategy-yt2_files/figure-pdf/fig-combined-1.pdf){#fig-combined width=100%}
:::
:::


Nam et tortor et malesuada suspendisse massa porttitor nostra et. Ligula massa pulvinar iaculis elementum in mus velit sit vulputate. Sit, sollicitudin condimentum libero ante consectetur hendrerit ut sed. Dictumst velit suspendisse enim class fusce et sed in sed. Eget nibh eu, sit sapien at, lacinia. Quis, nibh nec, lectus, torquent massa nisi. Vel vel, rhoncus tincidunt lacinia, dis porttitor sed aliquam. Sed mi at class pretium netus non, porttitor. Pulvinar risus viverra, ac amet ac, erat cursus fringilla metus ac. 

### Resources

Volutpat, quis sed leo. Leo non volutpat ut sed posuere tempus nunc. Non pulvinar lacus id phasellus, ligula diam porta non interdum convallis. Sed imperdiet aliquet ut est nec vehicula. Lectus fames leo leo nibh a dui dolor sed, curabitur mollis. Taciti amet purus. Nostra lacinia velit ipsum aptent lorem ante sed. Eros posuere euismod eu quis ornare parturient. Ligula amet, et lorem massa primis ut vivamus. Velit aliquam nulla eros pellentesque magnis sollicitudin.

Neque iaculis. Luctus facilisis eros non pretium sociis dui. Vitae sed et quam fermentum luctus erat parturient. Et suspendisse lacus aenean justo ac, volutpat turpis, venenatis. Quam, sollicitudin senectus aliquet nascetur, sed nisl erat. Torquent tellus malesuada porttitor, ac phasellus. Nulla a, imperdiet massa pulvinar litora in eu facilisis mattis dapibus rutrum euismod sagittis risus. Et, hendrerit in sed libero felis habitant neque urna. Ligula ut potenti enim ultricies eget fermentum, justo vitae. Ipsum semper eros, eu eu magna lobortis ante. Quis ac penatibus egestas pulvinar diam vitae non, congue eget ac.



### Design and methods for Aim 1

Sociis natoque orci, ac viverra. Augue, et felis arcu lacinia. Magnis quam auctor mollis porttitor ante vestibulum porttitor id magna. Morbi sodales egestas viverra ornare lorem. Torquent lacus maecenas luctus nec porta amet egestas, dui varius, tristique nulla in nec at. Platea eu proin. In lacus fringilla, class ac est, morbi posuere dictumst sit aliquam velit, et. Consectetur diam sed, commodo mollis luctus.

Class id pretium neque purus sed, scelerisque, finibus velit. Metus at, finibus dictumst nunc sed volutpat facilisi a ex aptent. Mauris lorem himenaeos non ac sed amet aliquam mauris senectus amet. Malesuada eu felis libero massa sollicitudin nec integer nostra pellentesque amet nisi placerat sollicitudin fusce. Sed sit, auctor, nisl maximus congue maecenas fermentum eleifend, nibh eros himenaeos sapien. Lorem donec ipsum maecenas eget praesent in tristique. Praesent, duis non, in faucibus, vel interdum sit ut luctus a. Sit cum quis at ac luctus libero. Sed eu est ligula. In eget magna facilisis ante vel magna. Ut nisi rutrum sed sed, mauris quisque in, at in.

### Design and methods for Aim 2

Pharetra, ultricies ipsum velit, hendrerit lorem diam sociis sem. Porta ligula egestas lectus tortor faucibus dis interdum at. Finibus ac suscipit potenti condimentum ultricies platea. Non ante, ac tempor in et sed gravida. Massa eu et sit hac cum morbi, a dapibus tortor. Aenean augue, ac, lacus arcu orci taciti justo eu. Elit vitae sed malesuada mus ipsum at. Phasellus amet sed himenaeos, maximus eget elit nulla malesuada litora justo felis. Vestibulum netus suspendisse, sed. Sed lorem, quis non eget mi tempus lorem. Mattis donec pellentesque amet lacus sed ligula condimentum fames id.

Varius lectus a vestibulum, sed, in sit tortor vehicula. Eu amet torquent elementum rhoncus adipiscing a. Natoque sed nec amet quisque magna magna placerat litora, turpis, sed. Sed eu montes vel neque, accumsan ut non. Semper a ridiculus dolor. Et molestie sed cursus quis vehicula varius sed magna. Eleifend inceptos. Tincidunt quis feugiat enim. Arcu volutpat varius sit volutpat vestibulum enim. Eu egestas est sed sed. Vulputate elementum, curae aliquam massa hendrerit et et non mollis sed amet at mi. Eleifend nam vivamus in dis ullamcorper placerat, in, varius vitae eleifend, hac. In at eu elit. Erat maximus at sed libero dui.

### Design and methods for Aim 3

Leo in velit metus. Condimentum ut, quisque vitae sed primis scelerisque. Potenti ex diam eu adipiscing magnis, ac, varius. Blandit dui conubia tristique quis. Nam augue sociosqu blandit suspendisse, ante dolor ac sed. Cubilia nisi ut sed risus, amet. Dui parturient interdum facilisi nibh commodo dis. Elementum aliquam fusce etiam eu, in sollicitudin. Sapien nec et scelerisque, id sit luctus mauris a.

Tincidunt lorem hendrerit primis molestie facilisi sed curae integer fames. Urna a quam suspendisse in nam sed euismod sed platea. Aenean, porttitor nec, rutrum velit egestas senectus duis. Montes nam faucibus sed nunc sed felis, aliquam at potenti. Libero tempor molestie vel posuere at est natoque risus morbi molestie consectetur. Nulla torquent sit in nisi, fusce pharetra, ut sed. At a in sem, eu velit, sollicitudin in. Vehicula posuere lectus quam arcu lobortis hac interdum condimentum suscipit. Tempus ac nec sed nunc pulvinar id, dictum malesuada. Dignissim pharetra, torquent, sit suspendisse dictum urna dis.

### Timeline

There are lots of good examples of `R`-based Gantt charts to be found by clever Googling. For displaying progress with sidebar annotations by aim, I particularly like [\underline{this}](https://datascienceplus.com/visualize-your-cvs-timeline-with-r-gantt-style/) example from the [\underline{lares}](https://github.com/laresbernardo/lares) package.

### Rigor and reproducibility

Sed rhoncus primis ipsum ut justo suscipit, sed sed. Ut enim nam penatibus, aptent rhoncus, hac, mi tincidunt sed. Placerat, et iaculis interdum sodales sed nulla ridiculus. Risus, etiam quam mollis sed vitae turpis sapien. Vestibulum tempor fringilla sed vitae non ex dictum tincidunt. Enim dolor ac mus lorem mi odio etiam lorem in non sed. Taciti risus sociis augue eget ac rhoncus. Sed curabitur in netus.

Morbi, donec lacinia mauris ligula dolor, maximus erat curabitur non, blandit porta eget, hendrerit. Sagittis laoreet lorem dictum orci facilisi mollis maecenas enim vitae ultrices. Fringilla quam sodales placerat dolor at dapibus, aptent. Ipsum fermentum ut mus phasellus tincidunt convallis in. Tortor nec, commodo, erat. Diam non sit netus mus sed a. In gravida in quis justo velit in eleifend. In pulvinar egestas ac nec luctus scelerisque scelerisque nisl et sed. Nisi, curae pharetra et auctor sed nam nisi turpis amet leo, augue. Efficitur amet egestas in nec facilisis viverra, lobortis, conubia erat ridiculus habitant metus sed.

### Impact of the proposed study

Sed fusce efficitur in vitae et mi aliquam amet nulla accumsan, a. Nullam vestibulum ut, porta erat donec nulla nibh. Facilisis nunc sem vestibulum ultricies sapien sed morbi tortor. Sed imperdiet potenti dui varius ante. Mollis vitae dui odio dolor sed lacinia. Ullamcorper tristique in nulla, odio sollicitudin. Elit ipsum fermentum tristique tristique faucibus id netus convallis. Curabitur accumsan finibus, aenean enim feugiat vestibulum.



{{< pagebreak >}}





## References {.unnumbered}

::: {#refs}
:::
