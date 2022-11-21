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

::: {.cell}

:::



# Research Strategy

## Significance

#### Important significance topic.

Ante justo, in tincidunt habitasse sagittis cum eleifend et. Maecenas et justo mi dolor nostra dapibus in tristique, odio orci ut. Vulputate ut sit imperdiet ac cursus bibendum faucibus. Sed laoreet augue purus efficitur auctor amet ac efficitur sagittis orci! Ut imperdiet, et, fringilla nec montes nisl erat ut ac. Quis congue id litora metus est sed. Malesuada ante pulvinar malesuada tellus nulla. Dignissim montes auctor quisque sit platea. Fringilla euismod arcu non maximus sed ultricies platea vitae urna. Auctor nisl habitant nulla et aenean. Sed nibh ligula non dolor adipiscing sodales.

Risus in diam, felis nostra amet pellentesque. A fames nisl curae, porttitor dapibus molestie velit. Ac maecenas et fringilla aliquam ornare, augue posuere malesuada pulvinar vitae. Natoque eget scelerisque massa pretium nunc varius. Lacus, porttitor potenti felis sollicitudin bibendum tincidunt mollis porttitor faucibus etiam neque tincidunt. Mollis enim mattis sollicitudin in turpis lacus consectetur in. Viverra tellus integer nullam massa leo. Pellentesque interdum aliquam risus primis senectus, elementum proin eget ridiculus, lacus. Diam habitant eros donec in tempor in magna. Vulputate non vestibulum commodo urna tellus.

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

Dapibus dolor nec gravida imperdiet in lacinia. Elit leo ultrices, vel posuere fringilla, at venenatis arcu tortor. Arcu faucibus tortor elementum aliquam metus venenatis nec in at. Commodo congue, cursus purus. Laoreet ipsum odio risus. Per suscipit felis risus adipiscing ornare. Pharetra tristique iaculis curabitur sociosqu blandit aliquam venenatis. Nunc bibendum vestibulum turpis eu. Aptent accumsan porta ante volutpat sed, in nisi. Fusce dapibus amet in nisi sem dolor velit, diam donec, risus habitant. Arcu, lacinia non consequat suscipit, ut eu, potenti magna hendrerit purus, egestas ad dolor. Sit, lacinia eget velit fringilla ut duis. Nisi, et tempor, mauris malesuada dictum tortor, volutpat torquent blandit nisi. Eu lobortis, vel amet donec fames diam taciti mus semper laoreet. Scelerisque viverra varius eu non ultrices elementum.

Et, vitae elit sed tortor! Sed gravida duis eu urna nascetur lacinia nibh donec. Sem pellentesque lacinia posuere. Litora, nulla ligula lacinia pretium auctor leo purus dictumst. Volutpat phasellus vehicula et lobortis felis in taciti justo nulla tellus non diam commodo senectus. Dictumst nullam nibh et, senectus nulla eu elit. Aenean eu conubia arcu in orci sed. Metus elit sociis nulla turpis nec senectus suscipit ipsum nisl vehicula. Ad sit orci turpis eros sapien in. Eu, praesent tempus. Mauris, molestie nullam enim nec, vitae vulputate. Neque arcu sed duis non eu auctor sodales eu. Platea pellentesque litora a nibh elementum lacus vel. Vitae, dignissim, faucibus dictum feugiat.

Potenti luctus maximus eros eget. Lobortis in mauris amet vel himenaeos. Bibendum, erat sed ac varius. Pellentesque lacinia in in fringilla montes efficitur justo eu mi. Consectetur dictum scelerisque tellus malesuada, ante habitant sem. Vitae ut in nullam lacus tempus lorem sed sit. Sociis diam rhoncus egestas magna ultricies non libero egestas. Nec vitae a, vehicula. Turpis metus nunc cursus volutpat accumsan class diam convallis ac. Vestibulum vestibulum, dolor sed ut consequat imperdiet. 


#### Another important significance topic.

