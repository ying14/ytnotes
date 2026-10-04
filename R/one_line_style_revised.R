# one_line_style_revised.R
#
# A revision of your one_line_style(). Same architecture (custom styler style
# guide: comment removal + semicolon insertion at the token level, spacing at
# the space level), with these changes:
#
#  1. Spacing uses a character-class test instead of a keyword whitelist:
#     a space is kept between two tokens only if the last character of the left
#     one and the first character of the right one are both "word" characters
#     (letters/digits/./_) or both "operator" characters. That covers
#     `repeat break` (REPEAT was missing from your list), `1 else 2`, and
#     `x< -1` in one rule, and it no longer keeps `if (x > 0)`-style spaces or
#     leaves the original irregular spacing in place.
#  2. ALL line breaks are removed. That is safe here because add_semi_colon()
#     already puts a `;` between every pair of adjacent statements, so no
#     newline is needed as a separator any more. Your hanging_punctuation list
#     left newlines behind after `if (...)`, `else`, `function(...)`,
#     `for (...)`, after an explicit `;`, and before a leading operator.
#  3. add_semi_colon(): `pd$space` (typo, silently created a new column) is now
#     `pd$spaces`, applied to the row BEFORE the `;` so no space is left in
#     front of it.
#  4. one_line_code() turns styler's cache OFF for the call (see below) and
#     neutralises `# styler: off/on` markers, both of which corrupt this style.
#  5. Optional wrapping at `;` so no line exceeds `max_chars` (RStudio is slow
#     on very long lines). Break points come from the parser's `;` tokens, so a
#     `;` inside a string literal is never used.
#  6. No dependency on attached tidyverse packages (lag/map_dbl/%>% were
#     unqualified); everything is namespaced.
#
# Caveats:
#  - Relies on styler internals (styler:::lag, lead, create_pos_ids,
#    create_tokens, arrange_pos_id). Tested with styler 1.11.0.9001; pin the
#    version, since internals change between releases.
#  - Comments are dropped (a `#` would swallow the rest of a one-line program).
#  - A single statement longer than `max_chars` cannot be split; wrap errors.

# ---- token-level rules ------------------------------------------------------

remove_comments <- function(pd) {
  pd[pd$token != "COMMENT", ]
}

add_semi_colon <- function(pd) {
  is_expr <- pd$token %in% c("expr", "expr_or_assign_or_help")
  needs_semicolon <- which(is_expr & styler:::lag(is_expr, default = FALSE))
  n <- length(needs_semicolon)
  if (n == 0L) return(pd)

  pd$lag_newlines[needs_semicolon] <- 0L
  pd$newlines[needs_semicolon - 1L] <- 0L
  pd$spaces[needs_semicolon - 1L] <- 0L      # no space between statement and `;`

  pos_ids <- vapply(needs_semicolon, function(i) styler:::create_pos_ids(pd, i), numeric(1))
  semicolons <- styler:::create_tokens(
    tokens = rep("';'", n), texts = rep(";", n), pos_ids = pos_ids,
    token_before = NA_character_, token_after = NA_character_,
    indents = 0L, stylerignore = FALSE
  )
  styler:::arrange_pos_id(vctrs::vec_rbind(pd, semicolons))
}

remove_all_line_breaks <- function(pd) {
  pd$lag_newlines[] <- 0L
  pd
}

# ---- space-level rule -------------------------------------------------------

is_word_char <- function(ch) grepl("^[A-Za-z0-9._]$", ch)
is_op_char   <- function(ch) grepl("^[-+*/^<>=!&|~:@$]$", ch)

remove_all_spaces <- function(pd) {
  # Look "through" comments: they are removed later in the token step, so the
  # tokens on either side of one end up adjacent (e.g. `x <  # c` + `-1`).
  keep <- which(pd$token != "COMMENT")
  txt <- pd$text[keep]
  last_ch  <- substring(txt, nchar(txt), nchar(txt))
  first_ch <- substring(c(txt[-1L], ""), 1L, 1L)
  need_space <- (is_word_char(last_ch) & is_word_char(first_ch)) |
    (is_op_char(last_ch) & is_op_char(first_ch))
  pd$spaces[keep] <- as.integer(need_space)
  pd$spaces[setdiff(seq_len(nrow(pd)), keep)] <- 0L
  pd
}

