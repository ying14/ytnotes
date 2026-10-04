
# test code ---------------------------------------------------------------

library(styler)
library(yingtools2)
library(tidyverse)
rm(list=ls())

text <- 'usd<-     function(   dollars  ){
str_glue(  "${dollars}.00 USD"   )
}
data    <- diamonds    %>%filter(carat<=3) %>%arrange(carat,depth) %>%
  mutate(usd=usd(price)) %>%sample_n(1000) %>%select(-x,-y,-z)
data %>% imap_chr(~{
  paste(.y,     class(.x)   [1]  )
}   )
ggplot(  data,aes(x=carat,
                  y=price,
                  color=color)) + 
  geom_point(na.rm=TRUE) +
  labs(title="Diamonds") +
  scale_y_continuous(labels=scales::dollar_format())
'







# functions ---------------------------------------------------------------




# modifies style to print work
add_narration_to_style <- function(style,
                                   esc_fun=function(group,name,fun,pd0,pd1,changed) {
                                     if (changed) {
                                       cli::cli_alert(cli::col_yellow("Running: [{group}] {name}"))
                                     }
                                   }) {
  # exp <- enexpr(exp)
  modfun <- function(fun,name=NULL,group=NULL) {
    newfun <- function(pd, ...) {
      newpd <- fun(pd, ...)
      changed <- !isTRUE(all_equal(pd,newpd))
      esc_fun(group,name,fun,pd,newpd,changed)
      return(newpd)
    }
    return(newfun)
  }
  new_style <- function(...) {
    transformers <- style(...)
    # c("line_break","space","indention","token")
    transformers$line_break <- transformers$line_break %>% imap(~modfun(.x,.y,"line_break"))
    transformers$space <- transformers$space %>% imap(~modfun(.x,.y,"space"))
    transformers$indention <- transformers$indention %>% imap(~modfun(.x,.y,"indention"))
    transformers$token <- transformers$token %>% imap(~modfun(.x,.y,"token"))
    return(transformers)
  }
  return(new_style)
}



text_to_pd <- function(text) {
  text %>%
    compute_parse_data_nested() %>% 
    styler:::post_visit(list(default_style_guide_attributes))
}

middle_stuff <- function(pd) {
  pd %>% 
    styler:::post_visit(c(styler:::set_multi_line, 
                          styler:::update_newlines))
}

pd_to_text <- function(pd) {
  base_indention <- 0 # assume this
  start_line <- 1 # usually this, unless roxygen
  indent_character <- " " #
  pd1 <- pd %>% 
    styler:::context_to_terminals(outer_lag_newlines = 0L,
                                  outer_indent = 0L,
                                  outer_spaces = 0L,
                                  outer_indention_refs = NA)
  
  flattened_pd <- vctrs:::vec_rbind(!!!styler:::post_visit_one(pd1, 
                                                               styler:::extract_terminals)) %>% 
    styler:::enrich_terminals(transformers$use_raw_indention) %>% 
    styler:::apply_ref_indention() %>% 
    styler:::set_regex_indention(pattern = NULL, # transformers$reindention$regex_pattern, 
                                 target_indention = 0, # transformers$reindention$indention, 
                                 comments_only = TRUE #transformers$reindention$comments_only)
    ) 
  is_on_newline <- flattened_pd$lag_newlines > 0L
  is_on_newline[1L] <- TRUE
  flattened_pd$lag_spaces[is_on_newline] <- flattened_pd$lag_spaces[is_on_newline] + 
    base_indention
  serialized_transformed_text <- styler:::serialize_parse_data_flattened(flattened_pd, 
                                                                         indent_character = indent_character)
  text_out <- c(rep("", start_line - as.integer(start_line > 0L)), serialized_transformed_text)
  text_out <- unlist(text_out, use.names = FALSE)
  styler:::verify_roundtrip(text, text_out, parsable_only = !styler:::parse_tree_must_be_identical(transformers))
  text_out <- styler:::convert_newlines_to_linebreaks(text_out)
  # if (styler:::cache_is_activated()) {
  #   cache_by_expression(text_out, transformers, more_specs = more_specs)
  # }
  styler:::construct_vertical(text_out)
}