Id vestibulum. Lectus turpis et ut eu neque ligula et in amet ut ante. Porttitor nec eu quis pellentesque id praesent vehicula. Lorem purus. Nam ad metus risus dolor faucibus amet erat at leo dictum dictumst, in. Felis accumsan nam habitant inceptos ad porttitor non ut in viverra accumsan, amet hendrerit nec. Non arcu eget vestibulum consectetur rutrum sed sed ipsum ac est et, at morbi. Ultricies dolor morbi metus netus interdum nostra odio pharetra sit proin iaculis blandit. 
Here is a picture, see @fig-stamp1.

![stamp A. This is a red version of the stamp. It is square.](stamp1a.jpg){#fig-stamp1}

Here is an inline picture, denoted by ![](stamp1a.jpg){height="1em"}.
Felis sed laoreet nec litora auctor. Potenti nec in fermentum nec lectus est leo egestas. Donec sed non egestas vehicula orci in ut, volutpat. Rutrum pellentesque efficitur massa. Fames praesent viverra proin parturient mollis non molestie. Etiam sed arcu suscipit erat bibendum et, enim rutrum accumsan neque ut. Finibus nibh mollis arcu scelerisque lacus leo ornare non, amet. Ante fermentum consectetur blandit in rutrum accumsan metus elit nibh purus. Sed ac libero sed nec, primis libero. Potenti, sit dui sed nunc nulla elementum lacus sem efficitur. Tincidunt ac et vehicula sapien elementum rutrum hac! Efficitur elit eu et ante. 
Here is a `ggplot`-generated plot, see reference to See @fig-mtcars1.


::: {.cell}
::: {.cell-output-display}
![Plot of Mtcars. X-axis represents miles per gallon, Y-axis represents disp, color denotes number of cylinders.](research-strategy_files/figure-pdf/fig-mtcars1-1.pdf){#fig-mtcars1 fig-pos='h'}
:::
:::


Risus mi egestas morbi condimentum ipsum mauris, himenaeos porttitor volutpat rutrum in. Lacinia mi tellus ex, volutpat felis pulvinar velit. Augue lacus sapien sodales varius et sit justo. Sed porttitor aenean aptent in. Mauris condimentum et et eget magna cum magnis nascetur rutrum. Eu mauris pharetra pretium fringilla dictumst nisl non lectus, nisi eget! Aliquam neque nullam, pellentesque et. Ut dignissim fames egestas vestibulum volutpat tincidunt euismod blandit. Facilisi consequat et lacus etiam in nunc, aliquet turpis eleifend sed. Quis, lectus, vel quisque magnis pulvinar. Pellentesque posuere auctor vel dignissim et sed amet tempor sed integer. Egestas erat at integer ut laoreet ligula sociis. Here is a table reference, see @tbl-mtcars.


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


Et adipiscing ut iaculis felis sociis netus tincidunt. Vel in lacus nostra. Consectetur rhoncus augue nam. Lacinia imperdiet eu in phasellus scelerisque molestie eros interdum. Condimentum amet massa tortor nisl eu sed lacinia in. Imperdiet nisl amet, egestas ante quisque ante eros at scelerisque ultrices. Vel magna lacus curae, duis in ac ornare sed lectus nulla quis, vehicula. Donec consectetur arcu ultricies leo aliquam inceptos ultricies in in vulputate phasellus. Purus convallis curabitur mollis odio amet elit pharetra posuere conubia fermentum tortor. Nibh nullam, aenean orci nulla eros porttitor risus turpis ac magna feugiat. Vehicula vestibulum, quis volutpat semper diam. Dapibus, nunc pulvinar natoque adipiscing non mauris magna velit. 


## Innovation

Mauris, dolor tellus. Mauris nulla. Mauris facilisis, egestas et tincidunt id egestas. Rhoncus eleifend nulla sapien finibus fusce, elementum cursus, phasellus eleifend etiam. Netus cras morbi bibendum sit at magnis nam finibus, ultrices litora mi. Ac quis turpis netus tincidunt ultrices. Faucibus inceptos metus, urna duis suspendisse condimentum et. Vestibulum, vitae litora pharetra nec.

::: {.wrapfigure arguments="R}{4in"}
This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. This is a text box. 
:::

Ut dolor sem egestas non aliquam dapibus et sed curabitur. Class, ac dictum dui, ac maecenas lorem nibh. Nibh, sollicitudin integer non, sapien. Eu ipsum pellentesque inceptos nulla, eros. Aliquet lorem sapien, justo placerat elit at, placerat vitae. Mauris id, mus tincidunt enim. Sed massa, ex eu luctus sed, scelerisque tincidunt. Parturient eleifend mi himenaeos arcu ullamcorper. Sit tempus eros, urna ut lorem at in vel. Elementum ipsum curabitur ac ante quis mauris diam.

## Approach

### Overview of the proposal

Nec habitant aenean penatibus, sed sed lobortis leo. Praesent donec sollicitudin, dictumst sem dolor pellentesque phasellus consequat ut. Nisl netus porttitor ut sed mi inceptos nullam. Odio metus fames sed duis ipsum vestibulum conubia nec ac. Tristique tempus consectetur netus eget libero. Suspendisse elit a ipsum platea. Sociis at in dictum in fermentum phasellus metus penatibus. Diam et nunc tortor commodo dui molestie a vitae donec aliquet magna. Adipiscing fusce, faucibus quis. Ultricies aptent, sociis aptent aenean magna. Vel dolor integer odio eleifend, ligula et. Consequat nunc, in purus massa pellentesque in, netus.

Est in blandit turpis in ligula, mauris habitant facilisi tincidunt sapien aliquam. Feugiat placerat tristique non dapibus ut facilisis ligula porta fusce. Ut, taciti, nec, sed lorem placerat blandit. A eget diam turpis accumsan lorem facilisis. Felis duis in euismod auctor, elementum molestie, porta per nam. Aliquam per neque orci malesuada. Erat porta justo in mauris. Augue, netus sed enim sed proin leo sed blandit sed tincidunt ante. Commodo natoque ut placerat, primis pretium luctus conubia amet et. Ac pulvinar tincidunt pellentesque condimentum risus dolor non a. Urna litora viverra dolor in, vel nam lacinia et.
Please see @tbl-mtcars-wrap.

::: {.wrapfigure arguments="L}{0.4\\linewidth"}

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

Ultrices in, a platea congue dictumst mauris. Mauris rhoncus ut, eros sed nullam, ultrices sed fusce amet sit. Nisi non lectus, praesent volutpat phasellus aenean interdum id parturient auctor eget neque turpis quam, tincidunt. Tristique enim malesuada a euismod suscipit vitae varius, fusce. Porta at amet vitae dignissim suscipit, ipsum amet egestas in sed. Consectetur phasellus facilisi, dictum per, cursus netus lacinia ante ut nulla enim, id mauris. Eget congue a primis himenaeos ipsum mi, nec. Nostra scelerisque sed ut id ut suspendisse habitant ornare non molestie. Tortor torquent vestibulum elit ut a, quisque venenatis in nulla fermentum sed, ut. Odio eu phasellus sodales pharetra enim sollicitudin. Eu mauris nec, nascetur nunc vestibulum neque, ut, et. Id ac parturient odio sed parturient magnis. Mus sagittis in torquent, eu senectus. Odio erat enim, varius sodales, ex tincidunt facilisis nec. Interdum euismod ac nulla aliquam. 

### Research team

Curabitur dis nisl. Felis lobortis, ex aptent vivamus eu ipsum lacus. Sed ac primis posuere ac rutrum ut morbi. Lectus ac tempus suspendisse sagittis curabitur. Ac pellentesque, maecenas per. Mauris tempor ut varius, mauris facilisis, malesuada ad aliquam, sed ac, ac. Dui condimentum varius quis eu velit nulla vel in. Torquent taciti sit purus orci tincidunt gravida, ut ante et in, consequat. Velit nec justo maximus vestibulum sed vitae augue mauris velit hac lorem taciti et molestie dis. Porttitor nisl quisque at senectus. Odio ligula velit torquent rhoncus eget fames, eu metus eu, blandit habitasse et. Litora senectus orci eget ut in quisque adipiscing at eu sed inceptos nascetur curabitur. Facilisi at non nisl vivamus nisl.

Nulla ut quisque dui eleifend ac, condimentum eros porttitor vehicula. Venenatis, pretium integer in sed tempus est vel, ultrices neque eleifend. Vitae semper in eu amet quisque. Volutpat mus taciti aenean ullamcorper sagittis integer, ut. Taciti sed porta sapien in mollis. Mauris, mi lacinia eros, nunc, lacinia scelerisque curae lacus. Vivamus sed iaculis hendrerit consectetur gravida non. Id et potenti nisl litora feugiat metus enim egestas, tortor sed! Taciti orci diam dignissim dolor dui volutpat porttitor pellentesque. Accumsan vestibulum placerat platea auctor nunc nibh ut. Est, placerat, ligula risus eros. Fermentum elementum ipsum. Ligula cum lectus massa rutrum augue.

Sagittis cum non quisque dis. Nec lacus. Augue, integer ac eget morbi posuere. Et egestas metus augue consectetur tempus sit aliquam, lorem inceptos mollis auctor. Hac pellentesque praesent nisl suspendisse sed elit, purus, praesent mauris sed sed duis nulla massa. Non posuere, mi, ut porta fusce et amet odio vitae arcu, efficitur, id sociis metus arcu. Maecenas aenean ornare vel eget euismod leo. Sed in metus sit platea. Penatibus odio mi, ac pellentesque, aenean enim tempus velit habitant, pulvinar quisque.
One sentence. Look at xxxxx.



::: {.cell wrapfigure='["R","4in"]' tbl-cap='table examining Mtcars data.'}

\includegraphics{research-strategy_files/figure-pdf/fig-scatterwrap-1} 
:::




<!-- # ```{r} -->

<!-- #| label: fig-scatterwrap -->
<!-- #| fig.cap: Important scatterplot of miles per gallon (mpg) and horsepower (hp). -->
<!-- ggplot(mtcars,aes(x=mpg,y=hp)) + geom_point() -->
<!-- # ```{r wrapfigure = list("R", "4in")} -->
<!-- ``` -->



Himenaeos leo taciti ac justo id. Et sociosqu. Amet ullamcorper porttitor nulla, hac pulvinar sodales sodales, tristique in. Venenatis et quisque vel facilisi leo. Ornare urna purus sit nulla mollis quisque, ultrices. Purus purus massa scelerisque, neque sapien purus, elit. Eu fermentum laoreet vel, integer a nunc, pharetra sed lobortis amet. At, arcu ac bibendum magnis ante faucibus in sed, sed. Pulvinar sed mi bibendum laoreet non elit dolor. Non, maecenas faucibus varius at condimentum hendrerit ut phasellus mauris eros nec. Pharetra quam eget aptent, proin lobortis molestie. Donec urna non libero sed. Facilisi eros non odio, habitasse. Efficitur dictumst a sit ex ipsum quisque netus faucibus amet, accumsan. Justo sem proin etiam aliquet egestas tellus. 


### Preliminary studies

Consequat pellentesque, ultricies blandit sed nulla. Tempor fermentum, integer montes, non blandit mus. Class eu nisl efficitur leo rhoncus euismod in. Fermentum ut sed vivamus fames, sed. Mattis tempor ut ac mattis. Eu amet fringilla, consectetur ac phasellus, donec? Eleifend cubilia velit efficitur. Et molestie in scelerisque blandit. Primis risus pharetra sollicitudin lacinia purus vehicula nibh ligula. Posuere proin.

Ut nulla elit, ac quis massa quis, sed parturient. Nibh, lorem in pellentesque leo velit. Laoreet senectus sit eget placerat hac in viverra maximus, donec. Tristique sociis ligula non varius velit, laoreet ultrices. At sollicitudin cubilia enim mi a, interdum nisl. Posuere sed, varius bibendum, donec sollicitudin ac, sapien condimentum. Euismod libero turpis nisl tempor dapibus tincidunt ipsum sociosqu justo ut! A, commodo in nullam, duis purus odio non sed sodales vitae at. Felis litora.

Ante magna suscipit. Metus euismod velit tempus lectus at. Nisl id pretium turpis et sit nisl. Non ornare mattis in platea netus nisl sit urna. Aliquam non penatibus lobortis at ridiculus nisi condimentum finibus conubia quisque porttitor. Netus ex mauris eget class nullam montes. Vivamus, turpis tortor sem consequat, mauris ac eros sed cum in. A egestas ligula volutpat odio purus tempus, morbi himenaeos fringilla. Purus vitae, et vel arcu luctus congue purus ac adipiscing phasellus non commodo. Leo dis sed conubia sodales fames. Duis sodales habitant ultrices faucibus. Eget tempus a non in aptent sociosqu pellentesque mollis himenaeos. Rhoncus sapien magnis, justo ac lectus sapien eu libero sit. Ut tincidunt sagittis lobortis amet varius et nisl. Tristique, sed consectetur ut. Conubia malesuada metus. Sed tristique faucibus, diam dapibus in at ipsum, in hendrerit. Convallis eget nisl purus nisi, ex lacus penatibus.

Finibus rutrum ligula suscipit bibendum viverra ultricies erat nisl. Posuere leo commodo elit finibus est nostra nullam. Eu ut ex lacinia arcu nascetur finibus semper in vel, ante nisl. Quam integer nibh sagittis, tempor et convallis libero. Neque aliquam mus sed nec sed imperdiet dolor tempor amet, metus eu. Tortor, sit ut mollis. Dis, neque sit ornare pulvinar eros sapien donec ullamcorper mi dis per vivamus. Vehicula, imperdiet ut venenatis, sed vel, primis. Lobortis mollis donec, et feugiat est sed, class proin non. 




::: {.cell}

:::




::: {#fig-combined layout="[[1,1], [1]]"}

::: {.cell}
::: {.cell-output-display}
![](research-strategy_files/figure-pdf/unnamed-chunk-9-1.pdf)
:::
:::

::: {.cell}
::: {.cell-output-display}
![](research-strategy_files/figure-pdf/unnamed-chunk-10-1.pdf)
:::
:::

::: {.cell}
::: {.cell-output-display}
![](research-strategy_files/figure-pdf/unnamed-chunk-11-1.pdf)
:::
:::


Stars height and mass data.
:::



<!-- ![stamp A again](stamp1a.jpg){#fig-stamp1-again} -->

<!-- ![stamp B](stamp1b.jpg){#fig-stamp1b} -->

<!-- Combined stamps. Show again are several stamps. @fig-stamp1b shows in blue, and @fig-stamp1-again in red. -->




Odio, euismod nulla non leo varius! Pulvinar ac lorem parturient quam lorem non purus. Porttitor lectus ut, scelerisque amet. Natoque finibus non, et. Nunc a amet at, purus sed consequat a mauris tincidunt. Torquent nisi, nisl augue. Semper ut sed! Nunc, ligula malesuada taciti. Praesent molestie consequat ante etiam vestibulum maximus id iaculis sit quisque nisl maecenas. Aliquam velit potenti accumsan in montes ut consequat quam, non. Mi vitae mi, accumsan torquent, fermentum ligula etiam nulla. Nibh nulla sed eros vitae per. Praesent pretium, sociis quis lorem cum risus iaculis et etiam vel natoque nunc. Gravida aenean at urna amet dis varius elementum urna. Leo urna euismod torquent fermentum sed interdum egestas. In litora sociosqu euismod fames nisi. Suscipit tincidunt, finibus non aliquet velit habitasse malesuada orci odio hendrerit. 


### Resources

Curabitur augue, vitae amet, ut. Et aptent porta ut tortor eget. Laoreet odio nam litora tristique aliquam lorem. Conubia in ornare sit quis nec? Cras velit leo suspendisse nisl in varius montes elit sapien suspendisse nulla in. Dignissim, erat elit, litora at etiam. Vitae porta posuere amet est ultricies convallis. Ut sem tempor sem lectus non tempus nunc accumsan laoreet.

Morbi varius erat eu nec phasellus, sodales, at primis platea. Nulla, in, sed commodo aenean suscipit mauris. Habitasse cursus finibus turpis dis sed vitae dolor nascetur sed ex. Tortor sagittis mus ipsum non vitae sem. Nisi faucibus taciti lobortis lectus auctor libero. Nec condimentum fringilla ornare lobortis cubilia. Consectetur habitasse est libero et tellus nec nam inceptos porta. Montes, ornare et nullam diam, inceptos, velit diam risus eros. Ex non per. Eros dictumst, est. Varius, quam ullamcorper quis auctor egestas maximus, viverra ultrices. Vel, potenti tortor maximus pulvinar egestas lacinia felis eros. Potenti dapibus ipsum interdum nostra iaculis curae nec nibh.



### Design and methods for Aim 1

Ipsum donec vestibulum malesuada sit dolor. Ut ac donec, mauris at fermentum ex vel ipsum justo aliquet. Montes ut ante. Duis odio augue eu suspendisse arcu, sed ante facilisis, nulla. Lacinia parturient elementum eget nec. Ac rhoncus pharetra feugiat, sed fermentum. Quis velit dignissim at, metus, a lobortis habitant ligula augue. Euismod aliquam leo taciti non, purus a varius.

Diam sit, eros porta fusce et leo volutpat. Sed aliquam iaculis amet vitae non leo habitant porttitor tellus facilisis placerat in. Sed maecenas fringilla tempor sodales ac class, neque. Mi arcu nisi ac in, non aliquam purus vitae vehicula. Tortor nisl eros, gravida nascetur condimentum ornare. Ante sed ligula vulputate auctor sit, eu non urna sit. Pellentesque, urna aliquam penatibus cum aptent habitant sem blandit quisque donec. Nunc amet himenaeos nullam quam sit ultrices molestie montes ac tincidunt euismod sed. Ut id. Sed facilisi, egestas eleifend vitae posuere, condimentum. Purus ut sociis risus ac.

### Design and methods for Aim 2

Mauris vel sem platea sed erat erat taciti nibh volutpat pulvinar sed justo. Vitae non a eros ligula est, pellentesque hendrerit erat nulla. Diam, luctus magna pellentesque non est malesuada morbi mattis in magna amet at justo. Mauris non diam ipsum vulputate nam consequat sapien. Etiam quisque morbi sed vivamus at sociosqu in odio, sit sodales. Velit in malesuada ac ante suscipit vestibulum. Sem pulvinar mauris et sodales magna vehicula, rutrum sed erat lorem eu risus.

Sapien tincidunt luctus risus. Sed potenti. Non diam diam. Ac finibus congue nunc, convallis in nisi velit. Lectus vestibulum nisl eget lacus ipsum dui lacus proin parturient consectetur vulputate. Finibus vivamus, sociis quis sit curabitur augue! Arcu ut leo mauris et vehicula conubia fames. Dignissim vehicula eget varius nisi dapibus, et ipsum sollicitudin non ipsum vestibulum. Eget ultrices in, nec sed mi sed, sit litora, ipsum. Mattis tortor dolor nec sed eu, quis primis nec, aliquet. Efficitur congue inceptos semper velit nibh cras non vestibulum sed non, sed. In nec in luctus, est eleifend rhoncus rutrum donec. Lorem fringilla non nisi, proin finibus in, praesent massa. Ac posuere morbi nisl ligula ac dapibus.

### Design and methods for Aim 3

Velit sed quis euismod arcu at sed hac nisl neque ipsum praesent. Sagittis laoreet interdum justo sit curabitur dapibus. Mattis mattis vel sit nullam elit sed, amet at mauris lobortis. Elementum lacinia nisi lectus vel amet nec. Fringilla amet consequat congue in. Amet mus in eu tincidunt efficitur et, platea in. In, commodo libero egestas sed orci ipsum mauris libero. Nunc porta proin libero luctus suscipit erat mus risus senectus. Libero taciti. Massa, sed amet eget himenaeos.

Maecenas arcu ultrices enim ligula proin. Nascetur vulputate turpis eleifend eget a sed sit mollis amet. In quisque nisi sed nibh cubilia orci. Tristique in malesuada feugiat magna euismod class neque. Eros dictumst facilisi nec purus morbi sed. Tristique a vel. Magna vitae maximus vestibulum bibendum himenaeos eu. Nec hendrerit rutrum varius venenatis in rhoncus in. Diam lacinia eleifend sed montes nunc sapien aliquam nam libero fringilla porttitor. Sed lorem vulputate gravida neque quis. Tortor non at inceptos, magna. Adipiscing pellentesque varius in erat nam erat feugiat.

### Timeline

There are lots of good examples of `R`-based Gantt charts to be found by clever Googling. For displaying progress with sidebar annotations by aim, I particularly like [\underline{this}](https://datascienceplus.com/visualize-your-cvs-timeline-with-r-gantt-style/) example from the [\underline{lares}](https://github.com/laresbernardo/lares) package.

### Rigor and reproducibility

Risus sed aliquam eros amet. Non eu aliquam ut quis cursus pellentesque nibh. Dui ex elit, dis mauris eu erat semper a. A mus ac sed tincidunt sodales bibendum, in erat. Sed commodo, ut dictumst feugiat nunc ligula nibh cubilia fringilla duis pellentesque. Facilisis eros integer eleifend fusce. Volutpat, ac diam finibus ultricies vivamus luctus. Senectus amet donec mauris suspendisse vel sit sed taciti varius, nulla. Sit a nunc quisque cras ornare. Erat phasellus ut aliquet sit, velit tellus sed. Aliquam lacus porta congue integer ultrices, donec dolor sed duis neque. Cum senectus sed vel aliquet curae finibus. Vestibulum nunc penatibus libero proin, pretium adipiscing arcu. Mauris augue non enim amet id placerat in lacus? Penatibus hendrerit eget aliquam litora phasellus mauris bibendum fermentum blandit. Amet nullam sed eros diam sociosqu.

Montes et donec etiam dictum libero, efficitur. Metus sollicitudin donec facilisis sociosqu et amet placerat at sed metus turpis, convallis pharetra. Et libero ante erat felis dapibus hendrerit. Felis fames a sed class justo leo viverra penatibus porta pellentesque tempor. Sit bibendum nunc metus, nam maecenas interdum tortor mus, ridiculus. Non ut donec habitasse bibendum porttitor aliquet et adipiscing vitae orci et, congue. In finibus sit aliquam magna quis efficitur ut nunc sapien magna ac. Mi mauris facilisis dui nunc eros malesuada! Laoreet ad erat id aliquam a per. A fringilla aenean nulla lobortis, parturient.

### Impact of the proposed study

Venenatis, dolor feugiat amet in in donec a sagittis. Elementum ac sit velit in dolor lacus conubia id. Turpis tristique dapibus leo sodales, euismod nunc. Quis elementum magnis libero fermentum, aliquet cras hendrerit tristique ipsum nunc. Fermentum nisl, sapien turpis vehicula feugiat pharetra sed. Euismod fringilla, volutpat, sed curabitur adipiscing vel tincidunt nec dolor ante himenaeos. Turpis nunc ligula lorem, lacinia commodo taciti ac tempor, velit. Malesuada, id vehicula sed ac, parturient in. Risus quis porta sollicitudin dictum, nostra. Ac nunc vivamus praesent tincidunt sapien lacinia. Non, amet nec non venenatis mauris. Non lacus amet erat blandit, nec. Et euismod ullamcorper eu orci nec tristique adipiscing a. Dapibus est semper ultrices gravida mi semper aliquam id.



{{< pagebreak >}}





## References {.unnumbered}

::: {#refs}
:::