# ---- style guide ------------------------------------------------------------

one_line_style <- function() {
  styler::create_style_guide(
    token = list(
      remove_comments = remove_comments,
      add_semi_colon = add_semi_colon,
      remove_all_line_breaks = remove_all_line_breaks
    ),
    space = list(remove_all_spaces = remove_all_spaces),
    style_guide_name = "onelinestyle",
    style_guide_version = "0.2"
  )
}

# ---- wrapping ---------------------------------------------------------------

# Break `text` (compressed code) after `;` tokens so that no line is longer than
# `max_chars`, packing as much as possible on each line. Break points are the
# parser's own `;` tokens, so `;` inside strings/backticks is never touched.
wrap_at_semicolons <- function(text, max_chars = 4096L) {
  n <- nchar(text)
  if (n <= max_chars) return(text)

  pd <- utils::getParseData(parse(text = text, keep.source = TRUE), includeText = TRUE)
  tk <- pd[pd$terminal, ]
  tk <- tk[order(tk$line1, tk$col1), ]

  # Locate each token in the string by walking it in order (robust to tabs and
  # multi-line strings, which make (line, col) arithmetic unreliable).
  chars <- strsplit(text, "")[[1L]]
  pos <- 1L
  semi_pos <- integer(0)
  for (i in seq_len(nrow(tk))) {
    s <- tk$text[i]
    while (pos <= n && chars[pos] %in% c(" ", "\t", "\n", "\r")) pos <- pos + 1L
    len <- nchar(s)
    if (!identical(paste(chars[pos:(pos + len - 1L)], collapse = ""), s)) {
      stop("Internal error: could not align token ", i, " (", s, ") with the text.")
    }
    if (tk$token[i] == "';'") semi_pos <- c(semi_pos, pos)
    pos <- pos + len
  }

  cuts <- integer(0)
  start <- 1L
  last_ok <- NA_integer_
  for (cand in c(semi_pos, n)) {
    while (cand - start + 1L > max_chars) {
      if (is.na(last_ok) || last_ok < start) {
        stop("A single statement is longer than max_chars (", max_chars,
             "); there is no safe place to break it.")
      }
      cuts <- c(cuts, last_ok)
      start <- last_ok + 1L
      last_ok <- NA_integer_
    }
    last_ok <- cand
  }
  starts <- c(1L, cuts + 1L)
  ends <- c(cuts, n)
  paste(substring(text, starts, ends), collapse = "\n")
}

# ---- entry point ------------------------------------------------------------

#' Compress R code onto (as few as possible) lines.
#'
#' @param code Character vector of R code (lines or one string).
#' @param max_chars Maximum line length; `Inf` disables wrapping.
one_line_code <- function(code, max_chars = 4096L) {
  # styler's cache treats each top-level expression independently and skips
  # ones it has seen before -- but this style depends on NEIGHBOURING
  # expressions (semicolons), so a cache hit silently drops the `;`.
  # `# styler: off` regions likewise get mangled; disable the markers.
  op <- options(
    styler.cache_name = NULL,
    styler.ignore_start = "^$impossible^",
    styler.ignore_stop = "^$impossible^",
    styler.quiet = TRUE
  )
  on.exit(options(op), add = TRUE)

  out <- paste(suppressWarnings(styler::style_text(code, style = one_line_style)),
               collapse = "\n")
  if (is.finite(max_chars)) out <- wrap_at_semicolons(out, max_chars)
  out
}


  code <- "var1 <- 1
var2 <- 2
add <- function(x, y) {
  answer <- var1 + var2
  return(answer)
}
var3 <- add(var1,var2)
print(var3 < -1)"
  cat(one_line_code(code), "\n")
