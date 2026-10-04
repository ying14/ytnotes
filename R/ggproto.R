library(ggplot2)
library(scales)
library(grid)
library(rlang)
library(tidyverse)
library(ggtrace)
library(yingtools2)


# updated to ggplot2 3.5
scale_fill_brewer2 <- function (name = waiver(), ..., type = "seq", palette = 1, direction = 1, aesthetics = "fill") {
  discrete_scale2(aesthetics, name = name, palette = pal_brewer(type, palette, direction), ...)
}


# scale_fill_brewer2 -> discrete_scale2 -> guide_legend2 -> guide_train.legend2 + guide_geom.legend2 + guide_gengrob.legend2
# updated to ggplot2 3.5
discrete_scale2 <- function(aesthetics, scale_name = deprecated(), palette, name = waiver(),
          breaks = waiver(), labels = waiver(), limits = NULL, expand = waiver(),
          na.translate = TRUE, na.value = NA, drop = TRUE,
          guide = guide_legend2(),
          position = "left", call = caller_call(), super = ScaleDiscrete2) {
  call <- call %||% current_call()
  if (lifecycle:::is_present(scale_name)) {
    ggplot2:::deprecate_soft0("3.5.0", "discrete_scale(scale_name)")
  }
  aesthetics <- standardise_aes_names(aesthetics)
  ggplot2:::check_breaks_labels(breaks, labels, call = call)
  limits <- ggplot2:::allow_lambda(limits)
  breaks <- ggplot2:::allow_lambda(breaks)
  labels <- ggplot2:::allow_lambda(labels)
  if (!is.function(limits) && (length(limits) > 0) && !is.discrete(limits)) {
    cli::cli_warn(c("Continuous limits supplied to discrete scale.",
                    i = "Did you mean {.code limits = factor(...)} or {.fn scale_*_continuous}?"),
                  call = call)
  }
  position <- arg_match0(position, c("left", "right", "top",
                                     "bottom"))
  if (is.null(breaks) && all(!is_position_aes(aesthetics))) {
    guide <- "none"
  }
  ggproto(NULL, super, call = call, aesthetics = aesthetics,
          palette = palette, range = DiscreteRange$new(), limits = limits,
          na.value = na.value, na.translate = na.translate, expand = expand,
          name = name, breaks = breaks, labels = labels, drop = drop,
          guide = guide, position = position)
}




# updated to ggplot2 3.5
guide_legend2 <- function (title = waiver(), theme = NULL, position = NULL, direction = NULL,
          override.aes = list(), nrow = NULL, ncol = NULL, reverse = FALSE,
          order = 0, ...) {
  theme <- ggplot2:::deprecated_guide_args(theme, ...)
  if (!is.null(position)) {
    position <- arg_match0(position, c(.trbl, "inside"))
  }
  new_guide(title = title, theme = theme, direction = direction,
            override.aes = ggplot2:::rename_aes(override.aes), nrow = nrow,
            ncol = ncol, reverse = reverse, order = order, position = position,
            available_aes = "any", name = "legend", super = GuideLegend2)
}