try_rule <- function(text,funs=NULL,line_break=NULL) {
  
  if (is_function(line_break)) {
    line_break <- list(line_break)
  }
  if (is_function(funs)) {
    funs <- list(funs)
  }
  text %>%
    text_to_pd() %>%
    styler:::post_visit(line_break) %>%
    middle_stuff() %>%
    styler:::pre_visit(funs) %>%
    pd_to_text()
}


#########################

# style <- tidyverse_style %>% add_narration_to_style
style <- tidyverse_style
transformers <- style()
##### 1
style_text(text,style=style)
style_text(text,transformers=transformers)

##### 2
text %>%
  text_to_pd() %>%
  styler:::post_visit(transformers$line_break) %>%
  middle_stuff() %>%
  styler:::pre_visit(c(transformers$space, 
                       transformers$indention, 
                       transformers$token)) %>%
  pd_to_text()






# verbose execution ----------------------------------------------------------------



tidyverse_style_narrated <- add_narration_to_style(tidyverse_style)
# normal execution
style_text(code, style = tidyverse_style)
# run with comments
style_text(code, style = tidyverse_style_narrated)

style_text(code, style = ystyle)

# isolate rules -----------------------------------------------------------

# use to figure out individual functions
fun <- function(group,name,fun,pd0,pd1,changed) {
  if (changed) {
    cli::cli_alert(cli::col_yellow("Running: [{group}] {name}"))
    
    if (is.na(global_fun)) {
      global_fun <<- str_glue("[{group}] {name}") %>% as.character()  
    }
  }
}
findrule <- function(code, style=tidyverse_style,fn=fun) {
  global_fun <<- NA_character_
  
  doc_style <- add_narration_to_style(tidyverse_style,esc_fun = fn)
  newcode <- style_text(code, style = doc_style) %>%
    paste(collapse="\n")
  tibble(text=code,newtext=newcode,fun=global_fun)
}

tidyverse_style



`styler:::remove_space_before_closing_paren`: `sqrt(4     )` becomes `sqrt(4)`
# space
try_rule("sqrt(4  )",styler:::remove_space_before_closing_paren)
try_rule("sqrt(  4)",styler:::remove_space_after_opening_paren)
try_rule("c  (1, 2, 3)",styler:::remove_space_before_opening_paren)
try_rule("if(x) 1",styler:::add_space_after_for_if_while)
try_rule("c(1  , 2)",styler:::remove_space_before_comma)
try_rule("x  +y",partial(styler:::style_space_around_math_token, strict=TRUE, zero="'^'", one=c("'+'", "'-'", "'*'", "'/'")) )
try_rule("y~  x",partial(styler:::style_space_around_tilde,strict=TRUE))
try_rule("x  <- 1",partial(styler:::set_space_around_operator, strict = TRUE))
try_rule("x  <-1",partial(styler:::set_space_around_operator, strict = TRUE))
try_rule("!  x",styler:::remove_space_after_excl)
try_rule("!!  var",styler:::set_space_after_bang_bang)
try_rule("mtcars  $  mpg",styler:::remove_space_around_dollar)
try_rule("function  (x) x",styler:::remove_space_after_function_declaration)
try_rule("1  :  10",styler:::remove_space_around_colons)
try_rule("#comment here",styler:::start_comments_with_space)
try_rule("(-  x)",styler:::remove_space_after_unary_plus_minus_nested)
try_rule("2 + 2   # comment",styler:::set_space_before_comments)
try_rule("if (x)1",styler:::set_space_between_levels)
try_rule("switch(x, a =, b = 1)",styler:::set_space_between_eq_sub_and_comma)
try_rule("fun({{ var    }})",styler:::set_space_in_curly)



# 
# $line_break
# [1] "remove_empty_lines_after_opening_and_before_closing_braces"
try_rule("{\n\n\n\n  1\n\n}",styler:::remove_empty_lines_after_opening_and_before_closing_braces)

