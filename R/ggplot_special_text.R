
library(tidyverse)
library(rlang)



# For labels
# -This includes name argument in scale_XXX() as well as labs()
# -Direct Use: name = bquote(R^2)
# -Programmatic Use: name = parse(text = "R^2")
# For geoms
# -This includes geom_text(), geom_label(), annotate(geom = "text") etc.
# -Direct Use: label = deparse(bquote(R^2)), parse = TRUE1
# -Programmatic Use: label = "R^2", parse = TRUE
# -parse = TRUE tells the function to turn the text into an expression

# direct use, label: use expression...  bquote()
# programatic use, label: parse text... parse(text = ""))
# direct use, geom: deparse expression.... deparse(bquote()) [set parse=TRUE]
# programatic use, geom: deparse....       [set parse=TRUE]


# See ?plotmath or the Appendix table for how to code other symbols or
# expressions you want to use.
#
# Here are some suggestions…
#
# Use “~” to create a space (or two!) between elements
# Use “*” to combine different elements without a space (think of this like a ‘,’ in R)
# Use quotes “” to mark normal text which has spaces and punctuation
# Use quotes, ~ and * around punctutation as needed (e.g., alpha*","~beta)
# Use == for equals (see Appendix table for more examples)
# Use ''^137*Cs when you need to put superscript before an element

ggplot() +
  theme_bw() +
  # Use `bquote()` in labels
  scale_x_continuous(name = bquote("Measurement"~(mu*g/L))) +
  scale_y_continuous(name = bquote(M/g)) +
  labs(title = bquote("Use quotes to mark normal text"~(mu*g/L)~(over(mu*g, L))~sqrt(x)),
       subtitle = bquote("Use ~ to link elements together with a space (or more!)"~~~~~alpha*","~beta*","~Gamma),
       caption = bquote(sum(x[i], i==1, n))) +
  # Use `deparse(bquote())` along with `parse = TRUE` in geoms
  annotate(geom = "text", x = 0.5, y = 0.5, label = deparse(bquote(P==0.001*";"~R^2==0.45)), parse = TRUE, size = 5) +
  geom_text(x = 0.5, y = 0.48,
            aes(label = deparse(bquote(''^137*Cs))),
            parse = TRUE, size = 5) +
  geom_text(x = 0.5, y = 0.52,
            aes(label = deparse(bquote(R[adj]^2==0.41))),
            parse = TRUE, size = 5)