GuideLegend2 <- ggproto("GuideLegend2",GuideLegend,
                        train = function(self, params = self$params, scale, aesthetic = NULL, ...) {
                          note(GuideLegend2$train,"Prepare params and decor")
                          newparams <- ggproto_parent(GuideLegend, self)$train(params, scale, aesthetic)
                          newparams
                        },
                        setup_params = function(params) {
                          note(GuideLegend$setup_params,"modifies and returns params: adds direction, n_breaks, n_key_layers, nrow, ncol")
                          newparams <- GuideLegend$setup_params(params)
                          newparams
                        },
                        setup_elements = function(params, elements, theme) {
                          note(GuideLegend$setup_elements,"modifies elements: prepare legend spacing, positioning")
                          GuideLegend$setup_elements(params, elements, theme)
                        },
                        build_ticks = function(...) {
                          note(GuideLegend$build_ticks,"just a zeroGrob in legend")
                          GuideLegend$build_ticks(...)
                        },
                        build_labels = function(key, elements, params) {
                          note(GuideLegend$build_labels,"key labels in a list of grobs")
                          grlist <- GuideLegend$build_labels(key, elements, params)
                          grlist
                        },
                        build_decor = function(decor, grobs, elements, params) {
                          note(GuideLegend$build_decor,"draw individual legend keys in a list of grobs")
                          grlist <- GuideLegend$build_decor(decor, grobs, elements, params)
                          grlist
                        },
                        measure_grobs = function(grobs, params, elements) {
                          note(GuideLegend$build_decor,"measure grobs for size list, to be used in assemble_drawing")
                          sizelist <- GuideLegend$measure_grobs(grobs,params,elements)
                          sizelist
                        },
                        arrange_layout = function(key, sizes, params, elements) {
                          note(GuideLegend$arrange_layout,"makes simple table row-col layout of grobs")
                          df <- GuideLegend$arrange_layout(key, sizes, params, elements)
                          print(df)
                          df
                        },
                        assemble_drawing = function(self, grobs, layout, sizes, params, elements) {
                          note(GuideLegend$assemble_drawing,"generate grob which will be the legend")
                          gb <- ggproto_parent(GuideLegend, self)$assemble_drawing(grobs, layout, sizes, params, elements)
                          gb
                        })



ScaleDiscrete2 <- ggproto("ScaleDiscrete2", ScaleDiscrete,
                          drop = TRUE,
                          na.value = NA,
                          n.breaks.cache = NULL,
                          palette.cache = NULL,

                          is_discrete = function() TRUE,
                          transform_df = function(self, df) {
                            note(ScaleDiscrete$transform_df,"fill transform data, calls ScaleDiscrete$transform(). Called once after Layer$compute_aesthetics(), then again by Layer$map_statistic")
                            df <- ggproto_parent(ScaleDiscrete, self)$transform_df(df)
                          },
                          transform = function(x) {
                            new_x <- ScaleDiscrete$transform(x)
                            note(ScaleDiscrete$transform,str_glue("fill identity transform: cyl {x[1]} -> {new_x[1]}"))
                            return(new_x)
                          },

                          train_df = function(self, df) {
                            note(ScaleDiscrete$train_df,"fill training on data, calls ScaleDiscrete$train() on matching ScaleDiscrete$aesthetics")
                            new_df <- ggproto_parent(ScaleDiscrete, self)$train_df(df)
                            return(new_df)
                          },
                          train = function(self, x) {
                            new_x <- ggproto_parent(ScaleDiscrete, self)$train(x)
                            note(ScaleDiscrete$train,str_glue("for fill vector, extracts distinct levels and trains ScaleDiscrete$range. typically calls train_discrete: {paste(new_x,collapse=', ')}"))
                            return(new_x)
                          },
                          map_df = function (self, df, i = NULL) {
                            note(ScaleDiscrete$map_df,"fill assign color from data. calls map")
                            fill <- ggproto_parent(ScaleDiscrete, self)$map_df(df, i)
                            fill
                          },
                          map = function (self, x, limits = self$get_limits()) {
                            new_x <- ggproto_parent(ScaleDiscrete, self)$map(x, limits)
                            print(str_glue("{head(x,3)} -> {head(new_x,3)}"))
                            note(ScaleDiscrete$map,str_glue("fill assign colors using palette lookup (brewer palette fn): cyl {x[1]} -> {new_x[1]}"))
                            return(new_x)
                          },
                          rescale = function(self, x, limits = self$get_limits(), range = c(1, length(limits))) {
                            note(ScaleDiscrete$rescale)
                            rescale(x, match(as.character(x), limits), from = range)
                          },
                          dimension = function(self, expand = expansion(0, 0), limits = self$get_limits()) {
                            note(ScaleDiscrete$dimension)
                            expand_limits_discrete(limits, expand = expand)
                          },
                          get_breaks = function(self, limits = self$get_limits()) {
                            breaks <- ggproto_parent(ScaleDiscrete, self)$get_breaks(limits)
                            note(ScaleDiscrete$get_breaks,str_glue("fill legend determine breaks: cyl {paste(breaks,collapse=', ')}"))
                            return(breaks)
                          },
                          get_breaks_minor = function(...) NULL,
                          get_labels = function(self, breaks = self$get_breaks()) {
                            note(ScaleDiscrete$get_labels,"fill legend determine labels")
                            ggproto_parent(ScaleDiscrete, self)$get_labels(breaks)
                          },
                          clone = function(self) {
                            new <- ggproto(NULL, self)
                            new$range <- DiscreteRange$new()
                            new
                          },
                          break_info = function(self, range = NULL) {
                            # for discrete, limits != range
                            note(ScaleDiscrete$break_info,"ScaleDiscrete2$break_info")
                            ggproto_parent(ScaleDiscrete, self)$break_info(range = NULL)
                          }
)




