

gsub("-", "\U2212", print.default(yat))


txt <- c(
  "x + y, x - y", "x - y", "x * y", "x / y",
  "x %+-% y", "x %/% y", "x %*% y", "x %.% y",
  "x[i]", "x^2",
  "paste(x, y, z)", "sqrt(x)", "sqrt(x, y)",
  "x == y", "x != y", "x < y", "x <= y",
  "!x", "x %~~% y", "x %=~% y", "x %==% y", "x %prop% y",
  "x %~% y", "plain(x)",
  "bold(x)", "italic(x)", "bolditalic(x)", "symbol(x)",
  "list(x, y, z)",
  "...",
  "cdots",
  "ldots",
  "x %up% y",
  "alpha -- omega",
  "infinity",
  "32*degree",
  "-80*degree*C",
  "30*minute",
  "scriptstyle(x)",
  "scriptscriptstyle(x)",
  "underline(x)",
  "x ~~ y",
  "frac(x, y)",
  "sum(x[i], i==1, n)",
  "x^{y + z}",
  "x^(y + z)",
  "bgroup('(',atop(x,y),')')",
  "group(lceil, x, rceil)",
  "group(langle, list(x, y), rangle)",
  "'regular text'",
  "regular text",
  "xxxx",
  "xxxx",
  "xxxx",
  "xxxx"
)

# \u2212
# demo(plotmath)

nrow <- sqrt(length(txt)) %>% ceiling() 
df <- tibble(txt=txt) %>%
  mutate(i=row_number(),
         row=i %/% nrow,
         col=i %% nrow) %>%
  pivot_wider(id_cols=row,names_from=col,values_from=txt)


ggtexttable(df,theme = ttheme(tbody.style = tbody_style(parse=TRUE)))



ggplot() + 
  geom_text(data=df,aes(x=50,y=i,label=txt),parse=TRUE) +
  annotate(geom = "text", x = 25, y = 3, 
           label = deparse(bquote(P==0.001*";"~R^2==0.45)), 
           parse = TRUE, size = 5) +
  geom_text(x = 25, y = 9, aes(label = deparse(bquote(''^137*Cs))), parse = TRUE, size = 5) +
  geom_text(x = 25, y = 7, aes(label = deparse(bquote(R[adj]^2==0.41))), parse = TRUE, size = 5) +
  labs(title = bquote("Use quotes to mark normal text"~(mu*g/L)~(over(mu*g, L))~sqrt(x)),
       subtitle = bquote("Use ~ to link elements together with a space (or more!)"~~~~~alpha*","~beta*","~Gamma),
       caption = bquote(sum(x[i], i==1, n))) +
  scale_x_continuous(limits=c(0,100))





library(ggplot2)
library(palmerpenguins) # data
library(dplyr)  # manipulate the data
p$sp
p <- mutate(penguins, sp = paste0("'", species, "'[(italic(", island, "))]"))

samples <- count(p, sp, species, island) |>
  mutate(label = paste0("n['(", species, ", ", island, ")'] == ", n))
samples
labels <- list("x" = paste0("'Bill Length'~mm[(", paste0(range(p$year), collapse = "-"), ")]"),
               "y" = paste0("'Flipper Length'~mm[(", paste0(range(p$year), collapse = "-"), ")]"))
labels
ggplot(data = p, aes(x = bill_length_mm, y = flipper_length_mm)) +
  geom_point() +
  geom_text(data = samples, x = -Inf, y = +Inf, aes(label = label), parse = TRUE,
            hjust = -0.1, vjust = 1.5) +
  facet_wrap(~ sp, labeller = label_parsed)

library(ggplot2)
library(palmerpenguins) # data
library(dplyr)  # manipulate the data
library(tidyr)  # unnest() to convert nested data back into a regular data frame
library(purrr)  # map() to loop over models and leables
library(broom)  # tidy() to extract model information

p <- penguins |>
  add_count(species) |>
  mutate(sp = paste0("'", species, "'"),
         sp = if_else(species == "Adelie", paste0(sp, "^{1}"), sp),
         sp = paste0(sp, "~(n == frac(", n, ", ", n(), "))"))

stats <- p |>
  nest(data = -"sp") |>
  mutate(model = map(data, \(x) lm(flipper_length_mm ~ bill_length_mm, data = x)),
         labels = map(model, glance)) |>
  unnest(cols = "labels") |>
  mutate(p_val = round(p.value, 3),
         p_val = if_else(p.value < 0.001, "<0.001", paste0("=='", format(p.value, nsmall = 3), "'")),
         stats = paste0("P", p_val, "*';'~{R^2}[adj]==", round(adj.r.squared, 2)))


labels <- list("x" = paste0("'Bill Length'~mm[(", paste0(range(p$year), collapse = "-"), ")]"),
               "y" = paste0("'Flipper Length'~mm[(", paste0(range(p$year), collapse = "-"), ")]"))
labels


ggplot(data = p, aes(x = bill_length_mm, y = flipper_length_mm)) +
  geom_point() +
  geom_text(data = stats, x = -Inf, y = +Inf, aes(label = stats), parse = TRUE,
            hjust = -0.1, vjust = 1.5) +
  labs(x = parse(text = labels$x),
       y = parse(text = labels$y),
       caption = parse(text = "''^1*'Sampled on all three islands'")) +
  scale_y_continuous(limits = \(x) c(x[1], x[2]*1.04)) +
  facet_wrap(~ sp, labeller = label_parsed)