# [2] "set_line_break_around_comma_and_or"                        
try_rule("xxxxxxxxxxxxxxx")
# [3] "set_line_break_after_assignment"                           
try_rule("xxxxxxxxxxxxxxx")
# [4] "set_line_break_before_curly_opening"                       
try_rule("xxxxxxxxxxxxxxx")
# [5] "remove_line_break_before_round_closing_after_curly"        
try_rule("xxxxxxxxxxxxxxx")
# [6] "remove_line_breaks_in_function_declaration"                
try_rule("xxxxxxxxxxxxxxx")
# [7] "set_line_breaks_between_top_level_exprs"   
try_rule("xxxxxxxxxxxxxxx")
# [8] "style_line_break_around_curly"                             
try_rule("xxxxxxxxxxxxxxx")
# [9] "set_line_break_around_curly_curly"                         
try_rule("xxxxxxxxxxxxxxx")
# [10] "set_line_break_before_closing_call"                        
try_rule("xxxxxxxxxxxxxxx")
# [11] "set_line_break_after_opening_if_call_is_multi_line"        
try_rule("xxxxxxxxxxxxxxx")
# [12] "remove_line_break_in_fun_call"                             
try_rule("xxxxxxxxxxxxxxx")
# [13] "add_line_break_after_pipe"                                 
try_rule("mtcars %>%\n\nglimpse()",styler:::add_line_break_after_pipe)
# [14] "set_line_break_after_ggplot2_plus"                         
try_rule("ggplot(data) + geom_point(aes(x, y))",styler:::xxxxxxxxxxx)
tx$line_break$set_line_break_after_assignment

# $indention
# [1] "indent_braces"
try_rule("xxxxxxxxxxxxxxxx")
# [2] "unindent_function_declaration"                  
try_rule("xxxxxxxxxxxxxxxx")
# [3] "indent_op"                              
try_rule("x +\n3",,styler:::xxxxxxxxxxx)
# [4] "indent_eq_sub"
try_rule("xxxxxxxxxxxxxxxx")
# [5] "indent_without_paren"
try_rule("xxxxxxxxxxxxxxxx")
# [6] "update_indention_reference_function_declaration"
try_rule("xxxxxxxxxxxxxxxx")

# $token
# [1] "fix_quotes"
try_rule("xxxxxxxxxxxxxxxx")
# [2] "force_assignment_op"                                
try_rule("xxxxxxxxxxxxxxxx")
# [3] "resolve_semicolon"
try_rule("xxxxxxxxxxxxxxxx")
# [4] "add_brackets_in_pipe"
try_rule("xxxxxxxxxxxxxxxx")
# [5] "wrap_if_else_while_for_function_multi_line_in_curly"
I have the full test suite too. Let me check the test fixtures, which show exactly what each rule does, and then generate verified before/after examples using the real style_text() function.