geom_histogram2 <- function (mapping = NULL, data = NULL, stat = "bin2", position = "stack2",
          ..., binwidth = NULL, bins = NULL, na.rm = FALSE, orientation = NA,
          show.legend = NA, inherit.aes = TRUE) {
  layer(data = data, mapping = mapping, stat = stat, geom = GeomBar2,
        layer_class = Layer2,
        position = position, show.legend = show.legend, inherit.aes = inherit.aes,
        params = list2(binwidth = binwidth, bins = bins, na.rm = na.rm,
                       orientation = orientation, pad = FALSE,  ...))
}




GeomBar2 <- ggproto("GeomBar2", GeomBar,
                   required_aes = c("x", "y"),
                   non_missing_aes = c("xmin", "xmax", "ymin", "ymax"),
                   extra_params = c("just", "na.rm", "orientation"),
                   use_defaults = function(self, data, params = list(), modifiers = aes()) {
                     newdata <- ggproto_parent(Geom, self)$use_defaults(data, params, modifiers)
                     note(Geom$use_defaults,str_glue("add default aes to data: {paste(setdiff(names(newdata),names(data)),collapse=', ')}"))
                     return(newdata)
                   },
                   aesthetics = function(self) {
                     note(Geom$aesthetics,"extract aesthetics, from required_aes, default_aes, optional_aes, group")
                     ggproto_parent(Geom, self)$aesthetics()
                   },
                   parameters = function(self, extra = FALSE) {
                     note(Geom$parameters,"extract parameters, from args on draw_panel, draw_group, ..., and extra_params")
                     ggproto_parent(Geom, self)$parameters(extra)
                   },
                   setup_data = function(data, params,...) {
                     newdata <- GeomBar$setup_data(data, params)
                     note(GeomBar$setup_data,"col width removed, ymin/ymax added")
                     return(newdata)
                   },
                   setup_params = function(data, params) {
                     note(GeomBar2$setup_params,"Check for flipped aes")
                     print(head(data,1))
                     GeomBar$setup_params(data, params)
                   },
                   draw_layer = function (self, data, params, layout, coord) {
                     note(GeomBar2$draw_layer,"calls GeomBar2$draw_panel")
                     # note.xrange(GeomBar2$draw_layer,layout)
                     print(head(data,1))

                     # ggplot_build(gg)$layout[["panel_params"]][[1]][["x.range"]]
                     if (ggplot2:::empty(data)) {
                       n <- if (is.factor(data$PANEL))
                         nlevels(data$PANEL)
                       else 1L
                       return(rep(list(zeroGrob()), n))
                     }
                     params <- params[intersect(names(params), self$parameters())]
                     lapply(split(data, data$PANEL), function(data) {
                       if (ggplot2:::empty(data))
                         return(zeroGrob())
                       panel_params <- layout$panel_params[[data$PANEL[1]]]
                       inject(self$draw_panel(data, panel_params, coord, !!!params))
                     })
                   },
                   draw_panel = function(self, data, panel_params, coord, lineend = "butt",
                                         linejoin = "mitre", width = NULL, flipped_aes = FALSE) {
                     note(GeomBar2$draw_panel,"called by GeomBar2$draw_layer")
                     print(head(data,1))
                     GeomBar$draw_panel(data, panel_params, coord, lineend ,
                                        linejoin, width , flipped_aes )
                   },
                   draw_key = function(data,params,size)  {
                     note(GeomBar2$draw_key,str_glue("legend draw a single key item {data$fill}"))
                     print(head(data,1))
                     draw_key_polygon(data,params,size)
                   },
                   rename_size = TRUE
)





