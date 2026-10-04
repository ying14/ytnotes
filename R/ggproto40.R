library(ggplot2)
library(scales)
library(grid)
library(rlang)
library(tidyverse)
library(ggtrace)
library(yingtools2)
rm(list=ls())

funmod <- function(fun, ..., pos=1) {
  explist <- exprs(...)
  fbody <- body(fun)
  if (is.null(fbody)) {
    cli::cli_abort("YTError: can't get body of function") # eg is primitive
  }
  if (class(fbody)=="{") {
    fbody.list <- fbody %>% as.list()
  } else {
    fbody.list <- list(as.name("{"),fbody)
  }
  if (pos<0) {
    pos <- length(fbody.list)+pos
  }
  new.fbody <- append(fbody.list,explist,pos)
  body(fun) <- new.fbody %>% as.call()
  fun
}

mod <- function(fun,fname=NULL) {
  quo <- enquo(fun)
  if (is.null(fname)) {
    fname <- as_label(quo)  
  } 
  # msg <- str_glue("{fname}()")
  newfun <- funmod(fun,
                   note(fname=!!fname),
                   pos=1)
  newfun
}


modgg <- function(gg,funs=NULL) {
  quo <- enquo(gg)
  gname <- as_label(quo)
  if (!is(gg,"ggproto")) {
    cli::cli_abort("YTError: need a ggroto")
  }
  gglist <- as.list(gg)
  
  gg.funs <- funs %||% names(gglist)[map_lgl(gglist,is.function)]
  
  for (fun in gg.funs) {
    fname <- paste0(gname,"$",fun)
    gg[[fun]] <- mod(gg[[fun]],fname)  
  }
  environment(gg) <- asNamespace('ggplot2')
  assignInNamespace(gname, gg, ns = 'ggplot2')
}

note <- function(fname,
                 fun=caller_fn(),
                 env=caller_env()) {
  row <- tibble(fn=fname)
  
  
  args(GeomCol$setup_data)
  ggformals(GeomCol$setup_data)
  GeomCol$setup_data
  
  caller_fn()
  .steps <<- bind_rows(.steps,row)
}

GeomCol$setup_data

# modgg(ScaleDiscrete)
modgg(GeomCol,c("draw_panel","setup_data"))

.steps <<- tibble()

# gg <- mtcars %>%
#   mutate(cyl=factor(cyl,levels=c("4","6","8","10")),
#          am=factor(am)) %>%
#   ggplot(aes(x=mpg,fill=cyl,color=am)) +
#   geom_histogram(bins=25) +
#   scale_fill_brewer(type="qual",drop=FALSE) +
#   coord_cartesian() +
#   scale_x_log10() +
#   facet_grid(gear ~ .)

gg <- ggplot(mtcars) +
  geom_col(aes(x=mpg,y=disp))
gg

.steps %>% dt()