All examples below are verified by actually running them through styler::style_text() (installed the dev version from GitHub, 1.11.0.9001 — a few rules have been renamed since CRAN 1.10.x, e.g. remove_space_after_fun_dec → remove_space_after_function_declaration, but the behavior is the same).
# 
# space rules (spacing on one line)
# Rule	Example
# remove_space_before_closing_paren	sqrt(4     ) → sqrt(4)
# remove_space_before_opening_paren	sqrt (4) → sqrt(4)
# add_space_after_for_if_while	if(x) 1 → if (x) 1
# remove_space_before_comma	f(1 ,2) → f(1, 2)
# style_space_around_math_token	1+1 → 1 + 1, but 2^2 stays 2^2 (no space around ^)
# style_space_around_tilde	y~x → y ~ x
# spacing_around_op	a<-1 → a <- 1
# remove_space_after_opening_paren	f( 1) → f(1)
# remove_space_after_excl	! x → !x
# set_space_after_bang_bang	!! x → !!x (rlang's !!)
# remove_space_around_dollar	df $ x → df$x
# remove_space_after_function_declaration	function (x) x → function(x) x
# remove_space_around_colons	1 : 10 → 1:10
# start_comments_with_space	#comment → # comment
# remove_space_after_unary_plus_minus_nested	(- 1) → (-1)
# spacing_before_comments	1# comment → 1 # comment
# set_space_between_levels	if (x)1 → if (x) 1 (space after the ) of the condition)
# set_space_between_eq_sub_and_comma	switch(x, a =, b = 1) → switch(x, a = , b = 1)
# set_space_in_curly	f({{x}}) → f({{ x }}) (the {{ }} embrace operator)
# line_break rules (only active when scope >= "line_breaks")
# Rule	Example
# remove_empty_lines_after_opening_and_before_closing_braces	{\n\n  1\n\n} → {\n  1\n}
# set_line_break_around_comma_and_or	f(1\n  , 2) → f(\n  1,\n  2\n) (moves the leading , to the end of the previous line)
# set_line_break_after_assignment	x <-\n\n\n  1 → x <-\n  1 (collapses extra blank lines right after <-)
# set_line_break_before_curly_opening	if (x)\n{ → if (x) {
# remove_line_break_before_round_closing_after_curly	f(function(x) {\n  x\n}\n) → f(function(x) {\n  x\n})
# remove_line_breaks_in_function_declaration	collapses excess blank lines inside a multi-line function(...) header (interacts with the "multi-line call" rule below, which then re-expands one-arg-per-line)
# set_line_breaks_between_top_level_exprs	caps blank lines between top-level statements at 2: x <- 1\n\n\n\n\ny <- 2 → x <- 1\n\n\ny <- 2
# style_line_break_around_curly	function(x) {1; 2} → function(x) {\n  1\n  2\n}
# set_line_break_around_curly_curly	summarise(df, {{\n  var\n}}) → summarise(df, {{ var }})
# set_line_break_before_closing_call	f(\n  1) → f(\n  1\n)
# set_line_break_after_opening_if_call_is_multi_line	f(1,\n  2) → f(\n  1,\n  2\n)
# remove_line_break_in_fun_call	f(\n) → f()
# add_line_break_after_pipe	df %>% filter(x) %>% mutate(y) → df %>%\n  filter(x) %>%\n  mutate(y)
# set_line_break_after_ggplot2_plus	inside a ggplot(...) chain, moves a + that starts a line to the end of the previous line (mirrors the pipe rule above, but only when the call chain begins with ggplot()
# token rules (only active when scope >= "tokens", the default)
# Rule	Example
# fix_quotes	'hello' → "hello"
# force_assignment_op	x = 1 → x <- 1
# resolve_semicolon	x <- 1; y <- 2 → two separate lines
# add_brackets_in_pipe	df %>%\n  na.omit → df %>%\n  na.omit()
# wrap_if_else_while_for_function_multi_line_in_curly	if (x)\n  1\nelse\n  2 → if (x) {\n  1\n} else {\n  2\n}
# indention rules
# Rule	Example
# indent_braces	if (x) {\n1\n} → if (x) {\n  1\n}
# unindent_function_declaration	function(\n    x,\n    y) (4-space "single-indent" style) → re-indented to the standard 2 spaces
# indent_op	1 +\n2 → 1 +\n  2
# indent_eq_sub	f(x =\n      1) → f(x =\n  1) (continuation after = normalized to 2 spaces)
# indent_without_paren	if (x)\n  1\nelse\n  2 (braceless, scope = "indention" only) → indents the branches consistently
# update_indention_reference_function_declaration	function(x, y,\nz) { → function(x, y,\n  z) { (re-anchors indentation of continuation lines to the function( reference)

# s.e <- substitute(expression(a + b), list(a = 1))

# add_brackets_in_pipe
try_rule("df %>%\nna.omit",styler:::add_brackets_in_pipe)



debugonce(styler:::add_brackets_in_pipe_one)

pd <- text_to_pd("df %>%\nna.omit") %>% middle_stuff()
pd1 <- pd %>% styler:::add_brackets_in_pipe()
pd$child[[1]]$child[[3]]$text
pd1$child[[1]]$child[[3]]$text

debugonce(styler:::add_brackets_in_pipe_one)


pd
next_non_comment <- next_non_comment(pd, pos)
rh_child <- pd$child[[next_non_comment]]

if (nrow(rh_child) < 2L && rh_child$token == "SYMBOL") {
  child <- pd$child[[next_non_comment]]
  pd$text
  child$text
  new_pos_ids <- create_pos_ids(child, 1L, after = TRUE, n = 2L)
  new_pd <- create_tokens(texts = c("(", ")"), 
                          lag_newlines = rep(0L, 2L), 
                          spaces = 0L, 
                          pos_ids = new_pos_ids, 
                          token_before = c(child$token[1L], "'('"), 
                          token_after = c("')'", child$token_after[1L]), 
                          indention_ref_pos_ids = NA, 
                          indents = child$indent[1L], 
                          tokens = c("'('", "')'"), 
                          terminal = TRUE, 
                          child = NULL, 
                          stylerignore = child$stylerignore[1L], 
                          block = NA, 
                          is_cached = FALSE)
  
  pd$pos_id
  pd$child[[next_non_comment]] <- vec_rbind(pd$child[[next_non_comment]], 
                                            new_pd) %>% arrange_pos_id()
}
pd