StatBin2 <- ggproto("StatBin2", StatBin,
                   setup_params = function(self, data, params) {
                     note(StatBin$setup_params)

                     StatBin$setup_params(data,params)
                   },
                   extra_params = c("na.rm", "orientation"),

                   compute_layer = function (self, data, params, layout) {
                     note(StatBin2$compute_layer)
                     # note.xrange(StatBin2$compute_layer,layout)
                     print(head(data,1))
                     ggplot2:::check_required_aesthetics(self$required_aes, c(names(data), names(params)), snake_class(self))
                     required_aes <- intersect(names(data), unlist(strsplit(self$required_aes, "|", fixed = TRUE)))
                     data <- remove_missing(data, params$na.rm, c(required_aes, self$non_missing_aes), snake_class(self), finite = TRUE)
                     params <- params[intersect(names(params), self$parameters())]
                     args <- c(list(data = quote(data), scales = quote(scales)), params)
                     ggplot2:::dapply(data, "PANEL", function(data) {
                       scales <- layout$get_scales(data$PANEL[1])
                       try_fetch(inject(self$compute_panel(data = data, scales = scales, !!!params)),
                                 error = function(cnd) {
                                   cli::cli_warn("Computation failed in {.fn {snake_class(self)}}", parent = cnd)
                                   data_frame0()
                                   })
                     })
                   },
                   compute_panel = function(self, data, scales, ...) {
                     note(StatBin2$compute_panel,"called by StatBin2$compute_layer; histo data converted to rect data")
                     data2<-StatBin$compute_panel(data,scales,...)
                     print(head(data2,1))
                     return(data2)
                   },
                   compute_group = function(data, scales, binwidth = NULL, bins = NULL,
                                            center = NULL, boundary = NULL,
                                            closed = c("right", "left"), pad = FALSE,
                                            breaks = NULL, flipped_aes = FALSE,
                                            origin = NULL, right = NULL, drop = NULL) {
                     note(StatBin2$compute_group,"called by StatBin2$compute_group")
                     StatBin$compute_group(data, scales, binwidth, bins ,
                                           center, boundary,
                                           closed, pad ,
                                           breaks , flipped_aes ,
                                           origin , right , drop)
                   },
                   finish_layer=function (self, data, params) {
                     note(StatBin2$finish_layer)
                     data
                   },
                   default_aes = aes(x = after_stat(count), y = after_stat(count), weight = 1),
                   required_aes = "x|y",
                   dropped_aes = "weight" # after statistical transformation, weights are no longer available
)


coord_cartesian2 <- function (xlim = NULL, ylim = NULL, expand = TRUE, default = FALSE,
                              clip = "on") {
  ggproto(NULL, CoordCartesian2, limits = list(x = xlim, y = ylim),
          expand = expand, default = default, clip = clip)
}