pd3 %>% styler:::add_brackets_in_pipe_one(2)



pd <- text_to_pd("df %>%\nna.omit") %>% middle_stuff() %>%
  {.$child[[1]]$child[[3]]}



newpd <- styler:::add_brackets_in_pipe(pd)
newpd %>% dt


newpd$child[[1]]$child[[3]]

pd <- pd$child[[3]]$text



styler:::add_brackets_in_pipe_one(pd,2)

styler:::add_brackets_in_pipe_one
styler:::add_brackets_in_pipe_one(pd)
styler:::add_brackets_in_pipe
styler:::add_brackets_in_pipe_child


# "df"      "%>%"     "na.omit"


pd$text
# if (!identical(pd$text[next_non_comment(pd, 0L)], "substitute")) {
#   pd$child <- map(pd$child, add_brackets_in_pipe_child)
# }
# pd

style_text()
styler:::add_brackets_in_pipe_child
styler:::add_brackets_in_pipe_one

# new style ---------------------------------------------------------------




code <- "nn <- c(1, 1.25, 1.5, 1.75, 2, 2.25, 2.5, 2.75, 3, 3.25, 3.5, 3.75, 4, 4.25, 4.5, 
  4.75, 5, 5.25, 5.5, 5.75, 6, 6.25, 6.5, 6.75, 7, 7.25, 7.5, 7.75, 8, 8.25, 
  8.5, 8.75, 9, 9.25, 9.5, 9.75, 10, 10.25, 10.5, 10.75, 11, 11.25, 11.5, 11.75, 
  12, 12.25, 12.5, 12.75, 13, 13.25, 13.5, 13.75, 14, 14.25, 14.5, 14.75, 15, 
  90, 90.25, 90.5, 90.75, 91, 91.25, 91.5, 91.75, 92, 92.25, 92.5, 92.75, 93, 
  93.25, 93.5, 93.75, 94, 94.25, 94.5, 94.75, 95, 95.25, 95.5, 95.75, 96, 96.25, 
  96.5, 96.75, 97, 97.25, 97.5, 97.75, 98, 98.25, 98.5, 98.75, 99, 99.25, 99.5, 
  99.75, 100)"



var1<-1;var2<-2;add<-function(x,y){answer<-var1+var2;return(answer)};var3<-add(var1,var2);print(var3< -1)


c(1,
  2,    3,
  4,    5,  5  + 1
)

c(1,2,3,4,5,5+1)


code <- "
c(1,
2,    3,
4,    5,  5  + 1

)
"

code <- "
x <- 1 +
  2
y <- 3 + 4 +
  5 + 6
# 123 + 3; print('asdf')


sqrt( 3 +
  6)
  
fun <- function(x) {
  x <- 1
  y <- 2
  return(x+
  y)
}
  
"



remove_comments <- function(pd) {
  is_comment <- pd$token == "COMMENT"
  pd[!is_comment,]
}

remove_all_spaces <- function(pd) {
  reserved <- pd$token %in% c(
    "IF", "ELSE", "FOR", "WHILE", "IN",
    "GT", "LT"
  )
  to_replace <- (!reserved) & (!styler:::lead(reserved, default = FALSE))
  pd$spaces[to_replace] <- rep(0L, sum(to_replace))
  pd
}