CoordCartesian2 <- ggproto("CoordCartesian2",CoordCartesian,

                           backtransform_range = function (self, panel_params) {
                             note(CoordCartesian$backtransform_range)
                             ggproto_parent(CoordCartesian, self)$backtransform_range(panel_params)
                           },
                           setup_data = function (self, data, params = list()) {
                             note(CoordCartesian2$setup_data)
                             ggproto_parent(CoordCartesian, self)$setup_layout(data, params)
                           },
                           transform = function (self, data, panel_params) {
                             note(CoordCartesian$transform, "called by Geom$draw_panel to get grob coordinates")
                             ggproto_parent(CoordCartesian, self)$transform(data, panel_params)
                           },
                           setup_panel_params = function (self, scale_x, scale_y, params = list()) {
                             note(CoordCartesian$setup_panel_params,"considers specified limits and expand parameters")
                             ggproto_parent(CoordCartesian, self)$setup_panel_params(scale_x, scale_y, params = list())
                           },
                           setup_layout = function (self, layout, params) {
                             note(CoordCartesian$setup_layout,"CoordCartesian does nothing, but CoordFlip uses")
                             ggproto_parent(CoordCartesian, self)$setup_layout(layout, params)
                           },
                           train_panel_guides = function (self, panel_params, layers, default_mapping, params = list()) {
                             note(CoordCartesian$train_panel_guides,"calls guide_train.legend, guide_geom.legend, guide_gengrob.legend")
                             ggproto_parent(CoordCartesian, self)$train_panel_guides(panel_params, layers, default_mapping, params = list())
                           },
                           modify_scales = function (self, scales_x, scales_y) {
                             note(CoordCartesian2$modify_scales,"CoordCartesian does nothing, but are used by CoordFlip, CoordPolar")
                             ggproto_parent(CoordCartesian, self)$modify_scales(scales_x, scales_y)
                           })


PositionStack2 <-  ggproto("PositionStack2", PositionStack,
                           setup_data = function (self, data, params) {
                             note(PositionStack$setup_data)
                             print(head(data,1))
                             PositionStack$setup_data(data,params)
                           },
                           setup_params = function (self, data) {
                             note(PositionStack$setup_params)
                             print(head(data,1))
                             ggproto_parent(PositionStack, self)$setup_params(data)
                           },
                           compute_layer = function (self, data, params, layout) {
                             note(PositionStack$compute_layer,"calls compute_panel")
                             print(head(data,1))
                             ggplot2:::dapply(data, "PANEL", function(data) {
                               if (ggplot2:::empty(data))
                                 return(data_frame0())
                               scales <- layout$get_scales(data$PANEL[1])
                               self$compute_panel(data = data, params = params, scales = scales)
                             })
                           },
                           compute_panel = function (self, data, params, scales) {
                             note(PositionStack$compute_panel,"called by compute_layer")
                             print(head(data,1))
                             ggproto_parent(PositionStack, self)$compute_panel(data, params, scales)
                           })



scale_x_log102 <- function (...) {
  scale_x_continuous2(..., trans = log10_trans())
}

scale_x_continuous2 <- function (name = waiver(), breaks = waiver(), minor_breaks = waiver(),
          n.breaks = NULL, labels = waiver(), limits = NULL, expand = waiver(),
          oob = censor, na.value = NA_real_, trans = "identity", guide = waiver(),
          position = "bottom", sec.axis = waiver()) {
  sc <- continuous_scale(ggplot2:::ggplot_global$x_aes, "position_c",
                         identity, name = name, breaks = breaks, n.breaks = n.breaks,
                         minor_breaks = minor_breaks, labels = labels, limits = limits,
                         expand = expand, oob = oob, na.value = na.value, trans = trans,
                         guide = guide, position = position, super = ScaleContinuousPosition2)
  ggplot2:::set_sec_axis(sec.axis, sc)
}




ScaleContinuousPosition2 <- ggproto("ScaleContinuousPosition2",ScaleContinuousPosition,
                                    transform = function (self, x) {
                                      new_x <- self$trans$transform(x)
                                      note(ScaleContinuousPosition$transform,str_glue("X log transform: mpg {x[1]} -> {new_x[1]}"))
                                      axis <- if ("x" %in% self$aesthetics)
                                        "x"
                                      else "y"
                                      ggplot2:::check_transformation(x, new_x, self$scale_name, axis)
                                      new_x
                                    },
                                    map = function (self, x, limits = self$get_limits()) {
                                      scaled <- as.numeric(self$oob(x, limits))
                                      new_x <- ifelse(!is.na(scaled), scaled, self$na.value)
                                      note(ScaleContinuousPosition$map,str_glue("X map: mpg (checking if values in scale): {x[1]} -> {new_x[1]}"))
                                      new_x
                                    },
                                    # train_df = function(self, df) {
                                    #   note(ScaleContinuousPosition$train_df)
                                    #   ggproto_parent(ScaleContinuousPosition, self)$train_df(df)
                                    # },
                                    rescale = function (self, x, limits = self$get_limits(), range = limits) {
                                      new_x <- self$rescaler(x, from = range)
                                      note(ScaleContinuousPosition$rescale,str_glue("X rescale: mpg {x[1]} -> {new_x[1]}"))
                                      return(new_x)
                                    })


Layer2 <- ggproto("Layer2",ggplot2:::Layer,
                  layer_data = function (self, plot_data) {
                    note(Layer2$layer_data,"[Layer 1] get the initial data, either from ggplot (plot_data) or geom_xxxx (self$data)")
                    data <- ggproto_parent(ggplot2:::Layer, self)$layer_data(plot_data)
                    print(head(data,1))
                    return(data)
                  },
                  setup_layer = function (self, data, plot) {
                    note(Layer2$setup_layer,"[Layer 2] determine self$computed_mapping and rename size->linewidth")
                    ggproto_parent(ggplot2:::Layer, self)$setup_layer(data, plot)
                  },
                  compute_aesthetics = function (self, data, plot) {
                    note(Layer2$compute_aesthetics,"[Layer 3] apply aesthetic mappings, add group var. Add scales based on aesthetics, using ggplot2:::scales_add_defaults() and ggplot2:::find_scale()")
                    new_data <- ggproto_parent(ggplot2:::Layer, self)$compute_aesthetics(data, plot)
                    return(new_data)
                  },
                  compute_statistic = function (self, data, layout) {
                    note(Layer2$compute_statistic,"[Layer 4] calls stat methods: Stat$setup_params, Stat$setup_data, Stat$compute_layer")
                    ggproto_parent(ggplot2:::Layer, self)$compute_statistic(data, layout)
                  },
                  map_statistic = function (self, data, plot) {
                    note(Layer2$map_statistic,"[Layer 5] following stat, aesthetics/scales are re-applied, including y=after_stat(count)")
                    new_data=ggproto_parent(ggplot2:::Layer, self)$map_statistic(data, plot)
                    print(head(new_data,1))
                    return(new_data)
                  },
                  compute_geom_1 = function (self, data) {
                    note(Layer2$compute_geom_1,"[Layer 6] calls geom$setup_params and geom$setup_data)")
                    ggproto_parent(ggplot2:::Layer, self)$compute_geom_1(data)
                  },
                  compute_position = function (self, data, layout) {
                    note(Layer2$compute_position,"[Layer 7] calls position methods: PositionStack$setup_params(), PositionStack$setup_data(), PositionStack$compute_layer()")
                    ggproto_parent(ggplot2:::Layer, self)$compute_position(data, layout)
                  },
                  compute_geom_2 = function (self, data) {
                    note(Layer2$compute_geom_2,"[Layer 8] calls geom$use_defaults")
                    ggproto_parent(ggplot2:::Layer, self)$compute_geom_2(data)
                  },
                  finish_statistics = function (self, data) {
                    note(Layer2$finish_statistics,"[Layer 9] calls stat$finish_layer")
                    ggproto_parent(ggplot2:::Layer, self)$finish_statistics(data)
                  },
                  draw_geom = function (self, data, layout) {
                    note(Layer2$draw_geom,"[Layer 11] calls geom$draw_layer")
                    ggproto_parent(ggplot2:::Layer, self)$draw_geom(data, layout)
                  })