add_semi_colon <- function(pd) {
  # pd=code %>% text_to_pd() %>% middle_stuff()  
  is_expr <- pd$token %in% c("expr", "expr_or_assign_or_help")
  # if (any(pd$text=="1000")) {
  
  # }
  print(pd$text)    
  # pd$text %>% dt
  
  needs_semicolon <- which(is_expr & styler:::lag(is_expr,default=FALSE))
  pd$lag_newlines[needs_semicolon] <- 0L
  pd$space[needs_semicolon] <- 0L
  semicolon_pos_id <- map_dbl(needs_semicolon,~styler:::create_pos_ids(pd,.x))
  n_semicolons <- length(needs_semicolon)
  semicolon_pds <- styler:::create_tokens(
    tokens = rep("';'", times=n_semicolons),
    texts = rep(";", times=n_semicolons),
    pos_ids = semicolon_pos_id,
    token_before = NA_character_,
    token_after = NA_character_,
    indents = 0L,
    stylerignore = FALSE 
  )
  newpd <- vctrs::vec_rbind(pd,semicolon_pds) %>% styler:::arrange_pos_id()
  # newpd %>% dt()
  return(newpd)
}

log_pairs <- function(pd,criteria) {
  criteria <- enquo(criteria)
  pd2 <- pd %>%
    mutate(text_pair=paste0(lag(text),"==",text),
           token_pair=paste0(lag(token),"==",token)) %>%
    filter(!!criteria) %>%
    select(text_pair,token_pair,lag_newlines)
  if (nrow(pd2)>0) {
    pd2 <- pd2[-1,,drop=FALSE]
    env <- globalenv()
    xxx <- get("xx",envir=env)
    all <- bind_rows(xxx,pd2)
    assign("xx",all,envir=env)
  }
}

remove_all_line_breaks <- function(pd) {
  
  has_line_break <- pd$lag_newlines>0
  hanging_punctuation <- c(styler:::math_token, styler:::logical_token, 
                           styler:::special_token, "PIPE", "LEFT_ASSIGN", 
                           "RIGHT_ASSIGN", "EQ_FORMALS",
                           "EQ_ASSIGN", "EQ_SUB", "'$'", "'~'", "','",
                           "'('", "'{'", "'['", "LBB")
  t0 <- lag(pd$token)
  t1 <- pd$token
  remove_line_break <- 
    has_line_break & 
    (
      t0 %in% hanging_punctuation | 
        t1 %in% c("')'","'}'","']'") 
    ) & 
    !(t0=="COMMENT" & t1!="COMMENT")
  pd$lag_newlines[remove_line_break] <- 0
  pd
}

asdf <- function(pd) {
  log_pairs(pd)
  pd
}


one_line_style <- function(scope = "tokens") {
  scope <- scope_normalize(scope)
  create_style_guide(
    token  = list(remove_comments,
                  add_semi_colon=add_semi_colon,
                  remove_all_line_breaks=remove_all_line_breaks,
                  asdf),
    space=list(remove_all_spaces),
    style_guide_name  = "oneliner::one_line_style@https://github.com/lorenzwalthert",
    style_guide_version = "0.1.0"
  )
  # space  = list(remove_all_spaces=remove_all_spaces),
  
  # token = list(add_semi_colon=add_semi_colon),
}

code <- "
a <- 1 +
  2
b <- 3 + 4 + (
  5 + 6)
# comment here
c <- a * b * 2
1000
d <- 
  c + sqrt( 3 +   # comment here
  6
  )
fun <- function(x) {
  x <- 1
  y <- (2
    )
  return(x+
  y)
}
e =
  d + fun(3) - 14
f <-
  e %>% 
  sqrt()


print(f)
"

xx <<- NULL

newcode <- style_text(code,style=one_line_style) 
newcode
newcode %>% copy.to.clipboard()


eval(parse(text=newcode))
xx %>% dt()

# style_text(code,transformers=transformers)


# one_line_style_narrated <- add_narration_to_style(one_line_style)
# transformers <- one_line_style_narrated()


# WHY
# code <- "12;"
# code <- "12 + 3;"
# style_text(
#   code,
#   style = xx
# )
# dd_brackets_in_pipe_one <- function(pd, pos) {
#   next_non_comment <- next_non_comment(pd, pos)
#   rh_child <- pd$child[[next_non_comment]]
#   if (nrow(rh_child) < 2L && rh_child$token == "SYMBOL") {
#     child <- pd$child[[next_non_comment]]
#     new_pos_ids <- create_pos_ids(child, 1L, after = TRUE, n = 2L)
#     new_pd <- create_tokens(
#       texts = c("(", ")"),
#       lag_newlines = rep(0L, 2L),
#       spaces = 0L,
#       pos_ids = new_pos_ids,
#       token_before = c(child$token[1L], "'('"),
#       token_after = c("')'", child$token_after[1L]),
#       indention_ref_pos_ids = NA,
#       indents = child$indent[1L],
#       tokens = c("'('", "')'"),
#       terminal = TRUE,
#       child = NULL,
#       stylerignore = child$stylerignore[1L],
#       # block???
#       block = NA,
#       is_cached = FALSE
#     )
#     pd$child[[next_non_comment]] <- vec_rbind(pd$child[[next_non_comment]], new_pd) %>%
#       arrange_pos_id()
#   }
#   pd
# }