facet_grid2 <- function (rows = NULL, cols = NULL, scales = "fixed", space = "fixed",
                         shrink = TRUE, labeller = "label_value", as.table = TRUE,
                         switch = NULL, drop = TRUE, margins = FALSE, facets = NULL) {
  if (!is.null(facets)) {
    rows <- facets
  }
  if (is.logical(cols)) {
    margins <- cols
    cols <- NULL
  }
  scales <- arg_match0(scales %||% "fixed", c("fixed", "free_x", "free_y", "free"))
  free <- list(x = any(scales %in% c("free_x", "free")), y = any(scales %in% c("free_y", "free")))
  space <- arg_match0(space %||% "fixed", c("fixed", "free_x", "free_y", "free"))
  space_free <- list(x = any(space %in% c("free_x", "free")),
                     y = any(space %in% c("free_y", "free")))
  if (!is.null(switch) && !switch %in% c("both", "x", "y")) {
    cli::cli_abort("{.arg switch} must be either {.val both}, {.val x}, or {.val y}")
  }
  facets_list <- ggplot2:::grid_as_facets_list(rows, cols)
  labeller <- ggplot2:::check_labeller(labeller)
  ggproto(NULL, FacetGrid2, shrink = shrink, params = list(rows = facets_list$rows,
                                                           cols = facets_list$cols, margins = margins, free = free,
                                                           space_free = space_free, labeller = labeller, as.table = as.table,
                                                           switch = switch, drop = drop))
}

FacetGrid2 <- ggproto("FacetGrid2",FacetGrid,
                      setup_params = function(data, params)  {
                        note(FacetGrid2$setup_params)
                        FacetGrid$setup_params(data, params)
                      },
                      setup_data = function(data, params)  {
                        note(FacetGrid2$setup_data)
                        FacetGrid$setup_data(data, params)
                      },
                      compute_layout = function(self, data, params)  {
                        note(FacetGrid2$compute_layout,"")
                        ggproto_parent(FacetGrid, self)$compute_layout(data,params)
                      },
                      map_data = function(data, layout, params)  {
                        note(FacetGrid2$map_data)
                        FacetGrid$map_data(data, layout, params)
                      },
                      init_scales = function(layout, x_scale = NULL, y_scale = NULL, params) {
                        note(FacetGrid2$init_scales)
                        FacetGrid$init_scales(layout, x_scale, y_scale, params)
                      },
                      draw_back = function(data, layout, x_scales, y_scales, theme, params)  {
                        note(FacetGrid2$draw_back)
                        FacetGrid$draw_back(data, layout, x_scales, y_scales, theme, params)
                      },
                      draw_front = function(data, layout, x_scales, y_scales, theme, params)  {
                        note(FacetGrid2$draw_front)
                        FacetGrid$draw_front(data, layout, x_scales, y_scales, theme, params)
                      },
                      draw_panels = function(self, ...)  {
                        note(FacetGrid2$draw_panels)
                        ggproto_parent(FacetGrid, self)$draw_panels(...)
                      },
                      draw_labels = function(panels, layout, x_scales, y_scales, ranges, coord, data, theme, labels, params)  {
                        note(FacetGrid2$draw_labels)
                        FacetGrid$draw_labels(panels, layout, x_scales, y_scales, ranges, coord, data, theme, labels, params)
                      },
                      vars = function(..., self)  {
                        note(FacetGrid2$vars, "not sure if this is run?")
                        ggproto_parent(FacetGrid, self)$vars(self)
                      }
)



# ss <- function() {
#   .steps %>% dt()
# }

ggformals2 <- function(obj) {
  obj <- enquo(obj)
  txt <- as_label(obj)
  message(txt)
  if (grepl("\\$",txt)) {
    gg.pr <- str_split(txt,"\\$") %>% unlist() %>% first()
    gg.fn <- str_split(txt,"\\$") %>% unlist() %>% last()
    ggproto <- get(gg.pr)
    lvls <- class(ggproto)
    if (grepl("2",lvls[1])) {
      lvls <- lvls[-1]
    }
    lineage <- lvls %>% setNames(.,.) %>% map(~{
      # .x="Geom"
      fname <- paste0(.x,"$",gg.fn)
      fmls <- tryCatch({
        eval_tidy(ggformals(!!parse_expr(fname)))
      },error=function(e) {
        NULL
      })
      fmls
    }) %>% compact()
    lineage[[1]]
  } else {
    eval_tidy(ggformals(!!parse_expr(txt)))
  }
}

get_label <- function(ggfun) {
  ggfun <- enquo(ggfun)

  fmls <- tryCatch({
    eval_tidy(ggformals2(!!ggfun)) %>%
      imap(~{
        if (is_missing(.x)) {
          return(.y)
        } else {
          return(paste0(.y,"=",as_label(.x)))
        }
      }) %>% paste(collapse=", ")
  },error=function(e) {
    return("ERROR")
  })

  fnname <- as_label(ggfun) %>% str_replace("ggplot2:::","")

  label <- str_glue("{fnname}({fmls})")
  label
}

note <- function(obj,comment=NULL) {
  obj <- enquo(obj)
  fnname <- get_label(!!obj)
  message(fnname)
  env <- caller_env()
  row <- tibble(fn=fnname)
  # if (fnname=="Layer2$compute_statistic(self, data, layout)") {
  #   browser()
  # }

  ###### get data  ######
  dname <- ls(envir=env) %>% {.[grep("data",.)[1]]}
  data <- env[[dname]]
  row$data <- list(data) %>% setNames(dname)

  # if (fnname=="FacetGrid2$setup_params(data, params)") {
  #   browser()
  # }

  if (is.null(data)) {
    row$mpg <- "no data"
  } else if ("mpg" %in% names(data)) {
    row$mpg <- data$mpg %>% range() %>% round(digits=2) %>% paste(collapse=",")
  } else {
    row$mpg <- "no mpg"
  }

  if (is.null(data)) {
    row$x <- "no data"
  } else if ("x" %in% names(data)) {
    row$x <- data$x %>% range() %>% round(digits=2) %>% paste(collapse=",")
  } else {
    row$x <- "no x"
  }

  #######################

  ###### get xlim from layout #######
  lname <- ls(envir=env) %>% {.[grep("layout",.)[1]]}
  layout <- env[[lname]]
  if (is.null(layout)) {
    xlim <- NA_character_
  } else if (is.null(layout$panel_params)) {
    xlim <- "no panel_params"
  } else {
    xlim <- paste(layout[["panel_params"]][[1]][["x.range"]],collapse=", ")
  }

  # row$layout <- list(layout)
  row$xlim <- xlim
  if (!is.null(comment)) {
    row$comment <- comment
  } else {
    row$comment <- ""
  }
  ###################################
  .steps <<- bind_rows(.steps,row)
}




# note.xrange <- function(obj,layout) {
#   obj <- enquo(obj)
#   fnname <- get_label(!!obj)
#   xlim <- layout[["panel_params"]][[1]][["x.range"]]
#   lbl <- paste(xlim,collapse=",")
#   row <- tibble(fn=fnname) %>%
#     mutate(xlim=lbl)
#   .xrange <<- bind_rows(.xrange,row)
# }




# deprecated <- lifecycle:::deprecated
# grid_as_facets_list = ggplot2:::grid_as_facets_list
# check_labeller = ggplot2:::check_labeller


.steps <<- tibble()
# .xrange <<- tibble()

gg <- mtcars %>%
  mutate(cyl=factor(cyl,levels=c("4","6","8","10")),
         am=factor(am)) %>%
  ggplot(aes(x=mpg,fill=cyl,color=am)) +
  geom_histogram2(bins=25) +
  scale_fill_brewer2(type="qual",drop=FALSE) +
  # coord_cartesian2() +
  # scale_x_log102() +
  facet_grid2(gear ~ .)

gg



.steps %>%
  mutate(data.dim=map_chr(data,~paste2(dim(.x),collapse=" x "))) %>%
  select(fn,data.dim,xlim,mpg,x,comment) %>% dt()