debugonce(add_semi_colon)

style_text(code,style=tidyverse_style)

style_text(code,style=xx)





debugonce(style_text)

tidyverse_style()
# debugonce(add_semi_colon)

debugonce(styler:::parse_transform_serialize_r_block)
style_text(code,transformers = transformers)


code <- "var1 <- 1
  var2 <- 2


1
2
3 +1;   x <- 1

add <- function(x, y) {
  answer <- var1 + var2
  # this is a comment
  return(answer)
}
var3 <- add(var1,var2)
print(var3 < -1)"

code <- "{var1 <- 1
  var2 <- 2


1
2
3 +1;   x <- 1

add <- function(x, y) {
  answer <- var1 + var2
  # this is a comment
  return(answer)
}
var3 <- add(var1,var2)
print(var3 < -1)}"


code <- "   xx = 1 + 1
yy <- 2+2
zz <- 3+3"

code <- "var1 <- 1
  var2 <- 2


1
2
3 +1

add <- function(x, y) {
  answer <- var1 + var2
  # this is a comment
  return(answer)
}
var3 <- add(var1,var2)
print(var3 < -1)"

pd %>% dt()
pd$text
pd <- code %>%
  text_to_pd() 

kill_space <- function(pd) {
  
  
  
  
  
  i_adjacent_exprs <- pd$token=="expr" & lag(pd$token=="expr",default=FALSE)
  
  pd2 <- pd$lag_newlines[i_adjacent_exprs]
  
  
  pd %>% select(text,token,newlines,lag_newlines) %>% dt()
  
  pd$token=="expr"
  
  
  
  
}


pd %>% dt()
pd %>% select(text,token,spaces,newlines) %>% dt()

try_rule(code,remove_all_spaces)
try_rule(code,remove_comments)
try_rule(code,remove_all_line_breaks)


try_rule(code,line_break = add_semi_colon)
add_semi_colon
add_semi_colon

try_rule(code,remove_all_spaces)

code %>%
  text_to_pd() %>%
  middle_stuff() %>%
  styler:::pre_visit(funs=NULL) %>%
  pd_to_text()

c(remove_all_spaces,
  remove_comments,
  add_semi_colon,
  remove_all_line_breaks)


space  = list(remove_all_spaces=remove_all_spaces),
token  = list(remove_comments=remove_comments, 
              add_semi_colon=add_semi_colon, 
              remove_all_line_breaks=remove_all_line_breaks),

token  = list(remove_comments=remove_comments, 
              add_semi_colon=add_semi_colon, 
              remove_all_line_breaks=remove_all_line_breaks),
indention = list(identity),


code <- "x <- 1 # TODO: check value"
pd <- compute_parse_data_nested(code)
is_comment(pd)


#############
pd <- pd0

df <- traverse(pd,expr={
  if (!is.data.frame(.obj)) {
    return(NULL)
  }
  # names(pd)
  # pd %>% dt()
  sum <- .obj %>%
    summarize(across(.cols=-c(child),.fns=~paste(.x,collapse=",")))
  tibble(level=.level,
         i=.index,
         code=paste(.obj$text,collapse="\n"),
         class=class(.obj)) %>%
    cbind(sum)
}) %>% list_rbind()


#############
pd1 <- run_transformers(pd0, transformers)
debugonce(run_transformers)


styled_code <- pd_to_text(pd1,transformers)
cat(styled_code)

transformers$space
transformers$indention
transformers$token


transformers$space$remove_all_spaces
transformers$indention
transformers$token$remove_comments
transformers$token$add_semi_colon
transformers$token$remove_all_line_breaks

style_text(code,style=style)










